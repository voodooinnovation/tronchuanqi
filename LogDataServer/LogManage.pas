unit LogManage;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, RzEdit, ExtCtrls, CheckLst, Menus, LDShare, Clipbrd;

type
  TLogDataManage = class

  private
    {procedure Initialize();
    procedure Finalize();}
  public

  end;

  TFrmLogManage = class(TForm)
    Panel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DateTimeEditBegin: TRzDateTimeEdit;
    DateTimeEditEnd: TRzDateTimeEdit;
    Label3: TLabel;
    ComboBoxCondition: TComboBox;
    EditSearch: TEdit;
    ButtonStart: TButton;
    Panel1: TPanel;
    ListView: TListView;
    CheckListBox: TCheckListBox;
    PopupMenu: TPopupMenu;
    PopupMenu_COPY: TMenuItem;
    PopupMenu_SELECTALL: TMenuItem;
    StatusBar: TStatusBar;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure CheckListBoxClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DateTimeEditBeginDateTimeChange(Sender: TObject;
      DateTime: TDateTime);
    procedure DateTimeEditEndDateTimeChange(Sender: TObject;
      DateTime: TDateTime);
    procedure TimerTimer(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure PopupMenu_COPYClick(Sender: TObject);
    procedure PopupMenu_SELECTALLClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddSearchFile(FileDir, FileName: string);
    procedure DoSearchFile(Path: string);
    procedure UnLoadLogDataList;
    procedure UnLoadLogFileList;
  public
    { Public declarations }
  end;

var
  FrmLogManage: TFrmLogManage;
  LogDataList: TStringList;
  LogFileList: TStringList;
  QuitFlag: Boolean = False;
  SearchStatus: Boolean = False;
  CmdArray: array[0..35 - 1] of TCmd = (    //命令数组 默认全选
    (Cmd: - 1; Check: True; Text: '全部动作'),
    (Cmd: 0; Check: True; Text: '取回物品'),
    (Cmd: 1; Check: True; Text: '存放物品'),
    (Cmd: 2; Check: True; Text: '炼制物品'),
    (Cmd: 3; Check: True; Text: '持久消失'),
    (Cmd: 4; Check: True; Text: '捡取物品'),
    (Cmd: 5; Check: True; Text: '制造物品'),
    (Cmd: 6; Check: True; Text: '销毁物品'),
    (Cmd: 7; Check: True; Text: '扔掉物品'),
    (Cmd: 8; Check: True; Text: '交易物品'),
    (Cmd: 9; Check: True; Text: '购买物品'),
    (Cmd: 10; Check: True; Text: '出售物品'),
    (Cmd: 11; Check: True; Text: '使用物品'),
    (Cmd: 12; Check: True; Text: '人物升级'),
    (Cmd: 13; Check: True; Text: '减少金币'),
    (Cmd: 14; Check: True; Text: '增加金币'),
    (Cmd: 15; Check: True; Text: '死亡掉落'),
    (Cmd: 16; Check: True; Text: '掉落物品'),
    (Cmd: 19; Check: True; Text: '人物死亡'),
    (Cmd: 20; Check: True; Text: '升级成功'),
    (Cmd: 21; Check: True; Text: '升级失败'),
    (Cmd: 22; Check: True; Text: '城堡取钱'),
    (Cmd: 23; Check: True; Text: '城堡存钱'),
    (Cmd: 24; Check: True; Text: '升级取回'),
    (Cmd: 25; Check: True; Text: '武器升级'),
    (Cmd: 26; Check: True; Text: '背包减少'),
    (Cmd: 27; Check: True; Text: '改变城主'),
    (Cmd: 111; Check: True; Text: '元宝改变'),
    (Cmd: 112; Check: True; Text: '能量改变'),
    (Cmd: 30; Check: True; Text: '商铺购买'),
    (Cmd: 31; Check: True; Text: '装备升级'),
    (Cmd: 32; Check: True; Text: '寄售物品'),
    (Cmd: 33; Check: True; Text: '寄售购买'),
    (Cmd: 34; Check: True; Text: '挑战物品'),
    (Cmd: 35; Check: True; Text: '摆摊物品')
    ); //26 测试武器升级

implementation
uses HUtil32;
{$R *.dfm}

function GetActString(nAct: Integer): string;
var
  I: Integer;
begin
  Result := '无法分析';
  if nAct >= 0 then begin
    for I := 0 to Length(CmdArray) - 1 do
      if CmdArray[I].Cmd = nAct then begin
        Result := CmdArray[I].Text;
        Exit;
      end;
  end;
end;

function GetActChecked(nAct: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if nAct >= 0 then begin
    for I := 0 to Length(CmdArray) - 1 do
      if (CmdArray[I].Cmd = nAct) and CmdArray[I].Check then begin
        Result := True;
        Exit;
      end;
  end;
end;

function GetSearch(ItemIndex: Integer; sSearch: string; LogData: pTLogData): Boolean;
var
  I: Integer;
begin
  Result := True;
  if ItemIndex <= 0 then Exit;
  case ItemIndex of
    1: Result := AnsiContainsText(LogData.sObjectName, sSearch);
    2: Result := AnsiContainsText(LogData.sItemName, sSearch);
    3: Result := LogData.nCount = Str_ToInt(sSearch, -1);
    4: Result := AnsiContainsText(LogData.sActObjectName, sSearch);
  end;
end;

function LastDirectoryName(Directory: string): string; //获取最后目录名字
var
  I: Integer;
begin
  Result := '';
  if Directory[Length(Directory)] = '\' then
    Directory := Copy(Directory, 1, Length(Directory) - 1); //去掉斜杠
  for I := Length(Directory) downto 1 do   //倒循环
    if Directory[I] = '\' then begin
      Result := Copy(Directory, I + 1, Length(Directory) - I + 1);
      break;
    end;
end;

procedure TFrmLogManage.UnLoadLogFileList;
var
  I: Integer;
begin
  for I := 0 to LogFileList.Count - 1 do begin
    TStringList(LogFileList.Objects[I]).Free;
  end;
  LogFileList.Clear;
end;

procedure TFrmLogManage.UnLoadLogDataList;
var
  I, II: Integer;
  List: TList;
begin
  for I := 0 to LogDataList.Count - 1 do begin
    List := TList(LogDataList.Objects[I]);
    for II := 0 to List.Count - 1 do begin
      Dispose(pTLogData(List.Items[II]));
    end;
    List.Free;
  end;
  LogDataList.Clear;
end;

procedure TFrmLogManage.AddSearchFile(FileDir, FileName: string);
var
  sFileDir: string;
  List: TStringList;
  I: Integer;
  boFound: Boolean;
begin
  sFileDir := LastDirectoryName(FileDir);//最后文件夹名字  日期
  if sFileDir <> '' then begin
    boFound := False;
    List := nil;
    for I := 0 to LogFileList.Count - 1 do begin   //循环
      if CompareText(LogFileList.Strings[I], sFileDir) = 0 then begin //对比寻找 logFileList中的日期
        List := TStringList(LogFileList.Objects[I]);
        boFound := True;
        Break;
      end;
    end;
    if not boFound then begin    //按文件夹名分list
      List := TStringList.Create;
      LogFileList.AddObject(sFileDir{日期}, List{列表});
    end;
    if List <> nil then begin
      List.Add(FileDir + FileName);
      //在列表中再次加入文件路径和名字
    end;
  end;
end;

procedure TFrmLogManage.DateTimeEditBeginDateTimeChange(Sender: TObject;
  DateTime: TDateTime);
begin
  if DateTime > DateTimeEditEnd.Date then DateTimeEditEnd.Date := DateTime;
end;

procedure TFrmLogManage.DateTimeEditEndDateTimeChange(Sender: TObject;
  DateTime: TDateTime);
begin
  if DateTime < DateTimeEditBegin.Date then DateTimeEditEnd.Date := DateTimeEditBegin.Date;
end;

procedure TFrmLogManage.DoSearchFile(Path: string);
var
  Info: TSearchRec;
  function IsFileExtractName(sMask: string): Boolean; //判断扩展名
  var
    sFileExt: string;
  begin
    sFileExt := ExtractFileExt(Info.Name);//获取扩展名
    Result := CompareText(sFileExt, sMask) = 0; //对比文本
  end;

  procedure ProcessAFile(FileDir, FileName: string);//判断是否为txt文件 并加入搜索
  var
    S, s01: string;
  begin
    s01 := '.txt';
    if IsFileExtractName(s01) then begin  //判断扩展名是否为txt
      S := FileDir + FileName; //搜索路径
      StatusBar.Panels[2].Text := '正在搜索：' + S; //显示到状态栏
      AddSearchFile(FileDir, FileName);//添加搜索文件
    end;
  end;

  function IsDir: Boolean;//是否为文件夹
  begin
    with Info do
      Result := (Name <> '.') and (Name <> '..') and ((Attr and faDirectory) = faDirectory{普通或隐藏目录});
  end;

  function IsFile: Boolean;//是否为文件
  begin
    Result := (not ((Info.Attr and faDirectory) = faDirectory));//除了文件夹的就是文件
  end;

  function IsLogFile: Boolean;//是否日志文件
  begin
    Result := Pos('Log-', Info.Name) > 0;// 以log开头的
  end;

begin
  Path := IncludeTrailingBackslash(Path);//确保有 最有有\
  try
    if FindFirst(Path + '*.*', faAnyFile, Info) = 0 then   //第一次查找
      if IsFile and IsLogFile then //是文件且是日志文件
        ProcessAFile(Path, Info.Name); //加入日志列表
      //else if IsDir then DoSearchFile(Path + Info.Name);
    while FindNext(Info) = 0 do begin  //查找下一个
      if IsFile and IsLogFile then  //是文件且是日志文件
        ProcessAFile(Path, Info.Name);
      Application.ProcessMessages; //让程序处理消息
      if QuitFlag then Break;
    end;
  finally
    FindClose(Info);
  end;
end;

procedure TFrmLogManage.ButtonStartClick(Sender: TObject); //搜索按钮
var
  I, II, III, IIII, nDay, nIdx: Integer;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  SearchDay: TDate;
  sLogDir, sLogFile: string;
  FileList: TStringList;
  LoadList: TStringList;//载入日志
  DataList: TList;
  sText, s01, s02, s03, s04, s05, s06, s07, s08, s09, s10, s11, s12, s13: string;
  LogData: pTLogData;
  ListItem: TListItem;
  ItemIndex: Integer;
  sSearch: string;//搜索文字
  boCheck: Boolean;//是否有选中项目
begin
  if not SearchStatus then begin  //搜索状态
    sSearch := Trim(EditSearch.Text); //搜索文字
    ItemIndex := ComboBoxCondition.ItemIndex; //搜索条件
    if (ItemIndex > 0) and (sSearch = '') then begin //如果条件为空
    //查询条件 1 人物名称 2 物品名称 3 物品ID 4 交易对象
      case ItemIndex of
        1: Application.MessageBox('请输入查询的人物名称 ！！！', '提示信息', MB_ICONQUESTION);
        2: Application.MessageBox('请输入查询的物品名称 ！！！', '提示信息', MB_ICONQUESTION);
        3: Application.MessageBox('请输入查询的物品ID ！！！', '提示信息', MB_ICONQUESTION);
        4: Application.MessageBox('请输入查询的交易对象 ！！！', '提示信息', MB_ICONQUESTION);
      else Application.MessageBox('请输入查询条件 ！！！', '提示信息', MB_ICONQUESTION);
      end;
      EditSearch.SetFocus;  //获取焦点
      Exit;
    end;
    //将命令数组与CHKLISTBOX 同步
    for I := 0 to Length(CmdArray) - 1 do begin
      CmdArray[I].Check := CheckListBox.Checked[I];
    end;

    if not CmdArray[0].Check then begin  //如果全选没有选中
      boCheck := False;
      //判断是否有选中的
      for I := 1 to Length(CmdArray) - 1 do begin
        if CmdArray[I].Check then begin
          boCheck := True;
          break;
        end;
      end;

      if not boCheck then begin  //如果全无选中 提示 请选择
        Application.MessageBox('请选择查询动作 ！！！', '提示信息', MB_ICONQUESTION);
        CheckListBox.SetFocus;
        Exit;
      end;
    end;
    QuitFlag := False;//退出标记
    SearchStatus := True; //选择状态=真

    ButtonStart.Caption := '停止查询';
    StatusBar.Panels[3].Text := '';
    //ButtonStart.Enabled := False;
    ListView.Clear; //清除
    UnLoadLogDataList; //卸载日志数据列表
    LoadList := TStringList.Create; //创建一个对象
    nDay := GetDayCount(DateTimeEditEnd.Date, DateTimeEditBegin.Date);//获取搜索相差天数
    for I := 0 to nDay do begin //遍历所有天数
      if QuitFlag then Break;  //如果退出状态 则跳出循环
      Application.ProcessMessages;
      SearchDay := DateTimeEditBegin.Date + I;
      DecodeDate(SearchDay, Year, Month, Day);
      sLogDir := IncludeTrailingBackslash(sBaseDir){确保文件最后有\} + IntToStr(Year) + '-' + IntToString(Month) + '-' + IntToString(Day);
      //.\BaseDir\2010-01-01
      if DirectoryExists(sLogDir) then begin  //判断日志文件夹是否存在ss
        UnLoadLogFileList;  //卸载日志文件列表
        DoSearchFile(sLogDir);//搜索日志文件夹     //向logfilelist加入内容
        StatusBar.Panels[2].Text := '搜索完成';
        for II := 0 to LogFileList.Count - 1 do begin
          Application.ProcessMessages;
          if QuitFlag then Break;
          sLogDir := LogFileList.Strings[II];//查找出每一个日志目录
          FileList := TStringList(LogFileList.Objects[II]);//获取子文件

          for III := 0 to FileList.Count - 1 do begin //遍历
            if QuitFlag then Break;
            Application.ProcessMessages;
            sLogFile := FileList.Strings[III];//获取日志路径
            if FileExists(sLogFile) then begin //如果文件存在
              LoadList.Clear;//清理loadlist
              DataList := TList.Create;//创建数据列表
              LogDataList.AddObject(sLogDir, DataList);//logdatalist
              StatusBar.Panels[2].Text := '正在查询:' + sLogFile;
              LoadList.LoadFromFile(sLogFile);//载入文件
              for IIII := 0 to LoadList.Count - 1 do begin  //每一行
                if QuitFlag then Break;
                Application.ProcessMessages;
                sText := Trim(LoadList.Strings[IIII]);//去两边空壳
                //GetValidStr3 分割字符串 暂未研究
                sText := GetValidStr3(sText, s01, [#9]); //以tab进行风格
                sText := GetValidStr3(sText, s02, [#9]);
                sText := GetValidStr3(sText, s03, [#9]);
                sText := GetValidStr3(sText, s04, [#9]);
                sText := GetValidStr3(sText, s05, [#9]);
                sText := GetValidStr3(sText, s06, [#9]);
                sText := GetValidStr3(sText, s07, [#9]);
                sText := GetValidStr3(sText, s08, [#9]);
                sText := GetValidStr3(sText, s09, [#9]);
                sText := GetValidStr3(sText, s10, [#9]);
                sText := GetValidStr3(sText, s11, [#9]);
                sText := GetValidStr3(sText, s12, [#9]);
                sText := GetValidStr3(sText, s13, [#9]);
                if IsStringNumber(s04) then begin  //第四位是否为数值
                  New(LogData); //分配内存  指针结构
                  DataList.Add(LogData);//加入指针
                  //全部赋值  LogData 是日志结构
                  LogData.nAct := Str_ToInt(s04, 0);
                  LogData.sMapName := s05;
                  LogData.nX := Str_ToInt(s06, -1);
                  LogData.nY := Str_ToInt(s07, -1);
                  LogData.sObjectName := s08;
                  LogData.sItemName := s09;
                  LogData.nCount := Str_ToInt(s10, 0);
                  LogData.boPalyObject := s11 = '1';
                  LogData.sActObjectName := s12;
                  LogData.sDate := s13;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    LoadList.Free;
    //上面是日志搜索并且加入到内存中
    nIdx := 0;
    for I := 0 to LogDataList.Count - 1 do begin
      if QuitFlag then Break;
      Application.ProcessMessages;
      DataList := TList(LogDataList.Objects[I]);
      //StatusBar.Panels[2].Text := '正在增加:' + LogDataList.Strings[I];
      for II := 0 to DataList.Count - 1 do begin
        if QuitFlag then Break;
        Application.ProcessMessages;
        LogData := DataList.Items[II]; //获取日志结构
        if CmdArray[0].Check or GetActChecked(LogData.nAct) then begin //判断命令数组
          if GetSearch(ItemIndex, sSearch, LogData) then begin
            //向列表添加数据
            Inc(nIdx);//序号
            ListItem := ListView.Items.Add;
            ListItem.Caption := IntToStr(nIdx);
            ListItem.SubItems.AddObject(GetActString(LogData.nAct), TObject(LogData));
            ListItem.SubItems.Add(LogData.sMapName);
            ListItem.SubItems.Add(IntToStr(LogData.nX));
            ListItem.SubItems.Add(IntToStr(LogData.nY));
            ListItem.SubItems.Add(LogData.sObjectName);
            ListItem.SubItems.Add(LogData.sItemName);
            ListItem.SubItems.Add(IntToStr(LogData.nCount));
            ListItem.SubItems.Add(LogData.sActObjectName);
            ListItem.SubItems.Add(LogData.sDate);
            StatusBar.Panels[2].Text := '正在增加:' + LogDataList.Strings[I] + ' ' + LogData.sObjectName + ' ' + LogData.sItemName;
          end;
        end;
      end;
    end;
    StatusBar.Panels[3].Text := '';
    StatusBar.Panels[2].Text := '查询已完成';
    //ButtonStart.Enabled := True;
    SearchStatus := False;
    ButtonStart.Caption := '开始查询';
  end else begin
    QuitFlag := True;
    SearchStatus := False;
    //ButtonStart.Caption:='停止查询';
  end;
end;

procedure TFrmLogManage.CheckListBoxClickCheck(Sender: TObject);
var
  I: Integer;
begin
  if CheckListBox.Selected[0] { and CheckListBox.Checked[0] } then begin
    for I := 1 to CheckListBox.Count - 1 do
      CheckListBox.Checked[I] := CheckListBox.Checked[0]; //全选
  end;
end;

procedure TFrmLogManage.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  LogDataList := TStringList.Create;//创建日志数据列表
  LogFileList := TStringList.Create;//日志文件列表
  //Date//系统函数 获取系统当前日期
  DateTimeEditBegin.Date := Date;//查询的开始时间
  DateTimeEditEnd.Date := Date;//查询结束时间
  ComboBoxCondition.ItemIndex := 0; //查询条件
  // CheckListBox 带选择框 的 列表
  CheckListBox.Clear;//清空分类
  for I := 0 to Length(CmdArray) - 1 do     //CmdArray 命令数组
    CheckListBox.Items.Add(CmdArray[I].Text); //将查询分类加入listbox

  CheckListBox.Selected[0] := True;//默认选择第一个
  CheckListBox.Checked[0] := True; //默认选中第一个
  CheckListBoxClickCheck(CheckListBox); //第一个为全选 如果第一个选中则其他都选中
  Timer.Enabled := True;//启动时钟   //妈的草你又是一空时钟
end;

procedure TFrmLogManage.FormDestroy(Sender: TObject);  //窗体释放
begin
  UnLoadLogFileList;//释放里面的 对象
  UnLoadLogDataList;//释放里面的  对象
  LogFileList.Free;//释放
  LogDataList.Free;//释放
end;

procedure TFrmLogManage.PopupMenu_COPYClick(Sender: TObject);
var
  I, II: Integer;
  ListItem: TListItem;
  Clipboard: TClipboard;
  sText: string;
begin
  sText := '';
  for I := 0 to ListView.Items.Count - 1 do begin
    ListItem := ListView.Items.Item[I];
    if ListItem.Selected then begin
      for II := 0 to ListItem.SubItems.Count - 1 do begin
        sText := sText + ListItem.SubItems.Strings[II] + #9;
      end;
      sText := Trim(sText) + #13#10;
    end;
  end;
  Clipboard := TClipboard.Create();
  Clipboard.AsText := sText;
  Clipboard.Free();
end;

procedure TFrmLogManage.PopupMenu_SELECTALLClick(Sender: TObject);
begin
  ListView.SelectAll;
end;

procedure TFrmLogManage.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;//啥用也没 估计他喜欢用时钟

end;

end.

