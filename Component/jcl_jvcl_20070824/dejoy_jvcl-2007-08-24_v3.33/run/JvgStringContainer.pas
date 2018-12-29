{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvgStringContainer.PAS, released on 2003-01-15.

The Initial Developer of the Original Code is Andrey V. Chudin,  [chudin att yandex dott ru]
Portions created by Andrey V. Chudin are Copyright (C) 2003 Andrey V. Chudin.
All Rights Reserved.

Contributor(s):
Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvgStringContainer.pas 10612 2006-05-19 19:04:09Z jfudickar $

unit JvgStringContainer;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, Messages, SysUtils, Classes,
  JvComponentBase;
  {$ELSE}
  Windows, Messages, SysUtils, Classes;
  {$ENDIF USEJVCL}

type
  TOnReadItem = procedure(Sender: TObject; Idx: Integer) of object;

  {$IFDEF USEJVCL}
  TJvgStringContainer = class(TJvComponent)
  {$ELSE}
  TJvgStringContainer = class(TComponent)
  {$ENDIF USEJVCL}
  private
    FItems: TStringList;
    FReadOnly: Boolean;
    FOnReadItem: TOnReadItem;
    function GetString(Idx: Integer): string;
    function GetCount: Integer;
    function GetItems: TStrings;
    procedure SetString(Idx: Integer; const Value: string);
    procedure SetItems(Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Strings[Idx: Integer]: string read GetString write SetString; default;
  published
    property Items: TStrings read GetItems write SetItems;
    property Count: Integer read GetCount;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property OnReadItem: TOnReadItem read FOnReadItem write FOnReadItem;
  end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/run/JvgStringContainer.pas $';
    Revision: '$Revision: 10612 $';
    Date: '$Date: 2006-05-19 12:04:09 -0700 (Fri, 19 May 2006) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

uses
  JvgUtils, JvgTypes;

constructor TJvgStringContainer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TStringList.Create;
end;

destructor TJvgStringContainer.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TJvgStringContainer.GetString(Idx: Integer): string;
begin
  Result := Items[Idx];
  if Assigned(FOnReadItem) then
    FOnReadItem(Self, Idx);
end;

procedure TJvgStringContainer.SetString(Idx: Integer; const Value: string);
begin
  if not ReadOnly then
    Items[Idx] := Value;
end;

function TJvgStringContainer.GetItems: TStrings;
begin
  Result := FItems;
end;

procedure TJvgStringContainer.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

function TJvgStringContainer.GetCount: Integer;
begin
  Result := Items.Count;
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

