{=======================================================================================================================
  ComboBoxesFrame Unit

  Raize Components - Demo Program Source Unit

  Copyright © 1995-2002 by Raize Software, Inc.  All Rights Reserved.
=======================================================================================================================}

{$I RCDemo.inc}

unit ComboBoxesFrame;

interface

uses
  Forms,
  RzPanel,
  RzRadGrp,
  RzCmboBx,
  Controls,
  StdCtrls,
  RzLabel,
  RzRadChk,
  RzButton,
  Classes,
  ExtCtrls,
  RzCommon,
  RzBorder;

type
  TFmeComboBoxes = class(TFrame)
    grpTRzComboBox: TRzGroupBox;
    cbxStandard: TRzComboBox;
    optDropDown: TRzRadioButton;
    optDropDownList: TRzRadioButton;
    grpTRzMRUComboBox: TRzGroupBox;
    grpTRzColorComboBox: TRzGroupBox;
    grpTRzFontComboBox: TRzGroupBox;
    cbxColors: TRzColorComboBox;
    cbxFonts: TRzFontComboBox;
    cbxMRU: TRzMRUComboBox;
    OptShowSysColors: TRzCheckBox;
    OptShowColorNames: TRzCheckBox;
    OptShowDefault: TRzCheckBox;
    OptShowCustom: TRzCheckBox;
    GrpFontDevice: TRzRadioGroup;
    GrpFontType: TRzRadioGroup;
    GrpShowStyle: TRzRadioGroup;
    RzLabel1: TRzLabel;
    chkAllowEdit: TRzCheckBox;
    RzRegIniFile1: TRzRegIniFile;
    pnlHeader: TRzPanel;
    RzBorder1: TRzBorder;
    RzBorder2: TRzBorder;
    RzBorder3: TRzBorder;
    RzBorder4: TRzBorder;
    pnlPreview: TRzPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboStyleChange(Sender: TObject);
    procedure OptShowSysColorsClick(Sender: TObject);
    procedure OptShowColorNamesClick(Sender: TObject);
    procedure OptShowDefaultClick(Sender: TObject);
    procedure OptShowCustomClick(Sender: TObject);
    procedure GrpFontDeviceClick(Sender: TObject);
    procedure GrpFontTypeClick(Sender: TObject);
    procedure GrpShowStyleClick(Sender: TObject);
    procedure cbxFontsChange(Sender: TObject);
    procedure cbxColorsChange(Sender: TObject);
    procedure chkAllowEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init;
    procedure UpdateVisualStyle( VS: TRzVisualStyle; GCS: TRzGradientColorStyle );
  end;


implementation

{$R *.dfm}

uses
  MainForm;

const
  RC_SettingsKey = 'Software\Raize\Raize Components\2.5';


procedure TFmeComboBoxes.Init;
begin
  {$IFDEF VCL70_OR_HIGHER}
  ParentBackground := False;
  {$ENDIF}
  CbxMRU.MruPath := RC_SettingsKey;
end;


procedure TFmeComboBoxes.UpdateVisualStyle( VS: TRzVisualStyle;
                                            GCS: TRzGradientColorStyle );
begin
  pnlHeader.VisualStyle := VS;
  pnlHeader.GradientColorStyle := GCS;
end;


procedure TFmeComboBoxes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmMain.RestoreMainNotes;
  Action := caFree;
end;

procedure TFmeComboBoxes.ComboStyleChange(Sender: TObject);
begin
  if OptDropDown.Checked then
    CbxStandard.Style := csDropDown
  else
    CbxStandard.Style := csDropDownList;
  ChkAllowEdit.Enabled := CbxStandard.Style = csDropDown;
  CbxStandard.ItemIndex := -1;
  CbxStandard.ClearSearchString;
end;

procedure TFmeComboBoxes.OptShowSysColorsClick(Sender: TObject);
begin
  CbxColors.ShowSysColors := OptShowSysColors.Checked;
end;

procedure TFmeComboBoxes.OptShowColorNamesClick(Sender: TObject);
begin
  CbxColors.ShowColorNames := OptShowColorNames.Checked;
end;

procedure TFmeComboBoxes.OptShowDefaultClick(Sender: TObject);
begin
  CbxColors.ShowDefaultColor := OptShowDefault.Checked;
end;

procedure TFmeComboBoxes.OptShowCustomClick(Sender: TObject);
begin
  CbxColors.ShowCustomColor := OptShowCustom.Checked;
end;

procedure TFmeComboBoxes.GrpFontDeviceClick(Sender: TObject);
begin
  CbxFonts.FontDevice := TRzFontDevice( GrpFontDevice.ItemIndex );
end;

procedure TFmeComboBoxes.GrpFontTypeClick(Sender: TObject);
begin
  CbxFonts.FontType := TRzFontType( GrpFontType.ItemIndex );
end;

procedure TFmeComboBoxes.GrpShowStyleClick(Sender: TObject);
begin
  CbxFonts.ShowStyle := TRzShowStyle( GrpShowStyle.ItemIndex );
  if CbxFonts.ShowStyle = ssFontNameAndSample then
    CbxFonts.DropDownWidth := 300
  else
    CbxFonts.DropDownWidth := CbxFonts.Width;
end;

procedure TFmeComboBoxes.cbxFontsChange(Sender: TObject);
begin
  if CbxFonts.SelectedFont <> nil then
    PnlPreview.Font.Name := CbxFonts.SelectedFont.Name;
end;

procedure TFmeComboBoxes.cbxColorsChange(Sender: TObject);
begin
  PnlPreview.Color := CbxColors.SelectedColor;
end;


procedure TFmeComboBoxes.chkAllowEditClick(Sender: TObject);
begin
  CbxStandard.AllowEdit := ChkAllowEdit.Checked;
end;

end.
