object FmeEdits: TFmeEdits
  Left = 0
  Top = 0
  Width = 457
  Height = 364
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
  object GrpEdits: TRzGroupBox
    Left = 8
    Top = 248
    Width = 397
    Height = 77
    Caption = 'TRzEdit and TRzMaskEdit'
    ParentColor = True
    TabOrder = 3
    object RzLabel5: TRzLabel
      Left = 8
      Top = 24
      Width = 57
      Height = 13
      AutoSize = False
      Caption = 'TRzEdit'
      BevelWidth = 0
    end
    object RzLabel6: TRzLabel
      Left = 8
      Top = 52
      Width = 85
      Height = 13
      AutoSize = False
      Caption = 'TRzMaskEdit'
      BevelWidth = 0
    end
    object Label1: TLabel
      Left = 204
      Top = 52
      Width = 159
      Height = 13
      Caption = 'EditMask = '#39'#,###.##;1;0'#39
    end
    object RzEdit1: TRzEdit
      Left = 100
      Top = 20
      Width = 289
      Height = 21
      Text = 'TRzEdit supports right-justified text'
      Alignment = taRightJustify
      FrameController = RzFrameController1
      TabOrder = 0
    end
    object RzMaskEdit1: TRzMaskEdit
      Left = 100
      Top = 48
      Width = 81
      Height = 21
      Alignment = taRightJustify
      EditMask = '#,###.##;1;0'
      FrameController = RzFrameController1
      MaxLength = 8
      TabOrder = 1
      Text = '1,234.56'
    end
  end
  object GrpSpinEdits: TRzGroupBox
    Left = 8
    Top = 104
    Width = 161
    Height = 137
    Caption = 'TRzSpinEdit'
    ParentColor = True
    TabOrder = 1
    object RzLabel1: TRzLabel
      Left = 8
      Top = 112
      Width = 73
      Height = 13
      Caption = 'Button Width'
      BevelWidth = 0
    end
    object spnPreview: TRzSpinEdit
      Left = 8
      Top = 20
      Width = 145
      Height = 21
      Decimals = 2
      Increment = 0.01
      Max = 1000
      PageSize = 1
      FrameController = RzFrameController1
      TabOrder = 0
    end
    object chkSpnFlat: TRzCheckBox
      Left = 8
      Top = 48
      Width = 77
      Height = 17
      Caption = 'Flat Buttons'
      Checked = True
      HighlightColor = 7879740
      HotTrack = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkSpnFlatClick
    end
    object chkHorzBtns: TRzCheckBox
      Left = 8
      Top = 68
      Width = 129
      Height = 17
      Caption = 'Horizontal Buttons'
      HighlightColor = 7879740
      HotTrack = True
      State = cbUnchecked
      TabOrder = 2
      OnClick = chkHorzBtnsClick
    end
    object chkDirection: TRzCheckBox
      Left = 8
      Top = 88
      Width = 145
      Height = 17
      Caption = 'Direction (Left-Right)'
      HighlightColor = 7879740
      HotTrack = True
      State = cbUnchecked
      TabOrder = 3
      OnClick = chkDirectionClick
    end
    object SpnButtonWidth: TRzSpinner
      Left = 88
      Top = 110
      Width = 65
      Max = 30
      Min = 10
      Value = 17
      OnChange = SpnButtonWidthChange
      ParentColor = False
      TabOrder = 4
    end
  end
  object GrpButtonEdits: TRzGroupBox
    Left = 180
    Top = 104
    Width = 225
    Height = 137
    Caption = 'TRzButtonEdit'
    ParentColor = True
    TabOrder = 2
    object RzLabel2: TRzLabel
      Left = 8
      Top = 72
      Width = 83
      Height = 13
      AutoSize = False
      Caption = 'Primary Button'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7879740
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      BevelWidth = 0
      LightTextStyle = True
    end
    object RzLabel3: TRzLabel
      Left = 124
      Top = 72
      Width = 93
      Height = 13
      AutoSize = False
      Caption = 'Alternate Button'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7879740
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      BevelWidth = 0
      LightTextStyle = True
    end
    object bedPreview: TRzButtonEdit
      Left = 8
      Top = 20
      Width = 209
      Height = 21
      FrameController = RzFrameController1
      TabOrder = 0
    end
    object chkBtnFlat: TRzCheckBox
      Left = 8
      Top = 48
      Width = 77
      Height = 17
      Caption = 'Flat Buttons'
      Checked = True
      HighlightColor = 7879740
      HotTrack = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkBtnFlatClick
    end
    object chkButtonVisible: TRzCheckBox
      Left = 8
      Top = 88
      Width = 65
      Height = 17
      Caption = 'Visible'
      Checked = True
      HighlightColor = 7879740
      HotTrack = True
      State = cbChecked
      TabOrder = 2
      OnClick = chkButtonVisibleClick
    end
    object chkAltBtnVisible: TRzCheckBox
      Left = 124
      Top = 88
      Width = 65
      Height = 17
      Caption = 'Visible'
      HighlightColor = 7879740
      HotTrack = True
      State = cbUnchecked
      TabOrder = 3
      OnClick = chkAltBtnVisibleClick
    end
    object CbxButtonKind: TRzComboBox
      Left = 8
      Top = 108
      Width = 97
      Height = 21
      Style = csDropDownList
      Ctl3D = False
      FrameController = RzFrameController1
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 4
      Text = 'bkLookup'
      OnChange = CbxButtonKindChange
      Items.Strings = (
        'bkLookup'
        'bkDropDown'
        'bkCalendar '
        'bkAccept'
        'bkReject'
        'bkFolder'
        'bkFind'
        'bkSearch')
      ItemIndex = 0
    end
    object CbxAltBtnKind: TRzComboBox
      Left = 124
      Top = 108
      Width = 97
      Height = 21
      Style = csDropDownList
      Ctl3D = False
      FrameController = RzFrameController1
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 5
      Text = 'bkLookup'
      OnChange = CbxAltBtnKindChange
      Items.Strings = (
        'bkLookup'
        'bkDropDown'
        'bkCalendar '
        'bkAccept'
        'bkReject'
        'bkFolder'
        'bkFind'
        'bkSearch')
      ItemIndex = 0
    end
  end
  object GrpDateTimeColor: TRzGroupBox
    Left = 8
    Top = 44
    Width = 397
    Height = 53
    Caption = 'TRzDateTimeEdit and TRzColorEdit'
    ParentColor = True
    TabOrder = 0
    object RzDateTimeEdit1: TRzDateTimeEdit
      Left = 8
      Top = 20
      Width = 121
      Height = 21
      EditType = etDate
      FrameController = RzFrameController1
      TabOrder = 0
    end
    object RzDateTimeEdit2: TRzDateTimeEdit
      Left = 140
      Top = 20
      Width = 121
      Height = 21
      ShowHowToUseHint = False
      EditType = etTime
      FrameController = RzFrameController1
      TabOrder = 1
    end
    object RzColorEdit1: TRzColorEdit
      Left = 272
      Top = 20
      Width = 117
      Height = 21
      ShowNoColor = True
      ShowCustomColor = True
      ShowDefaultColor = True
      ShowSystemColors = True
      FrameController = RzFrameController1
      TabOrder = 2
    end
  end
  object pnlHeader: TRzPanel
    Left = 0
    Top = 0
    Width = 457
    Height = 35
    Align = alTop
    Alignment = taLeftJustify
    BorderOuter = fsFlat
    BorderSides = [sdBottom]
    Caption = 'Edit Controls'
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
  object RzFrameController1: TRzFrameController
    FrameVisible = True
    Left = 4
    Top = 296
  end
end
