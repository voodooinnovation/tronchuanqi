object SimpleMainForm: TSimpleMainForm
  Left = 573
  Top = 130
  BorderStyle = bsDialog
  Caption = 'JvInspector simple example'
  ClientHeight = 755
  ClientWidth = 923
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 250
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object JvInspector1: TJvInspector
    Left = 0
    Top = 0
    Width = 344
    Height = 755
    Style = isItemPainter
    Align = alClient
    RelativeDivider = True
    Divider = 47
    ItemHeight = 16
    AfterDataCreate = JvInspector1AfterDataCreate
    BeforeSelection = JvInspector1BeforeSelection
  end
  object Panel1: TPanel
    Left = 344
    Top = 0
    Width = 579
    Height = 755
    Align = alRight
    TabOrder = 1
    object Label1: TLabel
      Left = 4
      Top = 8
      Width = 163
      Height = 104
      Caption = 
        'To Use Inspector you need a painter component and the inspector ' +
        'itself. Set the inspector'#39's painter property, then add some item' +
        's. In this example, see AddComponent for the simplest way to ins' +
        'pect a component at runtime.'
      WordWrap = True
    end
    object Edit1: TEdit
      Left = 48
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object Memo1: TMemo
      Left = 16
      Top = 128
      Width = 169
      Height = 577
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssBoth
      TabOrder = 1
    end
    object ListBox1: TListBox
      Left = 256
      Top = 144
      Width = 121
      Height = 97
      ItemHeight = 13
      TabOrder = 2
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 559
    Top = 32
  end
  object SaveDialog1: TSaveDialog
    Left = 584
    Top = 32
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 551
    Top = 8
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 583
    Top = 8
  end
end
