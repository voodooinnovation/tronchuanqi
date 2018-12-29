{=======================================================================================================================
  EditsFrame Unit

  Raize Components - Demo Program Source Unit

  Copyright © 1995-2002 by Raize Software, Inc.  All Rights Reserved.
=======================================================================================================================}

{$I RCDemo.inc}

unit EditsFrame;

interface

uses
  Forms,
  RzCommon,
  RzEdit,
  Controls,
  StdCtrls,
  RzCmboBx,
  RzBtnEdt,
  RzSpnEdt,
  RzButton,
  RzRadChk,
  Mask,
  RzLabel,
  Classes,
  ExtCtrls,
  RzPanel,
  RzBorder;

type
  TFmeEdits = class(TFrame)
    GrpEdits: TRzGroupBox;
    GrpSpinEdits: TRzGroupBox;
    GrpButtonEdits: TRzGroupBox;
    bedPreview: TRzButtonEdit;
    spnPreview: TRzSpinEdit;
    RzEdit1: TRzEdit;
    RzMaskEdit1: TRzMaskEdit;
    chkSpnFlat: TRzCheckBox;
    chkHorzBtns: TRzCheckBox;
    chkDirection: TRzCheckBox;
    SpnButtonWidth: TRzSpinner;
    RzLabel1: TRzLabel;
    chkBtnFlat: TRzCheckBox;
    chkButtonVisible: TRzCheckBox;
    chkAltBtnVisible: TRzCheckBox;
    CbxButtonKind: TRzComboBox;
    CbxAltBtnKind: TRzComboBox;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    GrpDateTimeColor: TRzGroupBox;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    Label1: TLabel;
    RzDateTimeEdit1: TRzDateTimeEdit;
    RzDateTimeEdit2: TRzDateTimeEdit;
    RzColorEdit1: TRzColorEdit;
    RzFrameController1: TRzFrameController;
    pnlHeader: TRzPanel;
    procedure SpnButtonWidthChange(Sender: TObject);
    procedure chkSpnFlatClick(Sender: TObject);
    procedure chkHorzBtnsClick(Sender: TObject);
    procedure chkDirectionClick(Sender: TObject);
    procedure chkBtnFlatClick(Sender: TObject);
    procedure chkButtonVisibleClick(Sender: TObject);
    procedure chkAltBtnVisibleClick(Sender: TObject);
    procedure CbxButtonKindChange(Sender: TObject);
    procedure CbxAltBtnKindChange(Sender: TObject);
  private
  public
    procedure Init;
    procedure UpdateVisualStyle( VS: TRzVisualStyle; GCS: TRzGradientColorStyle );
  end;


implementation

{$R *.dfm}

uses
  SysUtils;

procedure TFmeEdits.Init;
begin
  {$IFDEF VCL70_OR_HIGHER}
  ParentBackground := False;
  {$ENDIF}

//  CbxButtonKind.FindItem( 'bkLookup' );
//  CbxAltBtnKind.FindItem( 'bkLookup' );

  RzDateTimeEdit1.Date := Date;
  RzDateTimeEdit2.Time := Time;
end;


procedure TFmeEdits.UpdateVisualStyle( VS: TRzVisualStyle;
                                       GCS: TRzGradientColorStyle );
begin
  pnlHeader.VisualStyle := VS;
  pnlHeader.GradientColorStyle := GCS;
end;


procedure TFmeEdits.SpnButtonWidthChange(Sender: TObject);
begin
  SpnPreview.ButtonWidth := SpnButtonWidth.Value;
end;

procedure TFmeEdits.chkSpnFlatClick(Sender: TObject);
begin
  SpnPreview.FlatButtons := ChkSpnFlat.Checked;
end;

procedure TFmeEdits.chkHorzBtnsClick(Sender: TObject);
begin
  if ChkHorzBtns.Checked then
    SpnPreview.Orientation := orHorizontal
  else
    SpnPreview.Orientation := orVertical;
end;

procedure TFmeEdits.chkDirectionClick(Sender: TObject);
begin
  if ChkDirection.Checked then
    SpnPreview.Direction := sdLeftRight
  else
    SpnPreview.Direction := sdUpDown;
end;

procedure TFmeEdits.chkBtnFlatClick(Sender: TObject);
begin
  BedPreview.FlatButtons := ChkBtnFlat.Checked;
end;

procedure TFmeEdits.chkButtonVisibleClick(Sender: TObject);
begin
  BedPreview.ButtonVisible := ChkButtonVisible.Checked;
end;

procedure TFmeEdits.chkAltBtnVisibleClick(Sender: TObject);
begin
  BedPreview.AltBtnVisible := ChkAltBtnVisible.Checked;
end;

procedure TFmeEdits.CbxButtonKindChange(Sender: TObject);
begin
  BedPreview.ButtonKind := TButtonKind( CbxButtonKind.ItemIndex + 1 );
end;

procedure TFmeEdits.CbxAltBtnKindChange(Sender: TObject);
begin
  BedPreview.AltBtnKind := TButtonKind( CbxAltBtnKind.ItemIndex + 1 );
end;


end.
