object SmtpTestForm: TSmtpTestForm
  Left = 93
  Top = 294
  Width = 582
  Height = 477
  Caption = 'SmtpTestForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MsgMemo: TMemo
    Left = 0
    Top = 185
    Width = 574
    Height = 120
    Hint = 'Enter the message text in this memo'
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'MsgMemo')
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 0
  end
  object DisplayMemo: TMemo
    Left = 0
    Top = 388
    Width = 574
    Height = 55
    Hint = 'This memo shows info messages'
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'DisplayMemo')
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 1
  end
  object ToolsPanel: TPanel
    Left = 0
    Top = 0
    Width = 574
    Height = 185
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 22
      Top = 11
      Width = 51
      Height = 13
      Caption = 'SMTP Host'
    end
    object Label2: TLabel
      Left = 54
      Top = 36
      Width = 24
      Height = 13
      Caption = 'From'
    end
    object Label3: TLabel
      Left = 222
      Top = 36
      Width = 12
      Height = 13
      Caption = 'To'
    end
    object Subject: TLabel
      Left = 41
      Top = 82
      Width = 36
      Height = 13
      Caption = 'Subject'
    end
    object Label4: TLabel
      Left = 216
      Top = 11
      Width = 20
      Height = 13
      Caption = 'Port'
    end
    object Label5: TLabel
      Left = 12
      Top = 171
      Width = 69
      Height = 13
      Caption = 'Message text:'
    end
    object Label8: TLabel
      Left = 214
      Top = 84
      Width = 20
      Height = 13
      Caption = 'Sign'
    end
    object Label9: TLabel
      Left = 29
      Top = 108
      Width = 48
      Height = 13
      Caption = 'Username'
    end
    object Label10: TLabel
      Left = 212
      Top = 108
      Width = 22
      Height = 13
      Caption = 'Pass'
    end
    object Label11: TLabel
      Left = 9
      Top = 132
      Width = 70
      Height = 13
      Caption = 'Authentication'
    end
    object Label12: TLabel
      Left = 64
      Top = 60
      Width = 12
      Height = 13
      Caption = 'Cc'
    end
    object Label13: TLabel
      Left = 216
      Top = 60
      Width = 16
      Height = 13
      Caption = 'Bcc'
    end
    object Label14: TLabel
      Left = 204
      Top = 132
      Width = 34
      Height = 13
      Caption = 'Priority'
    end
    object HostEdit: TEdit
      Left = 80
      Top = 8
      Width = 121
      Height = 21
      Hint = 'Mail server hostname or IP address'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = 'HostEdit'
    end
    object FromEdit: TEdit
      Left = 80
      Top = 32
      Width = 121
      Height = 21
      Hint = 'Author'#39's EMail'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = 'FromEdit'
    end
    object ToEdit: TEdit
      Left = 240
      Top = 32
      Width = 121
      Height = 21
      Hint = 'Destinators, delimited by semicolons'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = 'ToEdit'
    end
    object SubjectEdit: TEdit
      Left = 80
      Top = 80
      Width = 121
      Height = 21
      Hint = 'Message subject'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Text = 'SubjectEdit'
    end
    object SignOnEdit: TEdit
      Left = 240
      Top = 80
      Width = 121
      Height = 21
      Hint = 'Signon message for the HELO command'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Text = 'SignOnEdit'
    end
    object PortEdit: TEdit
      Left = 240
      Top = 8
      Width = 121
      Height = 21
      Hint = 'Mail server port (should be smtp)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = 'PortEdit'
    end
    object ClearDisplayButton: TButton
      Left = 448
      Top = 88
      Width = 73
      Height = 17
      Hint = 'Clear info message memo'
      Caption = 'Clear &Info'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 23
      OnClick = ClearDisplayButtonClick
    end
    object ConnectButton: TButton
      Left = 368
      Top = 8
      Width = 73
      Height = 17
      Hint = 'Connect to the mail server'
      Caption = 'Connect'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = ConnectButtonClick
    end
    object HeloButton: TButton
      Left = 368
      Top = 28
      Width = 73
      Height = 17
      Hint = 'Send the signon message'
      Caption = 'Helo'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = HeloButtonClick
    end
    object MailFromButton: TButton
      Left = 368
      Top = 88
      Width = 73
      Height = 17
      Hint = 'Send the mail originator'
      Caption = 'MailFrom'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      OnClick = MailFromButtonClick
    end
    object RcptToButton: TButton
      Left = 368
      Top = 108
      Width = 73
      Height = 17
      Hint = 'Send the mail recipents'
      Caption = 'RcptTo'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 17
      OnClick = RcptToButtonClick
    end
    object DataButton: TButton
      Left = 368
      Top = 128
      Width = 73
      Height = 17
      Hint = 'Send mail text and attached files'
      Caption = 'Data'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      OnClick = DataButtonClick
    end
    object AbortButton: TButton
      Left = 448
      Top = 68
      Width = 73
      Height = 17
      Hint = 'Abort current operation and close'
      Caption = 'Abort'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 22
      OnClick = AbortButtonClick
    end
    object QuitButton: TButton
      Left = 448
      Top = 48
      Width = 73
      Height = 17
      Hint = 'Quit mail server'
      Caption = 'Quit'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 21
      OnClick = QuitButtonClick
    end
    object MailButton: TButton
      Left = 448
      Top = 28
      Width = 73
      Height = 17
      Hint = 'MailFrom, RcptTo and Data combined'
      Caption = 'Mail'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 20
      OnClick = MailButtonClick
    end
    object OpenButton: TButton
      Left = 448
      Top = 8
      Width = 73
      Height = 17
      Hint = 'Connect and Helo combined'
      Caption = 'Open'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 19
      OnClick = DataButtonClick
    end
    object UsernameEdit: TEdit
      Left = 80
      Top = 104
      Width = 121
      Height = 21
      TabOrder = 8
      Text = 'UsernameEdit'
    end
    object PasswordEdit: TEdit
      Left = 240
      Top = 104
      Width = 121
      Height = 21
      TabOrder = 9
      Text = 'PasswordEdit'
    end
    object AuthComboBox: TComboBox
      Left = 80
      Top = 128
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 10
      Items.Strings = (
        'None'
        'Plain'
        'Login'
        'CramMD5'
        'CarmSHA1'
        'AutoSelect')
    end
    object EhloButton: TButton
      Left = 368
      Top = 48
      Width = 73
      Height = 17
      Caption = 'Ehlo'
      TabOrder = 14
      OnClick = EhloButtonClick
    end
    object AuthButton: TButton
      Left = 368
      Top = 68
      Width = 73
      Height = 17
      Caption = 'Auth'
      TabOrder = 15
      OnClick = AuthButtonClick
    end
    object CcEdit: TEdit
      Left = 80
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 4
      Text = 'CcEdit'
    end
    object BccEdit: TEdit
      Left = 240
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 5
      Text = 'BccEdit'
    end
    object AllInOneButton: TButton
      Left = 448
      Top = 128
      Width = 73
      Height = 17
      Hint = 
        'Connect, Helo, MailFrom, RcptTo, Data and Quit all chained in a ' +
        'single action.'
      Caption = 'All In One'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 24
      OnClick = AllInOneButtonClick
    end
    object PriorityComboBox: TComboBox
      Left = 240
      Top = 128
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
      Items.Strings = (
        'Not specified'
        'Highest'
        'High'
        'Normal'
        'Low'
        'Lowest')
    end
    object ConfirmCheckBox: TCheckBox
      Left = 38
      Top = 152
      Width = 55
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Confirm'
      TabOrder = 25
    end
  end
  object AttachPanel: TPanel
    Left = 0
    Top = 305
    Width = 574
    Height = 17
    Align = alTop
    TabOrder = 3
    object Label6: TLabel
      Left = 16
      Top = 2
      Width = 70
      Height = 13
      Caption = 'Attached files:'
    end
  end
  object FileAttachMemo: TMemo
    Left = 0
    Top = 322
    Width = 574
    Height = 49
    Hint = 'Enter the attached file path, one per line'
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'FileAttachMemo')
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 4
  end
  object InfoPanel: TPanel
    Left = 0
    Top = 371
    Width = 574
    Height = 17
    Align = alTop
    TabOrder = 5
    object Label7: TLabel
      Left = 16
      Top = 2
      Width = 74
      Height = 13
      Caption = 'Info messages:'
    end
  end
  object SmtpClient: TSmtpCli
    Tag = 0
    ShareMode = smtpShareDenyWrite
    LocalAddr = '0.0.0.0'
    Port = 'smtp'
    AuthType = smtpAuthNone
    ConfirmReceipt = False
    HdrPriority = smtpPriorityNone
    CharSet = 'iso-8859-1'
    SendMode = smtpToSocket
    DefaultEncoding = smtpEnc7bit
    Allow8bitChars = True
    FoldHeaders = False
    WrapMessageText = False
    ContentType = smtpPlainText
    OwnHeaders = False
    OnDisplay = SmtpClientDisplay
    OnCommand = SmtpClientDisplay
    OnResponse = SmtpClientDisplay
    OnGetData = SmtpClientGetData
    OnHeaderLine = SmtpClientHeaderLine
    OnRequestDone = SmtpClientRequestDone
    Left = 488
    Top = 196
  end
end
