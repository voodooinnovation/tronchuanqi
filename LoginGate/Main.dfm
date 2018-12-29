object frmMain: TfrmMain
  Left = 735
  Top = 290
  Caption = 'frmMain'
  ClientHeight = 243
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object StatusBar: TRzStatusBar
    Left = 0
    Top = 224
    Width = 419
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 0
    VisualStyle = vsGradient
    object StatusPane1: TRzStatusPane
      Left = 0
      Top = 0
      Width = 49
      Height = 19
      Align = alLeft
      Alignment = taCenter
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object StatusPane2: TRzStatusPane
      Left = 49
      Top = 0
      Width = 88
      Height = 19
      Align = alLeft
      Alignment = taCenter
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object StatusPane3: TRzStatusPane
      Left = 137
      Top = 0
      Width = 181
      Height = 19
      Align = alClient
      Alignment = taCenter
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object StatusPane4: TRzStatusPane
      Left = 318
      Top = 0
      Width = 101
      Height = 19
      Align = alRight
      Alignment = taCenter
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
  end
  object RzPanel: TRzPanel
    Left = 0
    Top = 0
    Width = 419
    Height = 224
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 1
    object ListViewLog: TRzListView
      Left = 0
      Top = 0
      Width = 419
      Height = 224
      Align = alClient
      Columns = <
        item
          Caption = #26102#38388
          Width = 120
        end
        item
          Caption = #20449#24687
          Width = 220
        end
        item
          Caption = #29366#24577
          Width = 59
        end>
      ColumnClick = False
      FrameVisible = True
      MultiSelect = True
      PopupMenu = PopupMenu
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = ListViewLogChange
    end
  end
  object TimerStart: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerStartTimer
    Left = 48
    Top = 56
  end
  object MainMenu: TMainMenu
    Left = 208
    Top = 56
    object MENU_CONTROL: TMenuItem
      Caption = #25511#21046'(&C)'
      object MENU_CONTROL_OPENATTACK: TMenuItem
        Caption = #24320#21551#25915#20987#20445#25252'(&A)'
        Checked = True
        OnClick = MENU_CONTROL_OPENATTACKClick
      end
      object MENU_CONTROL_CLEAELOG: TMenuItem
        Caption = #28165#38500#26085#24535'(&C)'
        OnClick = MENU_CONTROL_CLEAELOGClick
      end
      object MENU_START: TMenuItem
        Caption = #21551#21160#26381#21153'(&S)'
        OnClick = ButtonStartClick
      end
      object MENU_STOP: TMenuItem
        Caption = #20572#27490#26381#21153'(&T)'
        OnClick = ButtonStartClick
      end
      object MENU_LOADBLOCKIPLIST: TMenuItem
        Caption = #37325#26032#21152#36733'IP'#36807#28388#21015#34920'(&L)'
        OnClick = MENU_LOADBLOCKIPLISTClick
      end
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = #36864#20986'(&E)'
        OnClick = MENU_CONTROL_EXITClick
      end
    end
    object MENU_VIEW: TMenuItem
      Caption = #26597#30475'(&V)'
      object MENU_VIEW_LOGMSG: TMenuItem
        Caption = #26597#30475#26085#24535'(&L)'
        Checked = True
        OnClick = MENU_VIEW_LOGMSGClick
      end
      object MENU_VIEW_SENDMSG: TMenuItem
        Caption = #26597#30475#23553#21253'(&S)'
        OnClick = MENU_VIEW_SENDMSGClick
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&O)'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = MENU_OPTION_GENERALClick
      end
      object MENU_OPTION_IPFILTER: TMenuItem
        Caption = #23433#20840#36807#28388'(&S)'
        OnClick = MENU_OPTION_IPFILTERClick
      end
    end
    object H1: TMenuItem
      Caption = #24110#21161'(&H)'
      object MENU_OPTION_HELP: TMenuItem
        Caption = #20851#20110'(&S)'
        OnClick = MENU_OPTION_HELPClick
      end
    end
  end
  object PopupMenu: TPopupMenu
    Left = 176
    Top = 56
    object POPUPMENU_COPY: TMenuItem
      Caption = #22797#21046'(&C)'
      OnClick = POPUPMENU_COPYClick
    end
    object POPUPMENU_SELALL: TMenuItem
      Caption = #20840#36873'(&A)'
      OnClick = POPUPMENU_SELALLClick
    end
    object POPUPMENU_SAVE: TMenuItem
      Caption = #20445#23384
      Visible = False
      OnClick = POPUPMENU_SAVEClick
    end
  end
  object Timer: TTimer
    Interval = 10
    OnTimer = TimerTimer
    Left = 80
    Top = 53
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 112
    Top = 53
  end
  object HTTPGet: THTTPGet
    AcceptTypes = '*/*'
    Agent = 'UtilMind HTTPGet'
    BinaryData = False
    UseCache = False
    WaitThread = False
    OnDoneString = HTTPGetDoneString
    OnError = HTTPGetError
    Left = 144
    Top = 53
  end
end
