{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: Compiler5MissingPropertyFix.pas, released on 2004-03-31.

The Initial Developer of the Original Code is Andreas Hausladen
(Andreas dott Hausladen att gmx dott de)
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL
home page, located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: MissingPropertyFix.pas 11051 2006-11-27 22:26:43Z outchy $

unit MissingPropertyFix;

{$I jvcl.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Buttons;

implementation

uses
  JclSysUtils;

{$IFNDEF COMPILER7_UP}

type
  TNativeBitBtn = class(TBitBtn)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

type
  TOpenButton = class(TButton);
  TOpenBitBtn = class(TBitBtn);

procedure TNativeBitBtn.CreateParams(var Params: TCreateParams);
var
  p: procedure(Instance: TObject; var Params: TCreateParams);
begin
  p := @TOpenButton.CreateParams;
  p(Self, Params);
end;

procedure HookBitBtn;
type
  TJump = packed record
    Jmp: Byte; // $E9;
    Offset: Integer;
  end;
var
  Jump: TJump;
  DestP, OldP: Pointer;
  WrittenBytes: Cardinal;
begin
  if IsLibrary then
    raise Exception.Create('Not allowed in a DLL');
  Jump.Jmp := $E9;

  DestP := @TNativeBitBtn.CreateParams;
  OldP := @TOpenBitBtn.CreateParams;
  Jump.Offset := Integer(DestP) - Integer(OldP) - SizeOf(TJump);
  WriteProtectedMemory(OldP, @Jump, SizeOf(TJump), WrittenBytes);
end;

{$ENDIF !COMPILER7_UP}

{$IFNDEF COMPILER10_UP}

type
  TMissingPropertyFix = class(TReader)
  private
    FPropDefined: Boolean;
  protected
    procedure DefineProperty(const Name: string;
      ReadData: TReaderProc; WriteData: TWriterProc;
      HasData: Boolean); override;
  protected
    {$IFDEF COMPILER5}
    procedure ReadWinControlDesignSize(Reader: TReader);
    {$ENDIF COMPILER5}
    {$IFNDEF COMPILER10_UP}
    procedure ReadControlExplicitProp(Reader: TReader);
    {$ENDIF ~COMPILER10_UP}
    procedure DefineProperties(Filer: TFiler);
  end;

{$IFDEF COMPILER5}
procedure TMissingPropertyFix.ReadWinControlDesignSize(Reader: TReader);
begin
  Reader.ReadListBegin;
  Reader.ReadInteger;
  Reader.ReadInteger;
  Reader.ReadListEnd;
end;
{$ENDIF COMPILER5}

{$IFNDEF COMPILER10_UP}
procedure TMissingPropertyFix.ReadControlExplicitProp(Reader: TReader);
begin
  Reader.ReadInteger;
end;
{$ENDIF ~COMPILER10_UP}

procedure TMissingPropertyFix.DefineProperties(Filer: TFiler);
begin
  {$IFDEF COMPILER5}
  if Root is TWinControl then
    Filer.DefineProperty('DesignSize', ReadWinControlDesignSize, nil, False);
  {$ENDIF COMPILER5}
  {$IFNDEF COMPILER10_UP}
  if Root is TControl then
  begin
    Filer.DefineProperty('ExplicitLeft', ReadControlExplicitProp, nil, False);
    Filer.DefineProperty('ExplicitTop', ReadControlExplicitProp, nil, False);
    Filer.DefineProperty('ExplicitWidth', ReadControlExplicitProp, nil, False);
    Filer.DefineProperty('ExplicitHeight', ReadControlExplicitProp, nil, False);
  end;
  {$ENDIF ~COMPILER10_UP}
end;

procedure TMissingPropertyFix.DefineProperty(const Name: string;
  ReadData: TReaderProc; WriteData: TWriterProc;
  HasData: Boolean);
begin
  if not FPropDefined then
  begin
    FPropDefined := True;
    try
      DefineProperties(Self);
    finally
      FPropDefined := False;
    end;
  end;
  inherited DefineProperty(Name, ReadData, WriteData, HasData);
end;


function NewInstanceHook(ReaderClass: TClass): TObject;
begin
  Result := TMissingPropertyFix.NewInstance;
end;

type
  PVmt = ^TVmt;
  TVmt = array[0..MaxWord - 1] of Pointer;

{$R-}
procedure ReplaceVmtField(Vmt: PVmt; VmtOffset: Integer; Value: Pointer);
var
  Index: Integer;
  OldProt, Dummy: Cardinal;
begin
  Index := VmtOffset div SizeOf(Pointer);
  if VirtualProtect(@vmt[Index], SizeOf(Pointer), PAGE_EXECUTE_READWRITE, @OldProt) then
  begin
    Vmt[Index] := Value;
    VirtualProtect(@Vmt[Index], SizeOf(Pointer), OldProt, Dummy);
  end;
end;
{$R+}

procedure ReplaceDefineProperty;
begin
  {$IFDEF COMPILER6_UP}
  {$WARNINGS OFF}
  {$ENDIF COMPILER6_UP}
  ReplaceVmtField(PVmt(TReader), vmtNewInstance, @NewInstanceHook);
  {$IFDEF COMPILER6_UP}
  {$WARNINGS ON}
  {$ENDIF COMPILER6_UP}
end;

{$ENDIF ~COMPILER10_UP}

initialization
  {$IFNDEF COMPILER10_UP}
  ReplaceDefineProperty;
  {$ENDIF ~COMPILER10_UP}

  {$IFNDEF COMPILER7_UP}
  HookBitBtn;
  {$ENDIF !COMPILER7_UP}

end.
