object FmeListBoxes: TFmeListBoxes
  Left = 0
  Top = 0
  Width = 612
  Height = 458
  Color = 14872561
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  ParentColor = False
  ParentFont = False
  ParentShowHint = False
  ShowHint = True
  TabOrder = 0
  TabStop = True
  object GrpListBox: TRzGroupBox
    Left = 8
    Top = 44
    Width = 177
    Height = 133
    BorderOuter = fsFlat
    Caption = 'TRzListBox'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7879740
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    GradientColorStyle = gcsCustom
    GroupStyle = gsBanner
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    VisualStyle = vsClassic
    object LstTitles: TRzListBox
      Left = 1
      Top = 22
      Width = 175
      Height = 110
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      FrameVisible = True
      ItemHeight = 13
      Items.Strings = (
        'Action'
        'All I Want Is Everything'
        'Animal'
        'Another Hit and Run'
        'Armageddon It'
        'Blood Runs Cold'
        'Bringing on the Heartbreak'
        'Foolin'#39
        'From The Inside'
        'Hello America'
        'Hysteria'
        'Let'#39's Get Rocked'
        'Miss You In A Heartbeat'
        'Personal Property'
        'Photograph'
        'Pour Some Sugar On Me'
        'Ride Into The Sun'
        'Ring Of Fire'
        'Rock Of Ages'
        'Rock Rock (Till You Drop)'
        'Rocket'
        'Run Riot'
        'Slang'
        'Stand Up'
        'Switch 625'
        'Tear It Down'
        'Tonight'
        'Too Late For Love'
        'Two Steps Behind')
      ParentFont = False
      TabOrder = 0
    end
  end
  object GrpTRzTabbedListBox: TRzGroupBox
    Left = 196
    Top = 44
    Width = 353
    Height = 133
    BorderOuter = fsFlat
    Caption = 'TRzTabbedListBox'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7879740
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    GradientColorStyle = gcsCustom
    GroupStyle = gsBanner
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    VisualStyle = vsClassic
    object LstTimes: TRzTabbedListBox
      Left = 1
      Top = 41
      Width = 351
      Height = 91
      TabStops.Min = -2147483647
      TabStops.Max = 2147483647
      TabStops.Integers = (
        26
        40)
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      FrameSides = [sdLeft, sdRight, sdBottom]
      FrameVisible = True
      ItemHeight = 13
      Items.Strings = (
        'Action'#9'RetroActive'#9'3:41'
        'All I Want Is Everything'#9'Slang'#9'3:23'
        'Animal'#9'Hysteria'#9'4:02'
        'Another Hit and Run'#9'High '#39'n'#39' Dry'#9'4:59'
        'Armageddon It'#9'Hysteria'#9'5:21'
        'Blood Runs Cold'#9'Slang'#9'3:35'
        'Bringing on the Heartbreak'#9'High '#39'n'#39' Dry'#9'4:34'
        'Foolin'#39#9'Pyromania'#9'4:32'
        'From The Inside'#9'RetroActive'#9'4:13'
        'Hello America'#9'On Through the Night'#9'3:27'
        'Hysteria'#9'Hysteria'#9'5:49'
        'Let'#39's Get Rocked'#9'Adrenalize'#9'4:56'
        'Miss You In A Heartbeat'#9'RetroActive'#9'4:04'
        'Personal Property'#9'Adrenalize'#9'4:20'
        'Photograph'#9'Pyromania'#9'4:12'
        'Pour Some Sugar On Me'#9'Hysteria'#9'4:25'
        'Ride Into The Sun'#9'RetroActive'#9'3:12'
        'Ring Of Fire'#9'RetroActive'#9'4:42'
        'Rock Of Ages'#9'Pyromania'#9'4:09'
        'Rock Rock (Till You Drop)'#9'Pyromania'#9'3:52'
        'Rocket'#9'Hysteria'#9'6:34'
        'Run Riot'#9'Hysteria'#9'4:38'
        'Slang'#9'Slang'#9'3:48'
        'Stand Up'#9'Adrenalize'#9'4:31'
        'Switch 625'#9'High '#39'n'#39' Dry'#9'3:03'
        'Tear It Down'#9'Adrenalize'#9'3:38'
        'Tonight'#9'Adrenalize'#9'4:03'
        'Too Late For Love'#9'Pyromania'#9'4:30'
        'Two Steps Behind'#9'RetroActive'#9'4:16')
      ParentFont = False
      TabOrder = 0
    end
    object RzPanel1: TRzPanel
      Left = 1
      Top = 22
      Width = 351
      Height = 19
      Align = alTop
      BorderOuter = fsStatus
      BorderSides = [sdLeft, sdTop]
      TabOrder = 1
      object HdrTimes: THeader
        Left = 1
        Top = 1
        Width = 350
        Height = 18
        Align = alClient
        BorderStyle = bsNone
        Sections.Sections = (
          #0'178'#0'Title'
          #0'97'#0'Album'
          #0'48'#0'Duration')
        TabOrder = 0
        OnSized = HdrTimesSized
      end
    end
  end
  object GrpTRzCheckList: TRzGroupBox
    Left = 8
    Top = 188
    Width = 337
    Height = 225
    BorderOuter = fsFlat
    Caption = 'TRzCheckList'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7879740
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    GradientColorStyle = gcsCustom
    GroupStyle = gsBanner
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    VisualStyle = vsClassic
    object LstVersions: TRzCheckList
      Left = 1
      Top = 22
      Width = 335
      Height = 202
      TabStops.Min = -2147483647
      TabStops.Max = 2147483647
      TabStops.Integers = (
        -34
        41)
      Items.Strings = (
        '//Infielders'
        'Derrek Lee'#9'First Base'#9'0.315'
        'Nomar Garciapara'#9'Short Stop'#9'0.325'
        'Aramis Ramirez'#9'Third Base'#9'0.302'
        '//Outfielders'
        'Todd Hollandsworth'#9'Left Field'#9'0.295'
        'Jeromy Burnitz'#9'Right Field'#9'0.298'
        '//Pitchers'
        'Mark Prior'#9'RH'#9'0.187'
        'Greg Maddux'#9'RH'#9'0.186'
        'Kerry Wood'#9'RH'#9'0.194')
      Items.ItemEnabled = (
        True
        True
        False
        True
        True
        True
        True
        True
        True
        True
        False)
      Items.ItemState = (
        0
        1
        0
        0
        0
        0
        1
        0
        1
        0
        0)
      HighlightColor = 7879740
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      FrameVisible = True
      ItemHeight = 17
      ParentFont = False
      TabOrder = 0
    end
  end
  object GrpTRzEditListBox: TRzGroupBox
    Left = 356
    Top = 188
    Width = 193
    Height = 225
    BorderOuter = fsFlat
    Caption = 'TRzEditListBox'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7879740
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    GradientColorStyle = gcsCustom
    GroupStyle = gsBanner
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    VisualStyle = vsClassic
    object LstEditTitles: TRzEditListBox
      Left = 1
      Top = 22
      Width = 191
      Height = 202
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      FrameVisible = True
      ItemHeight = 13
      Items.Strings = (
        'Action'
        'All I Want Is Everything'
        'Animal'
        'Another Hit and Run'
        'Armageddon It'
        'Blood Runs Cold'
        'Bringing on the Heartbreak'
        'Foolin'#39
        'From The Inside'
        'Hello America'
        'Hysteria'
        'Let'#39's Get Rocked'
        'Miss You In A Heartbeat'
        'Personal Property'
        'Photograph'
        'Pour Some Sugar On Me'
        'Ride Into The Sun'
        'Ring Of Fire'
        'Rock Of Ages'
        'Rock Rock (Till You Drop)'
        'Rocket'
        'Run Riot'
        'Slang'
        'Stand Up'
        'Switch 625'
        'Tear It Down'
        'Tonight'
        'Too Late For Love'
        'Two Steps Behind')
      MultiSelect = True
      ParentFont = False
      TabOrder = 0
      AllowDeleteByKbd = True
    end
  end
  object pnlHeader: TRzPanel
    Left = 0
    Top = 0
    Width = 612
    Height = 35
    Align = alTop
    Alignment = taLeftJustify
    BorderOuter = fsFlat
    BorderSides = [sdBottom]
    Caption = 'List Box Controls'
    FlatColor = 10524310
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9856100
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    GradientColorStop = 11855600
    TextMargin = 4
    ParentFont = False
    TabOrder = 4
    VisualStyle = vsGradient
    WordWrap = False
  end
end
