object RzGroupTemplatePreviewDlg: TRzGroupTemplatePreviewDlg
  Left = 204
  Top = 113
  BorderIcons = [biSystemMenu]
  ClientHeight = 92
  ClientWidth = 187
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBar: TRzGroupBar
    Left = 0
    Top = 0
    Width = 187
    Height = 92
    GradientColorStart = clBtnFace
    GradientColorStop = clBtnShadow
    GroupBorderSize = 8
    Align = alClient
    Color = clBtnShadow
    ParentColor = False
    TabOrder = 0
  end
end
