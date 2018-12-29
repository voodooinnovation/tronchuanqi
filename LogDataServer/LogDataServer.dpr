program LogDataServer;

uses
  Forms,
  LogDataMain in 'LogDataMain.pas' {FrmLogData},
  LDShare in 'LDShare.pas',
  Grobal2 in 'Grobal2.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  LogManage in 'LogManage.pas' {FrmLogManage};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogData, FrmLogData);//数据窗口
  Application.CreateForm(TFrmLogManage, FrmLogManage);//管理窗口
  Application.Run;
end.
