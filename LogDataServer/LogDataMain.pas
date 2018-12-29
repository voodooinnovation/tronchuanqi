unit LogDataMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, IniFiles, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, IdSocketHandle,IdGlobal, Menus;
type
  TFrmLogData = class(TForm)
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    IdUDPServerLog: TIdUDPServer;
    StartTimer: TTimer;
    MainMenu: TMainMenu;
    MainMenu_LogData: TMenuItem;
    CloseTimer: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure WriteLogFile();

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StartTimerTimer(Sender: TObject);
    procedure MainMenu_LogDataClick(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure IdUDPServerLogUDPRead(Sender: TObject; AData: TBytes;
      ABinding: TIdSocketHandle);
  private
    LogMsgList: TStringList; //是个串列表类
    m_boRemoteClose: Boolean;
    { Private declarations }
  public
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA; //自定义消息
    { Public declarations }
  end;

var
  FrmLogData: TFrmLogData;
  {This file is generated by DeDe Ver 3.50.02 Copyright (c) 1999-2002 DaFixer}

implementation

uses LDShare, Grobal2, HUtil32, LogManage;

{$R *.DFM}

procedure TFrmLogData.FormCreate(Sender: TObject);
var
  //Conf: TIniFile; 已经放到时钟里
  nX, nY: Integer; //控制器启动时传进来的窗体坐标
begin
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);//游戏控制器句柄
  nX := Str_ToInt(ParamStr(2), -1);//位置x坐标
  nY := Str_ToInt(ParamStr(3), -1);//位置Y坐标
  if (nX >= 0) or (nY >= 0) then begin  //如果大于0才置为
    Left := nX;
    Top := nY;
  end;

  m_boRemoteClose := False;

  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));//向游戏中心发送自身句柄
  SendGameCenterMsg(SG_STARTNOW, '正在启动日志服务器...');//再发送服务以开启
  LogMsgList := TStringList.Create; //创建日志消息列表
  StartTimer.Enabled := True;//启用时钟  
end;

procedure TFrmLogData.FormDestroy(Sender: TObject);
begin
  LogMsgList.Free;//释放日志消息列表
end;

procedure TFrmLogData.CloseTimerTimer(Sender: TObject);
begin
  Caption := '正在关闭...'; //设置标题
  if SearchStatus then QuitFlag := True else Close;//是否搜索状态 即打开日志管理
end;

procedure TFrmLogData.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if m_boRemoteClose then exit;//远程控制中心要求关闭 则不管
  if Application.MessageBox('是否确认退出服务器？',
    '提示信息',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin    //提示是否退出
    m_boRemoteClose := True;//远程关闭=真
    CloseTimer.Enabled := True;//启动关闭时钟
  end else CanClose := False;
end;

procedure TFrmLogData.Timer1Timer(Sender: TObject);
begin
  WriteLogFile();//写入日志文件    每三秒写入一次
end;

procedure TFrmLogData.WriteLogFile();
var
  I: Integer;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  sLogDir, sLogFile: string;
//  s2E8: string;
  F: TextFile;
begin
  if LogMsgList.Count <= 0 then exit;//判断接收到的日志不为空
  DecodeDate(Date, Year, Month, Day);//解码日期   将日期年月日分开存放到三个变量中
  DecodeTime(Time, Hour, Min, Sec, MSec); //解码时间  //同上

  sLogDir := sBaseDir + IntToStr(Year) + '-' + IntToString(Month) + '-' + IntToString(Day);
  //当前日期目录
  if not DirectoryExists(sLogDir) then begin//文件夹不存在则创建
    CreateDirectoryA(PChar(sLogDir), nil);
  end;
  //\log-小时h分钟整除10*2加m.txt
  //\log-10h10m.txt
  //10分钟内的日志存放在一个记事本中
  sLogFile := sLogDir + '\Log-' + IntToString(Hour) + 'h' + IntToString((Min div 10) * 2) + 'm.txt';
  Label4.Caption := sLogFile;//现实日志文件
  try
    AssignFile(F, sLogFile);//关联文件   或说是打开文件
    if not FileExists(sLogFile) then Rewrite(F) //如果文件不存在则新建
    else Append(F);//存在则追加
    for I := 0 to LogMsgList.Count - 1 do begin   //将日志列表的内容全部写入到日志文件中
      //写入                              #9 tab + 格式化后的日期
      Writeln(F, LogMsgList.Strings[I] + #9 + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now));
      //缓存
      Flush(F)
    end;
    LogMsgList.Clear;//清空日志
  finally
    CloseFile(F);
  end;
end;

procedure TFrmLogData.MainMenu_LogDataClick(Sender: TObject);
begin
  FrmLogManage.Show;//显示日志管理界面
end;

procedure TFrmLogData.MyMessage(var MsgData: TWmCopyData); //自定义消息
var
  sData: string;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);//消息类型
  sData := StrPas(MsgData.CopyDataStruct^.lpData);//好像是没有用
  case wIdent of
    GS_QUIT: begin //游戏中心退出
        m_boRemoteClose := True; //布尔类型 远程关闭=真
        CloseTimer.Enabled := True;//启动关闭时钟
        Close(); //关闭日志管理
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TFrmLogData.StartTimerTimer(Sender: TObject);
var
  Conf: TIniFile;
  boMinimize: Boolean;
begin
  StartTimer.Enabled := False;// 关闭时钟
  boMinimize :=True;//初始化 是否最小化布尔
  Conf := TIniFile.Create('.\LogData.ini');//打开INI文件
  if Conf <> nil then begin //文件存在
    sBaseDir := Conf.ReadString('Setup', 'BaseDir', sBaseDir);//日志存放路径
    sCaption := Conf.ReadString('Setup', 'Caption', sServerName);//程序标题
    sServerName := Conf.ReadString('Setup', 'ServerName', sServerName);//服务器名称
    nServerPort := Conf.ReadInteger('Setup', 'Port', nServerPort);//端口
    boMinimize := Conf.ReadBool('Setup', 'Minimize', True);//状态
    Conf.Free;//释放inifile
  end;
  Caption := sCaption + ' (' + sServerName + ')';//设置程序标题
  IdUDPServerLog.DefaultPort := nServerPort;//udp协议端口 10000
  IdUDPServerLog.Active := True;//启用空间
  if boMinimize then Application.Minimize;//最小化
  SendGameCenterMsg(SG_STARTOK, '日志服务器启动完成...');//向控制中心发送信息
end;

procedure TFrmLogData.IdUDPServerLogUDPRead(Sender: TObject; AData: TBytes;
  ABinding: TIdSocketHandle);//如果有信息
var
  LogStr: string;
begin
  try
    SetLength(LogStr, Length(AData)); //为logstr 设置长度为 adata 同样大
    Move(AData[0], LogStr[1], Length(AData));//将ADATA 中的数据 复制到LogStr中
    LogMsgList.Add(LogStr);//日志列表加入LogMsgList 日志消息列表
  except

  end;
end;

end.

