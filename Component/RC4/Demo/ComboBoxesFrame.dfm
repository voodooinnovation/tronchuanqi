object FmeComboBoxes: TFmeComboBoxes
  Left = 0
  Top = 0
  Width = 511
  Height = 367
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
  object grpTRzComboBox: TRzGroupBox
    Left = 8
    Top = 44
    Width = 225
    Height = 101
    Caption = 'TRzComboBox'
    GroupStyle = gsUnderline
    ParentColor = True
    TabOrder = 0
    object RzBorder1: TRzBorder
      Left = 0
      Top = 17
      Width = 225
      Height = 84
      BorderOuter = fsFlat
      BorderSides = [sdLeft, sdTop]
      Align = alClient
    end
    object cbxStandard: TRzComboBox
      Left = 8
      Top = 72
      Width = 205
      Height = 21
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      FlatButtons = True
      FrameVisible = True
      ItemHeight = 13
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
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
    end
    object optDropDown: TRzRadioButton
      Left = 8
      Top = 24
      Width = 97
      Height = 17
      Caption = 'csDropDown'
      Checked = True
      HighlightColor = 7879740
      HotTrack = True
      TabOrder = 0
      TabStop = True
      OnClick = ComboStyleChange
    end
    object optDropDownList: TRzRadioButton
      Left = 108
      Top = 24
      Width = 113
      Height = 17
      Caption = 'csDropDownList'
      HighlightColor = 7879740
      HotTrack = True
      TabOrder = 1
      OnClick = ComboStyleChange
    end
    object chkAllowEdit: TRzCheckBox
      Left = 8
      Top = 48
      Width = 89
      Height = 17
      Caption = 'Allow Edit'
      Checked = True
      HighlightColor = 7879740
      HotTrack = True
      State = cbChecked
      TabOrder = 3
      OnClick = chkAllowEditClick
    end
  end
  object grpTRzMRUComboBox: TRzGroupBox
    Left = 8
    Top = 152
    Width = 225
    Height = 57
    Caption = 'TRzMRUComboBox'
    GroupStyle = gsUnderline
    ParentColor = True
    TabOrder = 1
    object RzBorder3: TRzBorder
      Left = 0
      Top = 17
      Width = 225
      Height = 40
      BorderOuter = fsFlat
      BorderSides = [sdLeft, sdTop]
      Align = alClient
    end
    object cbxMRU: TRzMRUComboBox
      Left = 8
      Top = 28
      Width = 205
      Height = 21
      MruRegIniFile = RzRegIniFile1
      MruSection = 'ComboMRU'
      MruID = 'History'
      RemoveItemCaption = '&Remove item from history list'
      Ctl3D = False
      FlatButtons = True
      FrameVisible = True
      ItemHeight = 13
      Items.Strings = (
        'Mickey Mouse'
        'Minnie Mouse'
        'Donald Duck'
        'Pluto'
        'Goofy'
        'Daisy Duck'
        'Simba'
        'Mufasa'
        'Timon'
        'Pumbaa'
        'Ariel'
        'Sabastian'
        'Belle'
        'Lumiere')
      ParentCtl3D = False
      TabOrder = 0
    end
  end
  object grpTRzColorComboBox: TRzGroupBox
    Left = 8
    Top = 220
    Width = 225
    Height = 113
    Caption = 'TRzColorComboBox'
    GroupStyle = gsUnderline
    ParentColor = True
    TabOrder = 2
    object RzLabel1: TRzLabel
      Left = 12
      Top = 24
      Width = 41
      Height = 13
      AutoSize = False
      Caption = 'Show'
      BevelWidth = 0
    end
    object RzBorder4: TRzBorder
      Left = 0
      Top = 17
      Width = 225
      Height = 96
      BorderOuter = fsFlat
      BorderSides = [sdLeft, sdTop]
      Align = alClient
    end
    object cbxColors: TRzColorComboBox
      Left = 8
      Top = 84
      Width = 205
      Height = 22
      ColorNames.Default = 'Default'
      ColorNames.Black = 'Black'
      ColorNames.Maroon = 'Maroon'
      ColorNames.Green = 'Green'
      ColorNames.Olive = 'Olive'
      ColorNames.Navy = 'Navy'
      ColorNames.Purple = 'Purple'
      ColorNames.Teal = 'Teal'
      ColorNames.Gray = 'Gray'
      ColorNames.Silver = 'Silver'
      ColorNames.Red = 'Red'
      ColorNames.Lime = 'Lime'
      ColorNames.Yellow = 'Yellow'
      ColorNames.Blue = 'Blue'
      ColorNames.Fuchsia = 'Fuchsia'
      ColorNames.Aqua = 'Aqua'
      ColorNames.White = 'White'
      ColorNames.ScrollBar = 'ScrollBar'
      ColorNames.Background = 'Background'
      ColorNames.ActiveCaption = 'ActiveCaption'
      ColorNames.InactiveCaption = 'InactiveCaption'
      ColorNames.Menu = 'Menu'
      ColorNames.Window = 'Window'
      ColorNames.WindowFrame = 'WindowFrame'
      ColorNames.MenuText = 'MenuText'
      ColorNames.WindowText = 'WindowText'
      ColorNames.CaptionText = 'CaptionText'
      ColorNames.ActiveBorder = 'ActiveBorder'
      ColorNames.InactiveBorder = 'InactiveBorder'
      ColorNames.AppWorkSpace = 'AppWorkSpace'
      ColorNames.Highlight = 'Highlight'
      ColorNames.HighlightText = 'HighlightText'
      ColorNames.BtnFace = 'BtnFace'
      ColorNames.BtnShadow = 'BtnShadow'
      ColorNames.GrayText = 'GrayText'
      ColorNames.BtnText = 'BtnText'
      ColorNames.InactiveCaptionText = 'InactiveCaptionText'
      ColorNames.BtnHighlight = 'BtnHighlight'
      ColorNames.DkShadow3D = '3DDkShadow'
      ColorNames.Light3D = '3DLight'
      ColorNames.InfoText = 'InfoText'
      ColorNames.InfoBk = 'InfoBk'
      ColorNames.Custom = 'Custom'
      DefaultColor = clBtnFace
      SelectedColor = clBtnFace
      Ctl3D = False
      FlatButtons = True
      FrameVisible = True
      ItemHeight = 16
      ParentCtl3D = False
      TabOrder = 4
      OnChange = cbxColorsChange
    end
    object OptShowSysColors: TRzCheckBox
      Left = 12
      Top = 40
      Width = 109
      Height = 17
      Caption = 'System Colors'
      Checked = True
      HighlightColor = 7879740
      HotTrack = True
      State = cbChecked
      TabOrder = 0
      OnClick = OptShowSysColorsClick
    end
    object OptShowColorNames: TRzCheckBox
      Left = 12
      Top = 60
      Width = 97
      Height = 17
      Caption = 'Color Names'
      Checked = True
      HighlightColor = 7879740
      HotTrack = True
      State = cbChecked
      TabOrder = 2
      OnClick = OptShowColorNamesClick
    end
    object OptShowDefault: TRzCheckBox
      Left = 124
      Top = 40
      Width = 61
      Height = 17
      Caption = 'Default'
      Checked = True
      HighlightColor = 7879740
      HotTrack = True
      State = cbChecked
      TabOrder = 1
      OnClick = OptShowDefaultClick
    end
    object OptShowCustom: TRzCheckBox
      Left = 124
      Top = 60
      Width = 69
      Height = 17
      Caption = 'Custom'
      Checked = True
      HighlightColor = 7879740
      HotTrack = True
      State = cbChecked
      TabOrder = 3
      OnClick = OptShowCustomClick
    end
  end
  object grpTRzFontComboBox: TRzGroupBox
    Left = 244
    Top = 44
    Width = 253
    Height = 289
    Caption = 'TRzFontComboBox'
    GradientColorStyle = gcsCustom
    GroupStyle = gsUnderline
    ParentColor = True
    TabOrder = 3
    object RzBorder2: TRzBorder
      Left = 0
      Top = 17
      Width = 253
      Height = 272
      BorderOuter = fsFlat
      BorderSides = [sdLeft, sdTop]
      Align = alClient
    end
    object cbxFonts: TRzFontComboBox
      Left = 8
      Top = 180
      Width = 233
      Height = 22
      Ctl3D = False
      FlatButtons = True
      FrameVisible = True
      ItemHeight = 16
      ParentCtl3D = False
      TabOrder = 3
      OnChange = cbxFontsChange
    end
    object GrpFontDevice: TRzRadioGroup
      Left = 8
      Top = 24
      Width = 241
      Height = 35
      Caption = 'Font Device'
      Columns = 2
      GroupStyle = gsCustom
      ItemHotTrack = True
      ItemHighlightColor = 7879740
      ItemIndex = 0
      Items.Strings = (
        'Screen'
        'Printer')
      ParentColor = True
      SpaceEvenly = True
      StartYPos = 0
      TabOrder = 0
      OnClick = GrpFontDeviceClick
    end
    object GrpFontType: TRzRadioGroup
      Left = 8
      Top = 64
      Width = 241
      Height = 51
      Caption = 'Font Type'
      Columns = 2
      GroupStyle = gsCustom
      ItemHotTrack = True
      ItemHighlightColor = 7879740
      ItemIndex = 0
      Items.Strings = (
        'All'
        'TrueType'
        'Fixed Pitch'
        'Printer')
      ParentColor = True
      SpaceEvenly = True
      StartYPos = 0
      TabOrder = 1
      VerticalSpacing = 0
      OnClick = GrpFontTypeClick
    end
    object GrpShowStyle: TRzRadioGroup
      Left = 8
      Top = 120
      Width = 241
      Height = 51
      Caption = 'Show Style'
      Columns = 2
      GroupStyle = gsCustom
      ItemHotTrack = True
      ItemHighlightColor = 7879740
      ItemIndex = 0
      Items.Strings = (
        'Font Name'
        'Font Sample'
        'Name && Sample'
        'Font Preview')
      ParentColor = True
      SpaceEvenly = True
      StartYPos = 0
      TabOrder = 2
      VerticalSpacing = 0
      OnClick = GrpShowStyleClick
    end
    object pnlPreview: TRzPanel
      Left = 8
      Top = 224
      Width = 233
      Height = 61
      BorderOuter = fsFlat
      Caption = 'Raize Components'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 4
    end
  end
  object pnlHeader: TRzPanel
    Left = 0
    Top = 0
    Width = 511
    Height = 35
    Align = alTop
    Alignment = taLeftJustify
    BorderOuter = fsFlat
    BorderSides = [sdBottom]
    Caption = 'Combo Box Controls'
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
  object RzRegIniFile1: TRzRegIniFile
    Left = 24
    Top = 320
  end
end
