�
 TMAILROBFORM 0z  TPF0TMailRobFormMailRobFormLeft� Top� Width�Height�Caption MailRob - http://www.overbyte.beColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	OnClose	FormCloseOnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight TMemoDisplayMemoLeft TopEWidthxHeightuAlignalTopFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style Lines.StringsDisplayMemo 
ParentFontReadOnly	
ScrollBarsssBothTabOrder   TPanelTopPanelLeft Top WidthxHeightEAlignalTopTabOrder TLabel	InfoLabelLeft$TopWidth,HeightCaption	InfoLabel  TButtonGetFromMbxButtonLeftTopWidtheHeightCaption&Get List from MBXTabOrder OnClickGetFromMbxButtonClick  TEditMbxFileEditLeft� TopWidth�HeightHint�Enter the full path for the MBX file to scan the subject for SUBSCRIBE and extract EMail addresses. An MBX file is a Microsoft Internet Mail file.ParentShowHintShowHint	TabOrderTextMbxFileEdit
OnDblClickMbxFileEditDblClick  TButtonSaveToListButtonLeftTop$WidtheHeightCaption&Save List to fileTabOrderOnClickSaveToListButtonClick  TEditLstFileEditLeft� Top$Width�HeightTabOrderTextLstFileEdit
OnDblClickLstFileEditDblClick  TButtonLoadFromListButtonLeft Top$WidthQHeightCaption&Load From FileTabOrderOnClickLoadFromListButtonClick   TMemo	EMailMemoLeft Top)WidthxHeight� AlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style Lines.Strings	EMailMemo 
ParentFontTabOrder  TPanelMiddlePanelLeft Top� WidthxHeightoAlignalTopTabOrder TLabelLabel1LeftTopWidth7HeightCaption	SMTP Host  TLabelLabel2Left0Top$WidthHeightCaptionFrom  TLabelSubjectLeftTopVWidth$HeightCaptionSubject  TLabelLabel4Left TopWidthHeightCaptionPort  TLabelLabel3LeftTop@Width$HeightCaptionMsg file  TEditHostEditLeftPTopWidth� HeightTabOrder TextHostEdit  TEditPortEditLeft8TopWidth1HeightTabOrderTextPortEdit  TEditFromEditLeftPTop Width� HeightTabOrderTextFromEdit  TEditSubjectEditLeft8TopTWidth�HeightTabOrderTextSubjectEdit  TEdit
SignOnEditLeft8Top Width� HeightTabOrderText
SignOnEdit  TButton
SendButtonLeft TopTWidtheHeightCaptionSend EMailsTabOrderOnClickSendButtonClick  TEditMsgFileEditLeft8Top<Width�HeightTabOrderTextMsgFileEdit
OnDblClickMsgFileEditDblClick  TButtonMsgFileLoadButtonLeft Top<Width1HeightCaptionL&oadTabOrderOnClickMsgFileLoadButtonClick  TButtonSaveMsgFileButtonLeft8Top<Width,HeightCaptionS&aveTabOrderOnClickSaveMsgFileButtonClick   TSyncSmtpCli
SmtpClientTag 	ShareModesmtpShareDenyWrite	LocalAddr0.0.0.0PortsmtpAuthTypesmtpAuthNoneConfirmReceiptHdrPrioritysmtpPriorityNormalCharSet
iso-8859-1SendModesmtpToSocketDefaultEncodingsmtpEnc7bitAllow8bitChars	FoldHeadersWrapMessageTextContentTypesmtpPlainText
OwnHeaders	OnCommandSmtpClientCommand
OnResponseSmtpClientResponse	OnGetDataSmtpClientGetDataTimeoutMultiThreadedLeft� Top\  TOpenDialogOpenDialog1Left� Top\   