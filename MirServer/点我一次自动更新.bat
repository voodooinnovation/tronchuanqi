@echo off
echo �����ļ��ļ�����ǰ,ȷ���������Ѿ��ر������г���!
pause

set MSDIR=D:\MirServer
Copy DBServer.exe %MSDIR%\DBServer\ /y
Copy LoginSrv.exe %MSDIR%\LoginSrv\ /y
Copy RunGate.exe %MSDIR%\RunGate\ /y
Copy SelGate.exe %MSDIR%\SelGate\ /y
Copy LoginGate.exe %MSDIR%\LoginGate\ /y
Copy M2Server.exe %MSDIR%\Mir200\ /y
Copy IPLocal.dll %MSDIR%\Mir200\ /y
Copy zPlugOfShop.dll %MSDIR%\Mir200\ /y
Copy zPlugOfEngine.dll %MSDIR%\Mir200\ /y
Copy GameCenter.exe %MSDIR%\ /y
Copy LogDataServer.exe %MSDIR%\LogServer\ /y
echo �����ļ��ļ��Ѹ������. . .
pause