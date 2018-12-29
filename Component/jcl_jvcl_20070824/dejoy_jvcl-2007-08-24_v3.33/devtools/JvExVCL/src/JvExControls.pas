{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvExControls.pas, released on 2004-01-04

The Initial Developer of the Original Code is Andreas Hausladen [Andreas dott Hausladen att gmx dott de]
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -
               dejoy.

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvExControls.pas 11400 2007-06-28 21:24:06Z ahuser $

unit JvExControls;

{$I jvcl.inc}

WARNINGHEADER

interface

uses
  Windows, Messages,
  {$IFDEF HAS_UNIT_TYPES}
  Types,
  {$ENDIF HAS_UNIT_TYPES}
  {$IFDEF CLR}
  System.Runtime.InteropServices,
  {$ENDIF CLR}
  SysUtils, Classes, Graphics, Controls, Forms,
  {$IFDEF COMPILER5}
  JvVCL5Utils,
  {$ENDIF COMPILER5}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JvTypes, JvThemes, JVCLVer;

type
  TDlgCode =
   (dcWantAllKeys, dcWantArrows, dcWantChars, dcButton, dcHasSetSel, dcWantTab,
    dcNative); // if dcNative is in the set the native allowed keys are used and GetDlgCode is ignored
  TDlgCodes = set of TDlgCode;

const
  dcWantMessage = dcWantAllKeys;

const
  CM_DENYSUBCLASSING = JvThemes.CM_DENYSUBCLASSING;
  CM_PERFORM = CM_BASE + $500 + 0; // LParam: "Msg: ^TMessage"
  CM_SETAUTOSIZE = CM_BASE + $500 + 1; // WParam: "Value: Boolean"

type
  TJvHotTrackOptions = class;

  { IJvExControl is used for the identification of an JvExXxx control. }
  IJvExControl = interface
    ['{8E6579C3-D683-4562-AFAB-D23C8526E386}']
  end;

  { Add IJvDenySubClassing to the base class list if the control should not
    be themed by the ThemeManager (http://www.soft-gems.net Mike Lischke).
    This only works with JvExVCL derived classes. }
  IJvDenySubClassing = interface
    ['{76942BC0-2A6E-4DC4-BFC9-8E110DB7F601}']
  end;


  { IJvHotTrack is Specifies whether Control are highlighted when the mouse passes over them}
  IJvHotTrack = interface
    ['{8F1B40FB-D8E3-46FE-A7A3-21CE4B199A8F}']

    function GetHotTrack:Boolean;
    function GetHotTrackFont:TFont;
    function GetHotTrackFontOptions:TJvTrackFontOptions;
    function GetHotTrackOptions:TJvHotTrackOptions;

    procedure SetHotTrack(Value: Boolean);
    procedure SetHotTrackFont(Value: TFont);
    procedure SetHotTrackFontOptions(Value: TJvTrackFontOptions);
    procedure SetHotTrackOptions(Value: TJvHotTrackOptions);

    property HotTrack: Boolean read GetHotTrack write SetHotTrack;
    property HotTrackFont: TFont read GetHotTrackFont write SetHotTrackFont;
    property HotTrackFontOptions: TJvTrackFontOptions read GetHotTrackFontOptions write SetHotTrackFontOptions;
    property HotTrackOptions: TJvHotTrackOptions read GetHotTrackOptions write SetHotTrackOptions;
  end;

  TJvHotTrackOptions = class(TJvPersistentProperty)
  private
    FEnabled: Boolean;
    FFrameVisible: Boolean;
    FColor: TColor;
    FFrameColor: TColor;
    procedure SetColor(Value: TColor);
    procedure SetEnabled(Value: Boolean);
    procedure SetFrameColor(Value: TColor);
    procedure SetFrameVisible(Value: Boolean);
  public
    constructor Create; virtual;
    procedure Assign(Source: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property Color: TColor read FColor write SetColor default $00D2BDB6;
    property FrameVisible: Boolean read FFrameVisible write SetFrameVisible default False;
    property FrameColor: TColor read FFrameColor write SetFrameColor default $006A240A;
  end;

  TStructPtrMessage = class(TObject)
  private
    {$IFDEF CLR}
    FBuf: IntPtr;
    FLParam: &Object;
    {$ENDIF CLR}
  public
    Msg: TMessage;
    constructor Create(Msg: Integer; WParam: Integer; var LParam);
    {$IFDEF CLR}
    destructor Destroy; override;
    {$ENDIF CLR}
  end;

procedure SetDotNetFrameColors(FocusedColor, UnfocusedColor: TColor);
procedure DrawDotNetControl(Control: TWinControl; AColor: TColor; InControl: Boolean);
procedure HandleDotNetHighlighting(Control: TWinControl; const Msg: TMessage;
  MouseOver: Boolean; Color: TColor);

function CreateWMMessage(Msg: Integer; WParam: Integer; LParam: Longint): TMessage; overload; {$IFDEF SUPPORTS_INLINE} inline {$ENDIF}
function CreateWMMessage(Msg: Integer; WParam: Integer; LParam: TControl): TMessage; overload; {$IFDEF SUPPORTS_INLINE} inline {$ENDIF}
function SmallPointToLong(const Pt: TSmallPoint): Longint; {$IFDEF SUPPORTS_INLINE} inline {$ENDIF}
function ShiftStateToKeyData(Shift: TShiftState): Longint;
function GetFocusedControl(AControl: TControl): TWinControl;
function DlgcToDlgCodes(Value: Longint): TDlgCodes;
function DlgCodesToDlgc(Value: TDlgCodes): Longint;
procedure GetHintColor(var HintInfo: THintInfo; AControl: TControl; HintColor: TColor);
function DispatchIsDesignMsg(Control: TControl; var Msg: TMessage): Boolean;

{$IFDEF COMPILER5}
procedure TOpenControl_SetAutoSize(AControl: TControl; Value: Boolean);
{$ENDIF COMPILER5}

type
  CONTROL_DECL_DEFAULT(Control)

  WINCONTROL_DECL_DEFAULT(WinControl)

  WINCONTROL_DECL_DEFAULT(CustomControl)

  CONTROL_DECL_DEFAULT(GraphicControl)

  WINCONTROL_DECL_DEFAULT(HintWindow)

  TJvExPubGraphicControl = class(TJvExGraphicControl)
  COMMON_PUBLISHED
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/devtools/JvExVCL/src/JvExControls.pas $';
    Revision: '$Revision: 11400 $';
    Date: '$Date: 2007-06-28 14:24:06 -0700 (Thu, 28 Jun 2007) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  TypInfo;

var
  InternalFocusedColor: TColor = TColor($00733800);
  InternalUnfocusedColor: TColor = clGray;

procedure SetDotNetFrameColors(FocusedColor, UnfocusedColor: TColor);
begin
  InternalFocusedColor := FocusedColor;
  InternalUnfocusedColor := UnfocusedColor;
end;

procedure DrawDotNetControl(Control: TWinControl; AColor: TColor; InControl: Boolean);
var
  DC: HDC;
  R: TRect;
  Canvas: TCanvas;
begin
  DC := GetWindowDC(Control.Handle);
  try
    GetWindowRect(Control.Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    Canvas := TCanvas.Create;
    with Canvas do
    try
      Handle := DC;
      Brush.Color := InternalUnfocusedColor;
      if Control.Focused or InControl then
        Brush.Color := InternalFocusedColor;
      FrameRect(R);
      InflateRect(R, -1, -1);
      if not (Control.Focused or InControl) then
        Brush.Color := AColor;
      FrameRect(R);
    finally
      Free;
    end;
  finally
    ReleaseDC(Control.Handle, DC);
  end;
end;

procedure HandleDotNetHighlighting(Control: TWinControl; const Msg: TMessage;
  MouseOver: Boolean; Color: TColor);
var
  Rgn, SubRgn: HRGN;
begin
  if not (csDesigning in Control.ComponentState) then
    case Msg.Msg of
      CM_MOUSEENTER, CM_MOUSELEAVE, WM_KILLFOCUS, WM_SETFOCUS, WM_NCPAINT:
        begin
          DrawDotNetControl(Control, Color, MouseOver);
          if Msg.Msg = CM_MOUSELEAVE then
          begin
            Rgn := CreateRectRgn(0, 0, Control.Width - 1, Control.Height - 1);
            SubRgn := CreateRectRgn(2, 2, Control.Width - 3, Control.Height - 3);
            try
              CombineRgn(Rgn, Rgn, SubRgn, RGN_DIFF);
              InvalidateRgn(Control.Handle, Rgn, False); // redraw 3D border
            finally
              DeleteObject(SubRgn);
              DeleteObject(Rgn);
            end;
          end;
        end;
    end;
end;

function CreateWMMessage(Msg: Integer; WParam: Integer; LParam: Longint): TMessage;
begin
  {$IFNDEF CLR}
  Result.Msg := Msg;
  Result.WParam := WParam;
  Result.LParam := LParam;
  {$ELSE}
  Result := TMessage.Create(Msg, WParam, LParam);
  {$ENDIF CLR}
  Result.Result := 0;
end;

function CreateWMMessage(Msg: Integer; WParam: Integer; LParam: TControl): TMessage;
begin
  {$IFNDEF CLR}
  Result := CreateWMMessage(Msg, WParam, Integer(LParam));
  {$ELSE}
  Result := CreateWMMessage(Msg, WParam, 0);
  {$ENDIF !CLR}
end;

{ TStructPtrMessage }
constructor TStructPtrMessage.Create(Msg: Integer; WParam: Integer; var LParam);
begin
  inherited Create;
  {$IFNDEF CLR}
  Self.Msg.Msg := Msg;
  Self.Msg.WParam := WParam;
  Self.Msg.LParam := Longint(@LParam);
  {$ELSE}
  FBuf := Marshal.AllocHGlobal(Marshal.SizeOf(TObject(LParam)));
  FLParam := &Object(LParam);
  Marshal.StructureToPtr(FLParam, FBuf, False);
  Self.Msg := TMessage.Create(Msg, WParam, Longint(FBuf));
  {$ENDIF !CLR}
  Self.Msg.Result := 0;
end;

{$IFDEF CLR}
destructor TStructPtrMessage.Destroy;
begin
  FLParam := Marshal.PtrToStructure(FBuf, TypeOf(FLParam));
  Marshal.DestroyStructure(FBuf, TypeOf(FLParam));
  inherited Destroy;
end;
{$ENDIF CLR}

function SmallPointToLong(const Pt: TSmallPoint): Longint;
begin
  {$IFDEF CLR}
  Result := Int32(Pt.X) shl 16 or Pt.Y;
  {$ELSE}
  Result := Longint(Pt);
  {$ENDIF CLR}
end;

function ShiftStateToKeyData(Shift: TShiftState): Longint;
const
  AltMask = $20000000;
  CtrlMask = $10000000;
  ShiftMask = $08000000;
begin
  Result := 0;
  if ssAlt in Shift then
    Result := Result or AltMask;
  if ssCtrl in Shift then
    Result := Result or CtrlMask;
  if ssShift in Shift then
    Result := Result or ShiftMask;
end;

function GetFocusedControl(AControl: TControl): TWinControl;
var
  Form: TCustomForm;
begin
  Result := nil;
  Form := GetParentForm(AControl);
  if Assigned(Form) then
    Result := Form.ActiveControl;
end;

function DlgcToDlgCodes(Value: Longint): TDlgCodes;
begin
  Result := [];
  if (Value and DLGC_WANTARROWS) <> 0 then
    Include(Result, dcWantArrows);
  if (Value and DLGC_WANTTAB) <> 0 then
    Include(Result, dcWantTab);
  if (Value and DLGC_WANTALLKEYS) <> 0 then
    Include(Result, dcWantAllKeys);
  if (Value and DLGC_WANTCHARS) <> 0 then
    Include(Result, dcWantChars);
  if (Value and DLGC_BUTTON) <> 0 then
    Include(Result, dcButton);
  if (Value and DLGC_HASSETSEL) <> 0 then
    Include(Result, dcHasSetSel);
end;

function DlgCodesToDlgc(Value: TDlgCodes): Longint;
begin
  Result := 0;
  if dcWantAllKeys in Value then
    Result := Result or DLGC_WANTALLKEYS;
  if dcWantArrows in Value then
    Result := Result or DLGC_WANTARROWS;
  if dcWantTab in Value then
    Result := Result or DLGC_WANTTAB;
  if dcWantChars in Value then
    Result := Result or DLGC_WANTCHARS;
  if dcButton in Value then
    Result := Result or DLGC_BUTTON;
  if dcHasSetSel in Value then
    Result := Result or DLGC_HASSETSEL;
end;

procedure GetHintColor(var HintInfo: THintInfo; AControl: TControl; HintColor: TColor);
var
  AHintInfo: THintInfo;
begin
  case HintColor of
    clNone:
      HintInfo.HintColor := Application.HintColor;
    clDefault:
      begin
        if Assigned(AControl) and Assigned(AControl.Parent) then
        begin
          AHintInfo := HintInfo;
          {$IFNDEF CLR}
          AControl.Parent.Perform(CM_HINTSHOW, 0, Integer(@AHintInfo));
          {$ELSE}
          AControl.Parent.Perform(CM_HINTSHOW, 0, AHintInfo);
          {$ENDIF !CLR}
          HintInfo.HintColor := AHintInfo.HintColor;
        end;
      end;
  else
    HintInfo.HintColor := HintColor;
  end;
end;

function DispatchIsDesignMsg(Control: TControl; var Msg: TMessage): Boolean;
var
  Form: TCustomForm;
begin
  Result := False;
  case Msg.Msg of
    WM_SETFOCUS, WM_KILLFOCUS, WM_NCHITTEST,
    WM_MOUSEFIRST..WM_MOUSELAST,
    WM_KEYFIRST..WM_KEYLAST,
    WM_CANCELMODE:
      Exit; // These messages are handled in TWinControl.WndProc before IsDesignMsg() is called
  end;
  if (Control <> nil) and (csDesigning in Control.ComponentState) then
  begin
    Form := GetParentForm(Control);
    if (Form <> nil) and (Form.Designer <> nil) and
       Form.Designer.IsDesignMsg(Control, Msg) then
      Result := True;
  end;
end;

{$IFDEF COMPILER5}

{ Delphi 5's SetAutoSize is private and not virtual. This code installs a
  JUMP-Hook into SetAutoSize that jumps to our function. }
var
  AutoSizeOffset: Cardinal;
  TControl_SetAutoSize: Pointer;

type
  PBoolean = ^Boolean;
  TControlAccessProtected = class(TControl)
  published
    property AutoSize;
  end;

procedure OrgSetAutoSize(AControl: TControl; Value: Boolean);
asm
        DD    0, 0, 0, 0  // 16 Bytes
end;

procedure TOpenControl_SetAutoSize(AControl: TControl; Value: Boolean);
begin
  // same as OrgSetAutoSize(AControl, Value); but secure
  with TControlAccessProtected(AControl) do
    if AutoSize <> Value then
    begin
      PBoolean(Cardinal(AControl) + AutoSizeOffset)^ := Value;
      if Value then
        AdjustSize;
    end;
end;

procedure SetAutoSizeHook(AControl: TControl; Value: Boolean);
var
  Msg: TMessage;
begin
  if AControl.GetInterfaceEntry(IJvExControl) <> nil then
  begin
    Msg.Msg := CM_SETAUTOSIZE;
    Msg.WParam := Ord(Value);
    AControl.Dispatch(Msg);
  end
  else
    TOpenControl_SetAutoSize(AControl, Value);
end;

procedure InitHookVars;
var
  Info: PPropInfo;
begin
  Info := GetPropInfo(TControlAccessProtected, 'AutoSize');
  AutoSizeOffset := Integer(Info.GetProc) and $00FFFFFF;
  TControl_SetAutoSize := Info.SetProc;
end;

{$ENDIF COMPILER5}

//=== { TJvHotTrackOptions } ======================================

constructor TJvHotTrackOptions.Create;
begin
  inherited Create;
  FEnabled := False;
  FFrameVisible := False;
  FColor := $00D2BDB6;
  FFrameColor := $006A240A;
end;

procedure TJvHotTrackOptions.Assign(Source: TPersistent);
begin
  if Source is TJvHotTrackOptions then
  begin
    BeginUpdate;
    try
      Enabled := TJvHotTrackOptions(Source).Enabled;
      Color := TJvHotTrackOptions(Source).Color;
      FrameVisible := TJvHotTrackOptions(Source).FrameVisible;
      FrameColor := TJvHotTrackOptions(Source).FrameColor;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TJvHotTrackOptions.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    Changing;
    ChangingProperty('Color');
    FColor := Value;
    ChangedProperty('Color');
    Changed;
  end;
end;

procedure TJvHotTrackOptions.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    Changing;
    ChangingProperty('Enabled');
    FEnabled := Value;
    ChangedProperty('Enabled');
    Changed;
  end;
end;

procedure TJvHotTrackOptions.SetFrameVisible(Value: Boolean);
begin
  if FFrameVisible <> Value then
  begin
    Changing;
    ChangingProperty('FrameVisible');
    FFrameVisible := Value;
    ChangedProperty('FrameVisible');
    Changed;
  end;
end;

procedure TJvHotTrackOptions.SetFrameColor(Value: TColor);
begin
  if FFrameColor <> Value then
  begin
    Changing;
    ChangingProperty('FrameColor');
    FFrameColor := Value;
    ChangedProperty('FrameColor');
    Changed;
  end;
end;

//============================================================================

CONTROL_IMPL_DEFAULT(Control)

WINCONTROL_IMPL_DEFAULT(WinControl)

CONTROL_IMPL_DEFAULT(GraphicControl)

WINCONTROL_IMPL_DEFAULT(CustomControl)

WINCONTROL_IMPL_DEFAULT(HintWindow)

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  {$IFDEF COMPILER5}
  InitHookVars;
  InstallProcHook(TControl_SetAutoSize, @SetAutoSizeHook, @OrgSetAutoSize);
  {$ENDIF COMPILER5}

finalization
  {$IFDEF COMPILER5}
  UninstallProcHook(@OrgSetAutoSize);
  {$ENDIF COMPILER5}
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.

