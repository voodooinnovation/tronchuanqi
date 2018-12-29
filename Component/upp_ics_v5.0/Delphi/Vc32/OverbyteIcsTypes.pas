{*_* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Author:       Fran�ois PIETTE
Description:
Creation:     April 2004
Version:      1.00
EMail:        francois.piette@overbyte.be  http://www.overbyte.be
Support:      Use the mailing list twsocket@elists.org
              Follow "support" link at http://www.overbyte.be for subscription.
Legal issues: Copyright (C) 2004-2006 by Fran�ois PIETTE
              Rue de Grady 24, 4053 Embourg, Belgium. Fax: +32-4-365.74.56
              <francois.piette@overbyte.be>

              This software is provided 'as-is', without any express or
              implied warranty.  In no event will the author be held liable
              for any  damages arising from the use of this software.

              Permission is granted to anyone to use this software for any
              purpose, including commercial applications, and to alter it
              and redistribute it freely, subject to the following
              restrictions:

              1. The origin of this software must not be misrepresented,
                 you must not claim that you wrote the original software.
                 If you use this software in a product, an acknowledgment
                 in the product documentation would be appreciated but is
                 not required.

              2. Altered source versions must be plainly marked as such, and
                 must not be misrepresented as being the original software.

              3. This notice may not be removed or altered from any source
                 distribution.

              4. You must register this software by sending a picture postcard
                 to the author. Use a nice stamp and mention your name, street
                 address, EMail address and any comment you like to say.

History:


 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit OverbyteIcsTypes;

interface

uses
{$IFDEF CLR}
  System.IO,
  System.Threading,
  System.Runtime.InteropServices;
{$ENDIF}
{$IFDEF WIN32}
  Windows, Messages, Classes, SysUtils;
{$ENDIF}

const
  OverbyteIcsTypesVersion = 100;
  CopyRight : String      = ' OverbyteIcsTypes (c) 2004-2006 F. Piette V1.00 ';

type
{$IFDEF CLR}
  Exception           = Borland.Delphi.System.Exception;
  THandle             = Integer;
  BOOL                = LongBool;
  HWND                = type LongWord;
  HINST               = type THandle;
  HICON               = type LongWord;
  HCURSOR             = HICON;
  HMENU               = type LongWord;
  UINT                = type LongWord;
  DWORD               = type LongWord;
  HBRUSH              = type LongWord;
  ATOM                = Word;
  WPARAM              = Longint;
  LPARAM              = Longint;
  LRESULT             = Longint;
  TFNWndProc          = function (p1: HWND; p2: UINT; p3: WPARAM; p4: LPARAM): LRESULT;
  TNotifyEvent        = procedure (sender: System.Object{; e: System.EventArgs}) of object;
  TPoint = packed record
    X : LongInt;
    Y : LongInt;
  end;
  TMessage = packed record
    Msg: Cardinal;
    WParam: Longint;
    LParam: Longint;
    Result: Longint;
  end;
  TMsg = packed record
    hwnd    : HWND;
    message : UINT;
    wParam  : WPARAM;
    lParam  : LPARAM;
    time    : DWORD;
    pt      : TPoint;
  end;

  [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)]
  TWndClass = packed record
    style          : UINT;
    [MarshalAs(UnmanagedType.FunctionPtr)]
    lpfnWndProc    : TFNWndProc;
    cbClsExtra     : Integer;
    cbWndExtra     : Integer;
    hInstance      : HINST;
    hIcon          : HICON;
    hCursor        : HCURSOR;
    hbrBackground  : HBRUSH;
    [MarshalAs(UnmanagedType.LPTStr)]
    lpszMenuName: string;
    [MarshalAs(UnmanagedType.LPTStr)]
    lpszClassName  : string;
  end;

  TWndClassInfo = packed record
    style          : UINT;
    lpfnWndProc    : IntPtr;
    cbClsExtra     : Integer;
    cbWndExtra     : Integer;
    hInstance      : HINST;
    hIcon          : HICON;
    hCursor        : HCURSOR;
    hbrBackground  : HBRUSH;
    lpszMenuName   : IntPtr;
    lpszClassName  : IntPtr;
  end;

  [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)]
  TCreateStruct = packed record
    lpCreateParams : IntPtr;
    hInstance      : HINST;
    hMenu          : HMENU;
    hwndParent     : HWND;
    cy             : Integer;
    cx             : Integer;
    y              : Integer;
    x              : Integer;
    style          : Longint;
    lpszName       : IntPtr;
    lpszClass      : IntPtr;
    dwExStyle      : DWORD;
  end;


{$ELSE}
  Exception           = SysUtils.Exception;
  TSearchRec          = SysUtils.TSearchRec;
  TMessage            = Messages.TMessage;
  TComponent          = Classes.TComponent;
  TNotifyEvent        = Classes.TNotifyEvent;
  TList               = Classes.TList;
  TStrings            = Classes.TStrings;
  TStringList         = Classes.TStringList;
  TOperation          = Classes.TOperation;
  HWND                = Windows.HWND;
  DWORD               = Windows.DWORD;
  UINT                = Windows.UINT;
  TRTLCriticalSection = Windows.TRTLCriticalSection;
  TWndClass           = Windows.TWndClass;
  TMsg                = Windows.TMsg;
  WPARAM              = Windows.WPARAM;
  LPARAM              = Windows.LPARAM;
  POverlapped         = Windows.POverlapped;
  FARPROC             = Windows.FARPROC;
  LRESULT             = Windows.LRESULT;
{$ENDIF}

  LOWORD = Word;

implementation

end.
