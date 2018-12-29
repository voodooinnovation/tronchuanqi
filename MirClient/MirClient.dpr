program MirClient;

uses
  Forms,
  Dialogs,
  IniFiles,
  Windows,
  SysUtils,
  Controls,
  ClMain in 'ClMain.pas' {frmMain},
  DrawScrn in 'DrawScrn.pas',
  IntroScn in 'IntroScn.pas',
  PlayScn in 'PlayScn.pas',
  MapUnit in 'MapUnit.pas',
  FState in 'FState.pas' {FrmDlg},
  ClFunc in 'ClFunc.pas',
  DWinCtl in 'DWinCtl.pas',
  magiceff in 'magiceff.pas',
  SoundUtil in 'SoundUtil.pas',
  Actor in 'Actor.pas',
  HerbActor in 'HerbActor.pas',
  AxeMon in 'AxeMon.pas',
  clEvent in 'clEvent.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  DlgConfig in 'DlgConfig.pas' {frmDlgConfig},
  MShare in 'MShare.pas',
  Mpeg in 'Mpeg.pas',
  wmUnit in 'wmUnit.pas',
  Share in 'Share.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  SoundEngn in 'SoundEngn.pas',
  MD5EncodeStr in '..\Common\MD5EncodeStr.pas',
  EncryptUnit in '..\Common\EncryptUnit.pas',
  CompressUnit1 in '..\Common\CompressUnit1.pas',
  CompressUnit in '..\Common\CompressUnit.pas',
  PathFind in 'PathFind.pas',
  Textures in 'Textures.pas',
  LoadMapThread in 'LoadMapThread.pas',
  GuaJi in 'GuaJi.pas',
  MapFiles in '..\Common\MapFiles.pas',
  GameImages in 'GameImages.pas',
  Uib in 'Uib.pas',
  Wzl in 'Wzl.pas',
  Wis in 'Wis.pas',
  Fir in 'Fir.pas',
  WelCome in 'WebBrowser\WelCome.pas' {frmWelCome};

{$R *.RES}
begin
  //if ProgressDlg = mrOk then begin
  Application.Initialize;
  Application.Title := 'Legend of mir';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TFrmDlg, FrmDlg);
  Application.CreateForm(TfrmDlgConfig, frmDlgConfig);
  Application.Run;
  //end;
end.

