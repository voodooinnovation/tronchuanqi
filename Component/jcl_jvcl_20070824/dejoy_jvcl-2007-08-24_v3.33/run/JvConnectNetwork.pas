{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvConnectNetwork.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvConnectNetwork.pas 10612 2006-05-19 19:04:09Z jfudickar $

unit JvConnectNetwork;

{$I jvcl.inc}
{$I windowsonly.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows,
  JvBaseDlg;

type
  TJvConnectNetwork = class(TJvCommonDialog)
  published
    function Execute: Boolean; override;
  end;

  TJvDisconnectNetwork = class(TJvCommonDialog)
  published
    function Execute: Boolean; override;
  end;

  TJvNetworkConnect = class(TJvCommonDialog)
  private
    FConnect: Boolean;
  published
    property Connect: Boolean read FConnect write FConnect;
    function Execute: Boolean; override;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/run/JvConnectNetwork.pas $';
    Revision: '$Revision: 10612 $';
    Date: '$Date: 2006-05-19 12:04:09 -0700 (Fri, 19 May 2006) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation


function TJvConnectNetwork.Execute: Boolean;
begin
  Result := WNetConnectionDialog(GetForegroundWindow, RESOURCETYPE_DISK) = NO_ERROR;
end;

function TJvDisconnectNetwork.Execute: Boolean;
begin
  Result := WNetDisconnectDialog(GetForegroundWindow, RESOURCETYPE_DISK) = NO_ERROR;
end;

function TJvNetworkConnect.Execute: Boolean;
begin
  if FConnect then
    Result := WNetConnectionDialog(GetForegroundWindow, RESOURCETYPE_DISK) = NO_ERROR
  else
    Result := WNetDisconnectDialog(GetForegroundWindow, RESOURCETYPE_DISK) = NO_ERROR;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

