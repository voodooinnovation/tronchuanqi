object RzCheckListTabStopEditDlg: TRzCheckListTabStopEditDlg
  Left = 195
  Top = 115
  BorderStyle = bsDialog
  Caption = 'Tab Stop Editor'
  ClientHeight = 344
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TRzButton
    Left = 243
    Top = 312
    Default = True
    ModalResult = 1
    Caption = 'OK'
    HotTrack = True
    TabOrder = 2
  end
  object btnCancel: TRzButton
    Left = 326
    Top = 312
    Cancel = True
    ModalResult = 2
    Caption = 'Cancel'
    HotTrack = True
    TabOrder = 3
  end
  object grpPreview: TRzGroupBox
    Left = 8
    Top = 8
    Width = 393
    Height = 141
    Caption = 'Preview'
    TabOrder = 4
    object lstPreview: TRzCheckList
      Left = 9
      Top = 20
      Width = 376
      Height = 113
      FrameVisible = True
      HorzExtent = 21
      HorzScrollBar = True
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object grpTabStops: TRzGroupBox
    Left = 8
    Top = 204
    Width = 393
    Height = 97
    Caption = 'Edit Tab Stops'
    TabOrder = 1
    object lblMin: TRzLabel
      Left = 167
      Top = 41
      Width = 22
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      ParentColor = False
    end
    object lblMax: TRzLabel
      Left = 363
      Top = 41
      Width = 22
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '200'
      ParentColor = False
    end
    object Label3: TRzLabel
      Left = 232
      Top = 41
      Width = 64
      Height = 13
      Caption = 'Tab Stop #'
      ParentColor = False
    end
    object lblTabNum: TRzLabel
      Left = 296
      Top = 41
      Width = 7
      Height = 13
      Caption = '0'
      ParentColor = False
    end
    object lstTabs: TRzListBox
      Left = 88
      Top = 20
      Width = 69
      Height = 69
      FrameVisible = True
      ItemHeight = 13
      TabOrder = 0
      OnClick = lstTabsClick
    end
    object btnAdd: TRzButton
      Left = 8
      Top = 20
      Width = 70
      Caption = 'Add'
      HotTrack = True
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btnDelete: TRzButton
      Left = 8
      Top = 52
      Width = 70
      Caption = 'Delete'
      Enabled = False
      HotTrack = True
      TabOrder = 3
      OnClick = btnDeleteClick
    end
    object chkRightAligned: TRzCheckBox
      Left = 176
      Top = 18
      Width = 97
      Height = 17
      Caption = 'Right Aligned'
      HotTrack = True
      State = cbUnchecked
      TabOrder = 1
      OnClick = chkRightAlignedClick
    end
    object trkTabPos: TRzTrackBar
      Left = 169
      Top = 59
      Width = 217
      Height = 28
      Position = 0
      ShowTicks = False
      TrackOffset = 10
      OnChange = trkTabPosChange
      Enabled = False
      TabOrder = 4
    end
  end
  object grpTabStopsMode: TRzRadioGroup
    Left = 8
    Top = 156
    Width = 393
    Height = 41
    Caption = 'TabStops Mode'
    Columns = 2
    ItemHotTrack = True
    Items.Strings = (
      'Manual'
      'Automatic')
    TabOrder = 0
    OnClick = grpTabStopsModeClick
  end
end
