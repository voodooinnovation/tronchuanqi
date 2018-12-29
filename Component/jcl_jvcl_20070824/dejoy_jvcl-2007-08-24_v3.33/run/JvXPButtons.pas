{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvXPButtons.PAS, released on 2004-01-01.

The Initial Developer of the Original Code is Marc Hoffman.
Portions created by Marc Hoffman are Copyright (C) 2002 APRIORI business solutions AG.
Portions created by APRIORI business solutions AG are Copyright (C) 2002 APRIORI business solutions AG
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvXPButtons.pas 11472 2007-08-18 12:42:22Z ahuser $

unit JvXPButtons;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JvJVCLUtils,
  {$ENDIF USEJVCL}
  Classes, TypInfo,
  Windows, Messages, Graphics, Controls, Forms, ActnList, ImgList, Menus,
  JvXPCore, JvXPCoreUtils;

type
  TJvXPCustomButtonActionLink = class(TWinControlActionLink)
  protected
    function IsImageIndexLinked: Boolean; override;
    procedure AssignClient(AClient: TObject); override;
    procedure SetImageIndex(Value: Integer); override;
  public
    destructor Destroy; override;
  end;

  TJvXPLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);

  TJvXPCustomButton = class(TJvXPCustomStyleControl)
  private
    FAutoGray: Boolean;
    FBgGradient: TBitmap;
    FCancel: Boolean;
    FCkGradient: TBitmap;
    FDefault: Boolean;
    FFcGradient: TBitmap;
    FGlyph: {$IFDEF USEJVCL}TJvPicture{$ELSE}TBitmap{$ENDIF USEJVCL};
    FHlGradient: TBitmap;
    FImageChangeLink: TChangeLink;
    FImageIndex: Integer;
    FLayout: TJvXPLayout;
    FShowAccelChar: Boolean;
    FShowFocusRect: Boolean;
    FSmoothEdges: Boolean;
    FSpacing: Byte;
    FWordWrap: Boolean;
    procedure CMDialogKey(var Msg: TCMDialogKey); message CM_DIALOGKEY;
    procedure ImageListChange(Sender: TObject);
    procedure GlyphChange(Sender: TObject);
  protected
    function GetActionLinkClass: TControlActionLinkClass; override;
    function IsSpecialDrawState(IgnoreDefault: Boolean = False): Boolean;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure SetAutoGray(Value: Boolean); virtual;
    procedure SetDefault(Value: Boolean); virtual;
    procedure SetGlyph(Value: {$IFDEF USEJVCL}TJvPicture{$ELSE}TBitmap{$ENDIF USEJVCL}); virtual;
    procedure SetLayout(Value: TJvXPLayout); virtual;
    procedure SetShowAccelChar(Value: Boolean); virtual;
    procedure SetShowFocusRect(Value: Boolean); virtual;
    procedure SetSmoothEdges(Value: Boolean); virtual;
    procedure SetSpacing(Value: Byte); virtual;
    procedure SetWordWrap(Value: Boolean); virtual;
    procedure Paint; override;
    procedure HookResized; override;
    // advanced properties.
    property AutoGray: Boolean read FAutoGray write SetAutoGray default True;
    property Cancel: Boolean read FCancel write FCancel default False;
    property Default: Boolean read FDefault write SetDefault default False;
    property Glyph: {$IFDEF USEJVCL}TJvPicture{$ELSE}TBitmap{$ENDIF USEJVCL} read FGlyph write SetGlyph;
    property Layout: TJvXPLayout read FLayout write SetLayout default blGlyphLeft;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property ShowFocusRect: Boolean read FShowFocusRect write SetShowFocusRect default False;
    property SmoothEdges: Boolean read FSmoothEdges write SetSmoothEdges default True;
    property Spacing: Byte read FSpacing write SetSpacing default 3;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Click; override;
  end;

  TJvXPButton = class(TJvXPCustomButton)
  published
    // common properties.
    property Action;
    property Caption;
    property Enabled;
    property TabOrder;
    property TabStop default True;
    property Height default 21;
    property Width default 73;

    // advanced properties.
    property AutoGray;
    property Cancel;
    property Default;
    property Glyph;
    property Layout;
    property ModalResult;
    property ShowAccelChar;
    property ShowFocusRect;
    property SmoothEdges;
    property Spacing;
    property WordWrap;

    //property BevelInner;
    //property BevelOuter;
    //property BevelWidth;
    //property BiDiMode;
    //property Ctl3D;
    //property DockSite;
    //property ParentBiDiMode;
    //property ParentCtl3D;
    //property TabOrder;
    //property TabStop;
    //property UseDockManager default True;
    property Align;
    property Anchors;
    //property AutoSize;
    property Constraints;
    property DragCursor;
    property DragKind;
    property OnCanResize;
    property DragMode;
    //property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property StyleManager;
    property Visible;
    //property OnDockDrop;
    //property OnDockOver;
    //property OnEndDock;
    //property OnGetSiteInfo;
    //property OnStartDock;
    //property OnUnDock;
    property OnClick;
    property OnConstrainedResize;
    {$IFDEF COMPILER6_UP}
    property OnContextPopup;
    {$ENDIF COMPILER6_UP}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

  TJvXPToolType =
    (ttArrowLeft, ttArrowRight, ttClose, ttMaximize, ttMinimize, ttPopup, ttRestore, ttImage);

  TJvXPCustomToolButton = class(TJvXPCustomStyleControl)
  private
    FToolType: TJvXPToolType;
    FDropDownMenu: TPopupMenu;
    FChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FImageIndex: TImageIndex;
    procedure SetImages(const Value: TCustomImageList);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetDropDownMenu(const Value: TPopupMenu);
    procedure DoImagesChange(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X: Integer; Y: Integer); override;
    procedure SetToolType(Value: TJvXPToolType); virtual;
    procedure Paint; override;
    procedure HookResized; override;

    property ToolType: TJvXPToolType read FToolType write SetToolType default ttClose;
    property DropDownMenu: TPopupMenu read FDropDownMenu write SetDropDownMenu;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TJvXPToolButton = class(TJvXPCustomToolButton)
  published
    property Enabled;
    property Color default clBlack;
    property Height default 15;
    property ToolType;
    property Width default 15;

    //property BevelInner;
    //property BevelOuter;
    //property BevelWidth;
    //property BiDiMode;
    //property Ctl3D;
    //property DockSite;
    //property ParentBiDiMode;
    //property ParentCtl3D;
    //property TabOrder;
    //property TabStop;
    //property UseDockManager default True;
    property Align;
    property Anchors;
    //property AutoSize;
    property Constraints;
    property DragCursor;
    property DragKind;
    property OnCanResize;
    property DragMode;
    property DropDownMenu;
    property Images;
    property ImageIndex;

    //property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property StyleManager;
    property Visible;
    //property OnDockDrop;
    //property OnDockOver;
    //property OnEndDock;
    //property OnGetSiteInfo;
    //property OnStartDock;
    //property OnUnDock;
    property OnClick;
    property OnConstrainedResize;
    {$IFDEF COMPILER6_UP}
    property OnContextPopup;
    {$ENDIF COMPILER6_UP}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/run/JvXPButtons.pas $';
    Revision: '$Revision: 11472 $';
    Date: '$Date: 2007-08-18 05:42:22 -0700 (Sat, 18 Aug 2007) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

//=== { TJvXPCustomButtonActionLink } ========================================

destructor TJvXPCustomButtonActionLink.Destroy;
begin
  TJvXPCustomButton(FClient).Invalidate;
  inherited Destroy;
end;

procedure TJvXPCustomButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TJvXPCustomButton;
end;

function TJvXPCustomButtonActionLink.IsImageIndexLinked: Boolean;
begin
  Result := True;
end;

procedure TJvXPCustomButtonActionLink.SetImageIndex(Value: Integer);
begin
  inherited SetImageIndex(Value);
  (FClient as TJvXPCustomButton).FImageIndex := Value;
  (FClient as TJvXPCustomButton).Invalidate;
end;

//=== { TJvXPCustomButton } ==================================================

constructor TJvXPCustomButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // set default properties.
  ControlStyle := ControlStyle - [csDoubleClicks];
  Height := 21;
  Width := 73;
  TabStop := True;

  // set custom properties.
  FAutoGray := True;
  FCancel := False;
  FDefault := False;
  FImageIndex := -1;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FGlyph := {$IFDEF USEJVCL}TJvPicture{$ELSE}TBitmap{$ENDIF USEJVCL}.Create;
  FGlyph.OnChange := GlyphChange;
  FLayout := blGlyphLeft;
  FShowAccelChar := True;
  FShowFocusRect := False;
  FSmoothEdges := True;
  FSpacing := 3;
  FWordWrap := True;

  // create ...
  FBgGradient := TBitmap.Create; // background gradient
  FCkGradient := TBitmap.Create; // clicked gradient
  FFcGradient := TBitmap.Create; // focused gradient
  FHlGradient := TBitmap.Create; // Highlight gradient
end;

destructor TJvXPCustomButton.Destroy;
begin
  FBgGradient.Free;
  FCkGradient.Free;
  FFcGradient.Free;
  FHlGradient.Free;
  FGlyph.Free;
  FImageChangeLink.OnChange := nil;
  FImageChangeLink.Free;
  FImageChangeLink := nil;
  inherited Destroy;
end;

procedure TJvXPCustomButton.Click;
begin
  // Only there to make it public (Mantis 4015)
  inherited Click;
end;

function TJvXPCustomButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TJvXPCustomButtonActionLink;
end;


procedure TJvXPCustomButton.CMDialogKey(var Msg: TCMDialogKey);
begin
  inherited;
  with Msg do
    if (((CharCode = VK_RETURN) and (Focused or (FDefault and not IsSibling))) or
      ((CharCode = VK_ESCAPE) and FCancel) and (KeyDataToShiftState(KeyData) = [])) and
      CanFocus then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TJvXPCustomButton.SetAutoGray(Value: Boolean);
begin
  if Value <> FAutoGray then
  begin
    FAutoGray := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomButton.SetDefault(Value: Boolean);
begin
  if Value <> FDefault then
  begin
    FDefault := Value;
    if GetParentForm(Self) <> nil then
      with GetParentForm(Self) do
        Perform(CM_FOCUSCHANGED, 0, Longint(ActiveControl));
  end;
end;

procedure TJvXPCustomButton.SetGlyph(Value: {$IFDEF USEJVCL}TJvPicture{$ELSE}TBitmap{$ENDIF USEJVCL});
begin
  FGlyph.Assign(Value);
  LockedInvalidate;
end;

procedure TJvXPCustomButton.SetLayout(Value: TJvXPLayout);
begin
  if Value <> FLayout then
  begin
    FLayout := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomButton.SetShowAccelChar(Value: Boolean);
begin
  if Value <> FShowAccelChar then
  begin
    FShowAccelChar := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomButton.SetShowFocusRect(Value: Boolean);
begin
  if Value <> FShowFocusRect then
  begin
    FShowFocusRect := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomButton.SetSmoothEdges(Value: Boolean);
begin
  if Value <> FSmoothEdges then
  begin
    FSmoothEdges := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomButton.SetSpacing(Value: Byte);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomButton.SetWordWrap(Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomButton.ImageListChange(Sender: TObject);
begin
  if Assigned(Action) and (Sender is TCustomImageList) and
    Assigned(TAction(Action).ActionList.Images) and
    ((TAction(Action).ImageIndex < (TAction(Action).ActionList.Images.Count))) then
    FImageIndex := TAction(Action).ImageIndex
  else
    FImageIndex := -1;
  LockedInvalidate;
end;

procedure TJvXPCustomButton.GlyphChange(Sender: TObject);
begin
  LockedInvalidate;
end;

procedure TJvXPCustomButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Shift = []) and (Key = VK_SPACE) then
  begin
    DrawState := DrawState + [dsHighlight];
    HookMouseDown;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TJvXPCustomButton.KeyUp(var Key: Word; Shift: TShiftState);
var
  Pos: TPoint;
begin
  //
  // it's not possible to call the 'HookMouseUp' or 'HookMouseLeave' methods,
  // because we don't want to call their event handlers.
  //
  if dsClicked in DrawState then
  begin
    GetCursorPos(Pos);
    Pos := ScreenToClient(Pos);
    if not PtInRect(Bounds(0, 0, Width, Height), Pos) then
      DrawState := DrawState - [dsHighlight];
    DrawState := DrawState - [dsClicked];
    LockedInvalidate;
    Click;
  end;
  inherited KeyUp(Key, Shift);
end;

function TJvXPCustomButton.IsSpecialDrawState(IgnoreDefault: Boolean = False): Boolean;
begin
  if dsClicked in DrawState then
    Result := not (dsHighlight in DrawState)
  else
    Result := (dsHighlight in DrawState) or (dsFocused in DrawState);
  if not IgnoreDefault then
    Result := Result or (FDefault and CanFocus) and not IsSibling;
end;

procedure TJvXPCustomButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if Assigned(TCustomAction(Sender).ActionList.Images) and
        (FImageChangeLink.Sender <> TCustomAction(Sender).ActionList.Images) then
        TCustomAction(Sender).ActionList.Images.RegisterChanges(FImageChangeLink);
      if (ActionList <> nil) and (ActionList.Images <> nil) and
        (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
        FImageIndex := ImageIndex;
      LockedInvalidate;
    end;
end;

procedure TJvXPCustomButton.HookResized;
const
  ColSteps = 64;
  Dithering = True;
var
  Offset: Integer;
begin
  inherited HookResized;

  // calculate offset.
  Offset := 4 * (Integer(IsSpecialDrawState(True)));

  //
  // create gradient rectangles for...
  //

  // background.
  JvXPCreateGradientRect(Width - (2 + Offset), Height - (2 + Offset),
    dxColor_Btn_Enb_BgFrom_WXP, dxColor_Btn_Enb_BgTo_WXP, ColSteps, gsTop, Dithering,
    FBgGradient);

  // clicked.
  JvXPCreateGradientRect(Width - 2, Height - 2, dxColor_Btn_Enb_CkFrom_WXP,
    dxColor_Btn_Enb_CkTo_WXP, ColSteps, gsTop, Dithering, FCkGradient);

  // focused.
  JvXPCreateGradientRect(Width - 2, Height - 2, dxColor_Btn_Enb_FcFrom_WXP,
    dxColor_Btn_Enb_FcTo_WXP, ColSteps, gsTop, Dithering, FFcGradient);

  // highlight.
  JvXPCreateGradientRect(Width - 2, Height - 2, dxColor_Btn_Enb_HlFrom_WXP,
    dxColor_Btn_Enb_HlTo_WXP, ColSteps, gsTop, Dithering, FHlGradient);

  LockedInvalidate;
end;

procedure TJvXPCustomButton.Paint;
var
  Rect: TRect;
  Offset, Flags: Integer;
  DrawPressed: Boolean;
  Image: TPicture;
  Bitmap: TBitmap;
begin
  with Canvas do
  begin
    // clear background.
    Rect := GetClientRect;
    Brush.Color := Self.Color;
    FillRect(Rect);
    // draw gradient borders.
    if IsSpecialDrawState then
    begin
      Bitmap := TBitmap.Create;
      try
        if dsHighlight in DrawState then
          Bitmap.Assign(FHlGradient)
        else
          Bitmap.Assign(FFcGradient);
        BitBlt(Handle, 1, 1, Width, Height, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
      finally
        Bitmap.Free;
      end;
    end;

    // draw background gradient...
    if not ((dsHighlight in DrawState) and (dsClicked in DrawState)) then
    begin
      Offset := 2 * Integer(IsSpecialDrawState);
      BitBlt(Handle, 1 + Offset, 1 + Offset, Width - 3 * Offset, Height - 3 * Offset,
        FBgGradient.Canvas.Handle, 0, 0, SRCCOPY);
    end
    // ...or click gradient.
    else
    begin
      BitBlt(Handle, 1, 1, Width, Height, FCkGradient.Canvas.Handle, 0, 0, SRCCOPY);
    end;
    // draw border lines.
    if Enabled then
      Pen.Color := dxColor_Btn_Enb_Border_WXP
    else
      Pen.Color := dxColor_Btn_Dis_Border_WXP;
    Brush.Style := bsClear;
    RoundRect(0, 0, Width, Height, 5, 5);
    // draw border edges.
    if FSmoothEdges then
    begin
      if Enabled then
        Pen.Color := dxColor_Btn_Enb_Edges_WXP
      else
        Pen.Color := dxColor_Btn_Dis_Edges_WXP;
      JvXPDrawLine(Canvas, 0, 1, 2, 0);
      JvXPDrawLine(Canvas, Width - 2, 0, Width, 2);
      JvXPDrawLine(Canvas, 0, Height - 2, 2, Height);
      JvXPDrawLine(Canvas, Width - 3, Height, Width, Height - 3);
    end;

    // set drawing flags.
    Flags := {DT_VCENTER or } DT_END_ELLIPSIS;
    if FWordWrap then
      Flags := Flags or DT_WORDBREAK;

    // draw image & caption.
    Image := TPicture.Create;
    try
      // get image from action or glyph property.
      if Assigned(Action) and Assigned(TAction(Action).ActionList.Images) and
        (FImageIndex > -1) and (FImageIndex < TAction(Action).ActionList.Images.Count) then
      begin
        TAction(Action).ActionList.Images.GetBitmap(FImageIndex, Image.Bitmap)
      end
      else
      begin
        // Mantis 4044: We need to access the width and height of the graphic but
        // when it is a TIcon, they are only valid once the handle is created.
        // And that only happens after the icon has been painted, hence at the
        // first run here, we do not get the real size but the value from system
        // metrics (see TIcon.GetWidth for instance). Ideally, we would like
        // to call TIcon.HandleNeeded but it is private. So we access the Handle
        // property and despite us not storing its value in anything it does
        // call the getter anyway.
        if FGlyph.Graphic is TIcon then
          TIcon(FGlyph.Graphic).Handle;
        Image.Assign(FGlyph);
      end;

      // autogray image (if allowed).
      if FAutoGray and not Enabled then
        JvXPConvertToGray2(Image.Bitmap);

      // assign canvas font (change HotTrack-Color, if necessary).
      Font.Assign(Self.Font);

      // calculate textrect.
      if Assigned(Image.Graphic) and not Image.Graphic.Empty then
        if Length(Caption) > 0 then
        begin
          case FLayout of
            blGlyphLeft:
              Inc(Rect.Left, Image.Width + FSpacing);
            blGlyphRight:
              begin
                Dec(Rect.Left, Image.Width + FSpacing);
                Dec(Rect.Right, (Image.Width + FSpacing) * 2);
                Flags := Flags or DT_RIGHT;
              end;
            blGlyphTop:
              Inc(Rect.Top, Image.Height + FSpacing);
            blGlyphBottom:
              Dec(Rect.Top, Image.Height + FSpacing);
          end;
        end;

      if Length(Caption) > 0 then
      begin
        JvXPRenderText(Self, Canvas, Caption, Font, Enabled, FShowAccelChar, Rect, Flags or DT_CALCRECT);
        OffsetRect(Rect, (Width - Rect.Right) div 2, (Height - Rect.Bottom) div 2);
      end;

      // should we draw the pressed state?
      DrawPressed := (dsHighlight in DrawState) and (dsClicked in DrawState);
      if DrawPressed then
        OffsetRect(Rect, 1, 1);

      // draw image - if available.
      if Assigned(Image.Graphic) and not Image.Graphic.Empty then
      begin
        Image.Graphic.Transparent := True;
        if Length(Caption) > 0 then
          case FLayout of
            blGlyphLeft:
              Draw(Rect.Left - (Image.Width + FSpacing), (Height - Image.Height) div 2 +
                Integer(DrawPressed), Image.Graphic);
            blGlyphRight:
              Draw(Rect.Right + FSpacing, (Height - Image.Height) div 2 +
                Integer(DrawPressed), Image.Graphic);
            blGlyphTop:
              Draw((Width - Image.Width) div 2 + Integer(DrawPressed),
                Rect.Top - (Image.Height + FSpacing), Image.Graphic);
            blGlyphBottom:
              Draw((Width - Image.Width) div 2 + Integer(DrawPressed),
                Rect.Bottom + FSpacing, Image.Graphic);
          end
        else
          // draw the glyph into the center
          Draw((Width - Image.Width) div 2 + Integer(DrawPressed),
            (Height - Image.Height) div 2 + Integer(DrawPressed), Image.Graphic);
      end;

      // draw focusrect (if enabled).
      if (dsFocused in DrawState) and (FShowFocusRect) then
      begin
        Brush.Style := bsSolid;
        DrawFocusRect(Bounds(3, 3, Width - 6, Height - 6));
      end;

      // draw caption.
      SetBkMode(Handle, Transparent);
      JvXPRenderText(Self, Canvas, Caption, Font, Enabled, FShowAccelChar, Rect, Flags);
    finally
      Image.Free;
    end;
  end;
end;

// TJvXPCustomToolButton =====================================================

constructor TJvXPCustomToolButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csDoubleClicks];
  Color := clBlack;
  FToolType := ttClose;
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := DoImagesChange;
  HookResized;
end;

destructor TJvXPCustomToolButton.Destroy;
begin
  FChangeLink.Free;
  inherited Destroy;
end;

procedure TJvXPCustomToolButton.HookResized;
begin
  if ToolType <> ttImage then
  begin
    Height := 15;
    Width := 15;
  end;
end;

procedure TJvXPCustomToolButton.SetToolType(Value: TJvXPToolType);
begin
  if Value <> FToolType then
  begin
    FToolType := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomToolButton.Paint;
var
  Rect: TRect;
  Bitmap: TBitmap;
  Theme: TJvXPTheme;
  Shifted: Boolean;
begin
  with Canvas do
  begin
    Rect := GetClientRect;
    Brush.Color := TJvXPWinControl(Parent).Color;
    Brush.Style := bsSolid;
    FillRect(Rect);
    if csDesigning in ComponentState then
      DrawFocusRect(Rect);
    Brush.Style := bsClear;
    Theme := Style.GetTheme;
    if (Theme = WindowsXP) and (dsClicked in DrawState) and
      not (dsHighlight in DrawState) then
      JvXPFrame3d(Self.Canvas, Rect, clWhite, clBlack);
    if dsHighlight in DrawState then
    begin
      if Theme = WindowsXP then
        JvXPFrame3d(Self.Canvas, Rect, clWhite, clBlack, dsClicked in DrawState)
      else
      begin
        Pen.Color := dxColor_BorderLineOXP;
        Rectangle(Rect);
        InflateRect(Rect, -1, -1);
        if dsClicked in DrawState then
          Brush.Color := dxColor_BgCkOXP
        else
          Brush.Color := dxColor_BgOXP;
        FillRect(Rect);
      end;
    end;
    Shifted := (Theme = WindowsXP) and (dsClicked in DrawState);
    if ToolType = ttImage then
    begin
      if (Images = nil) or (ImageIndex < 0) or (ImageIndex >= Images.Count) then
        Exit;
      Images.Draw(Canvas,
        (Width - Images.Width) div 2 + Integer(Shifted),
        (Height - Images.Height) div 2 + Integer(Shifted),
        ImageIndex,
        {$IFDEF COMPILER6_UP}
        dsTransparent,
        itImage,
        {$ENDIF COMPILER6_UP}
        Enabled);
    end
    else
    begin
      Bitmap := TBitmap.Create;
      try
        Bitmap.Assign(nil); // fixes GDI resource leak
        Bitmap.LoadFromResourceName(HInstance,
          PChar('JvXPCustomToolButton' + Copy(GetEnumName(TypeInfo(TJvXPToolType),
          Ord(FToolType)), 3, MaxInt)));
        if (dsClicked in DrawState) and (dsHighlight in DrawState) then
          JvXPColorizeBitmap(Bitmap, clWhite)
        else
        if not Enabled then
          JvXPColorizeBitmap(Bitmap, clGray)
        else
        if Color <> clBlack then
          JvXPColorizeBitmap(Bitmap, Color);
        Bitmap.Transparent := True;
        Draw((Width - Bitmap.Width) div 2 + Integer(Shifted),
          (Height - Bitmap.Height) div 2 + Integer(Shifted), Bitmap);
      finally
        Bitmap.Free;
      end;
    end;
  end;
end;

procedure TJvXPCustomToolButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = DropDownMenu then
      DropDownMenu := nil
    else
    if AComponent = Images then
      Images := nil;
  end;
end;

procedure TJvXPCustomToolButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  Msg: TMsg;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Assigned(DropDownMenu) then
  begin
    P := ClientToScreen(Point(0, Height));
    DropDownMenu.Popup(P.X, P.Y);
    while PeekMessage(Msg, HWND_DESKTOP, WM_MOUSEFIRST, WM_MOUSELAST, PM_REMOVE) do
      {nothing};
    if GetCapture <> 0 then
      SendMessage(GetCapture, WM_CANCELMODE, 0, 0);

  end;
end;

procedure TJvXPCustomToolButton.SetImages(const Value: TCustomImageList);
begin
  if FImages <> Value then
  begin
    if FImages <> nil then
      FImages.UnRegisterChanges(FChangeLink);
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.FreeNotification(Self);
      FImages.RegisterChanges(FChangeLink);
    end;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomToolButton.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomToolButton.SetDropDownMenu(const Value: TPopupMenu);
begin
  if FDropDownMenu <> Value then
  begin
    FDropDownMenu := Value;
    if FDropDownMenu <> nil then
      FDropDownMenu.FreeNotification(Self);
    LockedInvalidate;
  end;
end;

procedure TJvXPCustomToolButton.DoImagesChange(Sender: TObject);
begin
  LockedInvalidate;
end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

end.

