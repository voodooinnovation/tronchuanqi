�
 TMAINFORM 0�  TPF0	TMainFormMainFormLeft� Top�Width�Height� CaptionUdp Sender (Broadcast)Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	OnClose	FormCloseOnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight TLabelLabel1LeftTop7WidthJHeightCaptionDestination port  TLabelLabel2Left� Top8Width0HeightCaption
Local Port  TButton
SendButtonLeft� TopWidthKHeightCaption&SendDefault	TabOrderOnClickSendButtonClick  TEditMessageEditLeftTopWidth� HeightTabOrder TextMessageEdit  TEditPortEditLeftxTop4Width)HeightTabOrderTextPortEdit  TEditLocalPortEditLeftTop4Width)HeightTabOrderTextLocalPortEditOnChangeLocalPortEditChange  	TCheckBoxAnyPortCheckBoxLeft� TopPWidthqHeight	AlignmenttaLeftJustifyCaptionSystem choose portTabOrderOnClickAnyPortCheckBoxClick  TWSocketWSocketLineMode	LineLimit   LineEnd
LineEchoLineEditPrototcp	LocalAddr0.0.0.0	LocalPort0	LastError MultiThreaded	MultiCastMultiCastIpTTL	ReuseAddrComponentOptions ListenBacklog	ReqVerLow
ReqVerHigh
OnDataSentWSocketDataSentFlushTimeout<	SendFlagswsSendNormalLingerOnOff
wsLingerOnLingerTimeout 
SocksLevel5SocksAuthenticationsocksNoAuthenticationLeftDTop   