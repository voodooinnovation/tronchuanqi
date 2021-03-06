object FmeLauncher: TFmeLauncher
  Left = 0
  Top = 0
  Width = 574
  Height = 393
  Color = 14872561
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  TabStop = True
  object RzGroupBox1: TRzGroupBox
    Left = 8
    Top = 44
    Width = 461
    Height = 161
    Caption = 'TRzLauncher'
    FlatColor = 9856100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    GroupStyle = gsUnderline
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    VisualStyle = vsClassic
    object RzLabel2: TRzLabel
      Left = 12
      Top = 32
      Width = 56
      Height = 13
      Caption = '&File Name'
      FocusControl = EdtFileName
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
      BevelWidth = 0
    end
    object RzLabel6: TRzLabel
      Left = 12
      Top = 60
      Width = 66
      Height = 13
      Caption = '&Parameters'
      FocusControl = EdtParameters
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
      BevelWidth = 0
    end
    object RzSeparator2: TRzSeparator
      Left = 12
      Top = 128
      Width = 437
      HighlightColor = 7879740
      ShowGradient = True
      Color = 14872561
      ParentColor = False
    end
    object RzSeparator1: TRzSeparator
      Left = 12
      Top = 88
      Width = 437
      HighlightColor = 7879740
      ShowGradient = True
      Color = 14872561
      ParentColor = False
    end
    object EdtFileName: TRzButtonEdit
      Left = 85
      Top = 28
      Width = 368
      Height = 21
      Text = 'Notepad.exe'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      FrameVisible = True
      ParentFont = False
      TabOrder = 0
      ButtonKind = bkFolder
      FlatButtons = True
      OnButtonClick = EdtFileNameButtonClick
    end
    object EdtParameters: TRzEdit
      Left = 85
      Top = 56
      Width = 368
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      FrameVisible = True
      ParentFont = False
      TabOrder = 1
    end
    object ChkWait: TRzCheckBox
      Left = 84
      Top = 100
      Width = 133
      Height = 17
      Caption = '&Wait Until Finished'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      HotTrack = True
      ParentFont = False
      State = cbUnchecked
      TabOrder = 2
    end
    object BtnLaunch: TRzButton
      Left = 375
      Top = 96
      Caption = 'Launch'
      Color = 15791348
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      HotTrack = True
      ParentFont = False
      TabOrder = 3
      OnClick = BtnLaunchClick
    end
    object BtnExecute: TRzButton
      Left = 375
      Top = 136
      Caption = 'Execute'
      Color = 15791348
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      HotTrack = True
      ParentFont = False
      TabOrder = 4
      OnClick = BtnExecuteClick
    end
    object ChkIgnoreErrors: TRzCheckBox
      Left = 84
      Top = 140
      Width = 115
      Height = 17
      Caption = '&Ignore Errors'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      HotTrack = True
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 8
    Top = 236
    Width = 461
    Height = 85
    Caption = 'TRzURLLabel'
    FlatColor = 9856100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    GroupStyle = gsUnderline
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    VisualStyle = vsClassic
    object RzLabel3: TRzLabel
      Left = 8
      Top = 28
      Width = 119
      Height = 13
      Caption = 'Product Information:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
      BevelWidth = 0
    end
    object RzURLLabel4: TRzURLLabel
      Left = 168
      Top = 28
      Width = 144
      Height = 13
      Caption = 'http://www.raize.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7879740
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
      BevelWidth = 0
      URL = 'http://www.raize.com'
      UnvisitedColor = 7879740
      VisitedColor = 4611970
    end
    object RzLabel4: TRzLabel
      Left = 8
      Top = 48
      Width = 107
      Height = 13
      Caption = 'Technical Support:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
      BevelWidth = 0
    end
    object RzURLLabel5: TRzURLLabel
      Left = 168
      Top = 48
      Width = 170
      Height = 13
      Caption = 'mailto:support@raize.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7879740
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
      BevelWidth = 0
      URL = 'mailto:support@raize.com'
      UnvisitedColor = 7879740
      VisitedColor = 4611970
    end
    object RzURLLabel6: TRzURLLabel
      Left = 167
      Top = 68
      Width = 189
      Height = 13
      Caption = 'raize.public.rzcomps.support'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7879740
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
      BevelWidth = 0
      URL = 'news://news.raize.com/raize.public.rzcomps.support'
      UnvisitedColor = 7879740
      VisitedColor = 4611970
    end
    object RzLabel5: TRzLabel
      Left = 8
      Top = 68
      Width = 117
      Height = 13
      Caption = 'Newsgroup Support:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
      BevelWidth = 0
    end
  end
  object pnlHeader: TRzPanel
    Left = 0
    Top = 0
    Width = 574
    Height = 35
    Align = alTop
    Alignment = taLeftJustify
    BorderOuter = fsFlat
    BorderSides = [sdBottom]
    Caption = 'Application Launcher Components'
    FlatColor = 10524310
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9856100
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    GradientColorStop = 11855600
    TextMargin = 4
    ParentFont = False
    TabOrder = 2
    VisualStyle = vsGradient
    WordWrap = False
  end
  object RzLauncher1: TRzLauncher
    Action = 'Open'
    Timeout = -1
    OnFinished = RzLauncher1Finished
    OnError = RzLauncher1Error
    Left = 12
    Top = 88
  end
  object DlgOpen: TRzOpenDialog
    Options = [osoFileMustExist, osoHideReadOnly, osoPathMustExist, osoAllowTree, osoShowHints, osoOleDrag, osoOleDrop, osoShowHidden]
    Left = 480
    Top = 52
  end
end
