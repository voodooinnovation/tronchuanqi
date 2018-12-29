unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmAbout = class(TForm)
    ButtonOK: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditProductName: TEdit;
    EditVersion: TEdit;
    EditUpDateTime: TEdit;
    EditProgram: TEdit;
    EditWebSite: TEdit;
    EditBbsSite: TEdit;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmAbout: TFrmAbout;

implementation
uses M2Share, Common, EncryptUnit;
{$R *.dfm}

procedure TFrmAbout.Open();
const
  sVersion = 'H^tlH>=>YRahU><nH?@mH?@nHo<aU<'; //引擎版本: 2.00 Build 200701010%d
  sUpDateTime = 'H_<mHNxlHNxnHl'; // //更新日期: 2007/01/01
  sProductName = 'ORanRQBsiHs^jYFslGbaj{[F{WwYpksCu\'; // //MakeGM反外挂防攻击数据引擎(商业版) 13677866
  sProgram = 'PQB_j_LpH_PmIo<rI\'; // //MakeGM QQ：13677866
  sWebSite = 'VCMpX?dkGsYsYnuIVSEUPNu_Wrp'; // //http://www.MakeGM.com
  sBbsSite = 'VCMpX?dkGrE^XnuIVSEUPNu_Wrp'; // //http://www.MakeGM.com
begin
  //置所有文本信息为空
  EditUpDateTime.Text := '';
  EditProductName.Text := '';
  EditProgram.Text := '';
  EditWebSite.Text := ''; ;
  EditBbsSite.Text := '';
  EditVersion.Text := '';
  //全部为只读
  EditUpDateTime.ReadOnly := True;
  EditProductName.ReadOnly := True;
  EditProgram.ReadOnly := True;
  EditWebSite.ReadOnly := True;
  EditBbsSite.ReadOnly := True;
  EditVersion.ReadOnly := True;

  //解密并且赋值
  EditUpDateTime.Text := DeCodeString(sUpDateTime);
  EditProductName.Text := DeCodeString(sProductName);
  EditProgram.Text := DeCodeString(sProgram);
  EditWebSite.Text := DeCodeString(sWebSite);
  EditBbsSite.Text := DeCodeString(sBbsSite);
  EditVersion.Text := Format(DeCodeString(sVersion), [0]);

  ShowModal;
end;

procedure TFrmAbout.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

end.

