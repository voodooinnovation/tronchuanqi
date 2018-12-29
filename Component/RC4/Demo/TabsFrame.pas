{=======================================================================================================================
  PanelsFrame Unit

  Raize Components - Demo Program Source Unit

  Copyright © 1995-2002 by Raize Software, Inc.  All Rights Reserved.
=======================================================================================================================}

{$I RCDemo.inc}

unit TabsFrame;

interface

uses
  Forms,
  ImgList,
  Controls,
  RzTabs,
  Graphics,
  Classes,
  RzBckgnd, StdCtrls, RzLabel, ExtCtrls, RzPanel, RzButton, RzRadChk,
  RzRadGrp, Mask, RzEdit, RzBorder, RzCommon;

type
  TFmeTabs = class(TFrame)
    ImageList1: TImageList;
    RzPanel2: TRzPanel;
    RzSeparator1: TRzSeparator;
    GrpTabStyle: TRzGroupBox;
    GrpTabOrientation: TRzGroupBox;
    btnSingleSlant: TRzToolButton;
    btnDoubleSlant: TRzToolButton;
    btnCutCorner: TRzToolButton;
    btnRoundCorners: TRzToolButton;
    btnTop: TRzToolButton;
    btnBottom: TRzToolButton;
    btnLeft: TRzToolButton;
    btnRight: TRzToolButton;
    optTop: TRzRadioButton;
    optBottom: TRzRadioButton;
    optLeft: TRzRadioButton;
    optRight: TRzRadioButton;
    optSingleSlant: TRzRadioButton;
    optDoubleSlant: TRzRadioButton;
    optCutCorner: TRzRadioButton;
    optRoundCorners: TRzRadioButton;
    RzPanel1: TRzPanel;
    pgcPreview: TRzPageControl;
    tabDates: TRzTabSheet;
    tabFonts: TRzTabSheet;
    tabNotes: TRzTabSheet;
    tabSearch: TRzTabSheet;
    tabPrint: TRzTabSheet;
    grpTabSequence: TRzRadioGroup;
    GrpImages: TRzGroupBox;
    chkImages: TRzCheckBox;
    grpImagePosition: TRzRadioGroup;
    GrpPageDisplay: TRzGroupBox;
    GrpHotTrack: TRzGroupBox;
    grpHotTrackStyle: TRzRadioGroup;
    edtHotTrackColor: TRzColorEdit;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    chkComplement: TRzCheckBox;
    RzBorder1: TRzBorder;
    RzCustomColors1: TRzCustomColors;
    chkColoredTabs: TRzCheckBox;
    chkMultiLine: TRzCheckBox;
    edtFrameColor: TRzColorEdit;
    RzLabel7: TRzLabel;
    GrpTabColors: TRzGroupBox;
    RzLabel4: TRzLabel;
    edtHighlightBarColor: TRzColorEdit;
    RzLabel5: TRzLabel;
    edtShadowColor: TRzColorEdit;
    RzLabel6: TRzLabel;
    edtUnselectedColor: TRzColorEdit;
    chkUseGradients: TRzCheckBox;
    edtPageColor: TRzColorEdit;
    RzLabel8: TRzLabel;
    chkHorizontalText: TRzCheckBox;
    btnBackSlant: TRzToolButton;
    optBackSlant: TRzRadioButton;
    chkSoftCorners: TRzCheckBox;
    pnlHeader: TRzPanel;
    tabHighlighting: TRzTabSheet;
    tabTemplates: TRzTabSheet;
    tabAutoComplete: TRzTabSheet;
    RzMenuController1: TRzMenuController;
    procedure btnTabStyleClick(Sender: TObject);
    procedure optTabStyleClick(Sender: TObject);
    procedure optTabOrientationClick(Sender: TObject);
    procedure btnTabOrientationClick(Sender: TObject);
    procedure chkImagesClick(Sender: TObject);
    procedure grpTabSequenceClick(Sender: TObject);
    procedure chkColoredTabsClick(Sender: TObject);
    procedure chkMultiLineClick(Sender: TObject);
    procedure chkHorizontalTextClick(Sender: TObject);
    procedure grpImagePositionClick(Sender: TObject);
    procedure grpHotTrackStyleClick(Sender: TObject);
    procedure edtHotTrackColorChange(Sender: TObject);
    procedure chkComplementClick(Sender: TObject);
    procedure chkUseGradientsClick(Sender: TObject);
    procedure edtHighlightBarColorChange(Sender: TObject);
    procedure edtShadowColorChange(Sender: TObject);
    procedure edtUnselectedColorChange(Sender: TObject);
    procedure edtFrameColorChange(Sender: TObject);
    procedure edtPageColorChange(Sender: TObject);
    procedure chkSoftCornersClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Init;
    procedure UpdateVisualStyle( VS: TRzVisualStyle; GCS: TRzGradientColorStyle );
  end;


implementation

{$R *.dfm}

uses
  Windows;

procedure TFmeTabs.Init;
begin
  {$IFDEF VCL70_OR_HIGHER}
  ParentBackground := False;
  {$ENDIF}
end;


procedure TFmeTabs.UpdateVisualStyle( VS: TRzVisualStyle;
                                      GCS: TRzGradientColorStyle );
begin
  pnlHeader.VisualStyle := VS;
  pnlHeader.GradientColorStyle := GCS;
end;


procedure TFmeTabs.btnTabStyleClick(Sender: TObject);
begin
  case TRzToolButton( Sender ).Tag of
    0: optSingleSlant.Checked := True;
    1: optDoubleSlant.Checked := True;
    2: optCutCorner.Checked := True;
    3: optRoundCorners.Checked := True;
    4: optBackSlant.Checked := True;
  end;
end;

procedure TFmeTabs.optTabStyleClick(Sender: TObject);
begin
  pgcPreview.TabStyle := TRzTabStyle( TRzRadioButton( Sender ).Tag );
  chkSoftCorners.Enabled := pgcPreview.TabStyle in [ tsSingleSlant, tsDoubleSlant, tsBackSlant ];
end;


procedure TFmeTabs.btnTabOrientationClick(Sender: TObject);
begin
  case TRzToolButton( Sender ).Tag of
    0: optTop.Checked := True;
    1: optLeft.Checked := True;
    2: optBottom.Checked := True;
    3: optRight.Checked := True;
  end;
end;

procedure TFmeTabs.optTabOrientationClick(Sender: TObject);
begin
  pgcPreview.TabOrientation := TRzTabOrientation( TRzRadioButton( Sender ).Tag );
  case pgcPreview.TabOrientation of
    toTop, toBottom:
    begin
      pgcPreview.TextOrientation := orHorizontal;
      pgcPreview.ImagePosition := ipLeft;
    end;

    toLeft, toRight:
    begin
      pgcPreview.TextOrientation := orVertical;
      if pgcPreview.TabOrientation = toRight then
        pgcPreview.ImagePosition := ipTop
      else
        pgcPreview.ImagePosition := ipBottom;
    end;
  end;
  ChkHorizontalText.Checked := pgcPreview.TextOrientation = orHorizontal;
  GrpImagePosition.ItemIndex := Ord( pgcPreview.ImagePosition );
end;


procedure TFmeTabs.chkImagesClick(Sender: TObject);
begin
  if ChkImages.Checked then
    pgcPreview.Images := ImageList1
  else
    pgcPreview.Images := nil;
end;

procedure TFmeTabs.grpTabSequenceClick(Sender: TObject);
begin
  pgcPreview.TabSequence := TRzTabSequence( GrpTabSequence.ItemIndex );
end;

procedure TFmeTabs.chkColoredTabsClick(Sender: TObject);
begin
  if ChkColoredTabs.Checked then
  begin
    pgcPreview.UseColoredTabs := True;
    tabDates.Color := RGB( 198, 213, 241 );
    tabFonts.Color := RGB( 215, 207, 220 );
    tabNotes.Color := RGB( 243, 231, 202 );
    tabSearch.Color := RGB( 235, 211, 222 );
    tabPrint.Color := RGB( 216, 243, 202 );
    tabHighlighting.Color := RGB( 198, 213, 241 );
    tabTemplates.Color := RGB( 215, 207, 220 );
    tabAutoComplete.Color := RGB( 243, 231, 202 );
  end
  else
  begin
    pgcPreview.UseColoredTabs := False;
    pgcPreview.Color := $00F5F6F7;
  end;
end;

procedure TFmeTabs.chkMultiLineClick(Sender: TObject);
begin
  pgcPreview.MultiLine := ChkMultiLine.Checked;
end;

procedure TFmeTabs.chkHorizontalTextClick(Sender: TObject);
begin
  if ChkHorizontalText.Checked then
    pgcPreview.TextOrientation := orHorizontal
  else
    pgcPreview.TextOrientation := orVertical;
end;

procedure TFmeTabs.grpImagePositionClick(Sender: TObject);
begin
  pgcPreview.ImagePosition := TRzImagePosition( GrpImagePosition.ItemIndex );
end;

procedure TFmeTabs.grpHotTrackStyleClick(Sender: TObject);
begin
  pgcPreview.HotTrackStyle := TRzTabHotTrackStyle ( GrpHotTrackStyle.ItemIndex );
  ChkComplement.Enabled := GrpHotTrackStyle.ItemIndex = 0;
end;

procedure TFmeTabs.edtHotTrackColorChange(Sender: TObject);
begin
  pgcPreview.HotTrackColor := EdtHotTrackColor.SelectedColor;
end;

procedure TFmeTabs.chkComplementClick(Sender: TObject);
begin
  if ChkComplement.Checked then
    pgcPreview.HotTrackColorType := htctComplement
  else
    pgcPreview.HotTrackColorType := htctActual;
end;

procedure TFmeTabs.chkUseGradientsClick(Sender: TObject);
begin
  pgcPreview.UseGradients := ChkUseGradients.Checked;
end;

procedure TFmeTabs.edtHighlightBarColorChange(Sender: TObject);
begin
  pgcPreview.TabColors.HighlightBar := EdtHighlightBarColor.SelectedColor;
end;

procedure TFmeTabs.edtShadowColorChange(Sender: TObject);
begin
  pgcPreview.TabColors.Shadow := EdtShadowColor.SelectedColor;
end;

procedure TFmeTabs.edtUnselectedColorChange(Sender: TObject);
begin
  pgcPreview.TabColors.Unselected := EdtUnselectedColor.SelectedColor;
end;

procedure TFmeTabs.edtFrameColorChange(Sender: TObject);
begin
  pgcPreview.FlatColor := EdtFrameColor.SelectedColor;
end;

procedure TFmeTabs.edtPageColorChange(Sender: TObject);
begin
  pgcPreview.Color := EdtPageColor.SelectedColor;
end;

procedure TFmeTabs.chkSoftCornersClick(Sender: TObject);
begin
  pgcPreview.SoftCorners := chkSoftCorners.Checked;
end;

end.
