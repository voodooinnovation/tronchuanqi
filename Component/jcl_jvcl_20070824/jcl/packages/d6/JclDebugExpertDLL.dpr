Library JclDebugExpertDLL;
{
-----------------------------------------------------------------------------
     DO NOT EDIT THIS FILE, IT IS GENERATED BY THE PACKAGE GENERATOR
            ALWAYS EDIT THE RELATED XML FILE (JclDebugExpertDLL-L.xml)

     Last generated: 07-05-2010  18:24:24 UTC
-----------------------------------------------------------------------------
}

{$R *.res}
{$ALIGN 8}
{$ASSERTIONS ON}
{$BOOLEVAL OFF}
{$DEBUGINFO OFF}
{$EXTENDEDSYNTAX ON}
{$IMPORTEDDATA ON}
{$IOCHECKS ON}
{$LOCALSYMBOLS ON}
{$LONGSTRINGS ON}
{$OPENSTRINGS ON}
{$OPTIMIZATION ON}
{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}
{$REFERENCEINFO ON}
{$SAFEDIVIDE OFF}
{$STACKFRAMES OFF}
{$TYPEDADDRESS OFF}
{$VARSTRINGCHECKS ON}
{$WRITEABLECONST OFF}
{$MINENUMSIZE 1}
{$IMAGEBASE $58020000}
{$DESCRIPTION 'JCL Debug IDE extension'}
{$LIBSUFFIX 'D60'}
{$IMPLICITBUILD OFF}

{$DEFINE WIN32}
{$DEFINE CONDITIONALEXPRESSIONS}
{$DEFINE VER140}
{$DEFINE RELEASE}

uses
  ToolsAPI,
  JclDebugIdeResult in '..\..\experts\debug\converter\JclDebugIdeResult.pas' {JclDebugResultForm},
  JclDebugIdeImpl in '..\..\experts\debug\converter\JclDebugIdeImpl.pas' ,
  JclDebugIdeConfigFrame in '..\..\experts\debug\converter\JclDebugIdeConfigFrame.pas' {JclDebugIdeConfigFrame: TFrame}
  ;

exports
  JCLWizardInit name WizardEntryPoint;

end.
