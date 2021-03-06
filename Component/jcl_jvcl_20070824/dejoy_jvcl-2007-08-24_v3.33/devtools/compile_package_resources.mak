ROOTDIR = $(MAKEDIR)\..

# ---------------------------------------------------------------------------
RESFILES = ..\packages\c5\Jv3rdC5R.res                     \
           ..\packages\c5\JvAppFrmC5D.res                  \
           ..\packages\c5\JvAppFrmC5R.res                  \
           ..\packages\c5\JvBandsC5D.res                   \
           ..\packages\c5\JvBandsC5R.res                   \
           ..\packages\c5\JvBDEC5D.res                     \
           ..\packages\c5\JvBDEC5R.res                     \
           ..\packages\c5\JvCmpC5D.res                     \
           ..\packages\c5\JvCmpC5R.res                     \
           ..\packages\c5\JvCoreC5D.res                    \
           ..\packages\c5\JvCoreC5R.res                    \
           ..\packages\c5\JvCryptC5D.res                   \
           ..\packages\c5\JvCryptC5R.res                   \
           ..\packages\c5\JvCtrlsC5D.res                   \
           ..\packages\c5\JvCtrlsC5R.res                   \
           ..\packages\c5\JvCustomC5D.res                  \
           ..\packages\c5\JvCustomC5R.res                  \
           ..\packages\c5\JvDBC5D.res                      \
           ..\packages\c5\JvDBC5R.res                      \
           ..\packages\c5\JvDlgsC5D.res                    \
           ..\packages\c5\JvDlgsC5R.res                    \
           ..\packages\c5\JvDockingC5D.res                 \
           ..\packages\c5\JvDockingC5R.res                 \
           ..\packages\c5\JvDotNetCtrlsC5D.res             \
           ..\packages\c5\JvDotNetCtrlsC5R.res             \
           ..\packages\c5\JvEDIC5D.res                     \
           ..\packages\c5\JvEDIC5R.res                     \
           ..\packages\c5\JvGlobusC5D.res                  \
           ..\packages\c5\JvGlobusC5R.res                  \
           ..\packages\c5\JvHMIC5D.res                     \
           ..\packages\c5\JvHMIC5R.res                     \
           ..\packages\c5\JvInterpreterC5D.res             \
           ..\packages\c5\JvInterpreterC5R.res             \
           ..\packages\c5\JvJansC5D.res                    \
           ..\packages\c5\JvJansC5R.res                    \
           ..\packages\c5\JvManagedThreadsC5D.res          \
           ..\packages\c5\JvManagedThreadsC5R.res          \
           ..\packages\c5\JvMMC5D.res                      \
           ..\packages\c5\JvMMC5R.res                      \
           ..\packages\c5\JvNetC5D.res                     \
           ..\packages\c5\JvNetC5R.res                     \
           ..\packages\c5\JvPageCompsC5D.res               \
           ..\packages\c5\JvPageCompsC5R.res               \
           ..\packages\c5\JvPluginC5D.res                  \
           ..\packages\c5\JvPluginC5R.res                  \
           ..\packages\c5\JvPrintPreviewC5D.res            \
           ..\packages\c5\JvPrintPreviewC5R.res            \
           ..\packages\c5\JvRuntimeDesignC5D.res           \
           ..\packages\c5\JvRuntimeDesignC5R.res           \
           ..\packages\c5\JvStdCtrlsC5D.res                \
           ..\packages\c5\JvStdCtrlsC5R.res                \
           ..\packages\c5\JvSystemC5D.res                  \
           ..\packages\c5\JvSystemC5R.res                  \
           ..\packages\c5\JvTimeFrameworkC5D.res           \
           ..\packages\c5\JvTimeFrameworkC5R.res           \
           ..\packages\c5\JvUIBC5D.res                     \
           ..\packages\c5\JvUIBC5R.res                     \
           ..\packages\c5\JvValidatorsC5D.res              \
           ..\packages\c5\JvValidatorsC5R.res              \
           ..\packages\c5\JvWizardC5D.res                  \
           ..\packages\c5\JvWizardC5R.res                  \
           ..\packages\c5\JvXPCtrlsC5D.res                 \
           ..\packages\c5\JvXPCtrlsC5R.res                 \
           ..\packages\c5std\JvCoreC5R.res                 \
           ..\packages\c5std\JvDotNetCtrlsC5R.res          \
           ..\packages\c5std\JvGlobusC5D.res               \
           ..\packages\c5std\JvGlobusC5R.res               \
           ..\packages\c5std\JvInterpreterC5D.res          \
           ..\packages\c5std\JvInterpreterC5R.res          \
           ..\packages\c5std\JvRuntimeDesignC5R.res        \
           ..\packages\c5std\JvUIBC5R.res                  \
           ..\packages\c6\Jv3rdC6R.res                     \
           ..\packages\c6\JvAppFrmC6D.res                  \
           ..\packages\c6\JvAppFrmC6R.res                  \
           ..\packages\c6\JvBandsC6D.res                   \
           ..\packages\c6\JvBandsC6R.res                   \
           ..\packages\c6\JvBDEC6D.res                     \
           ..\packages\c6\JvBDEC6R.res                     \
           ..\packages\c6\JvCmpC6D.res                     \
           ..\packages\c6\JvCmpC6R.res                     \
           ..\packages\c6\JvCoreC6D.res                    \
           ..\packages\c6\JvCoreC6R.res                    \
           ..\packages\c6\JvCryptC6D.res                   \
           ..\packages\c6\JvCryptC6R.res                   \
           ..\packages\c6\JvCtrlsC6D.res                   \
           ..\packages\c6\JvCtrlsC6R.res                   \
           ..\packages\c6\JvCustomC6D.res                  \
           ..\packages\c6\JvCustomC6R.res                  \
           ..\packages\c6\JvDBC6D.res                      \
           ..\packages\c6\JvDBC6R.res                      \
           ..\packages\c6\JvDlgsC6D.res                    \
           ..\packages\c6\JvDlgsC6R.res                    \
           ..\packages\c6\JvDockingC6D.res                 \
           ..\packages\c6\JvDockingC6R.res                 \
           ..\packages\c6\JvDotNetCtrlsC6D.res             \
           ..\packages\c6\JvDotNetCtrlsC6R.res             \
           ..\packages\c6\JvEDIC6D.res                     \
           ..\packages\c6\JvEDIC6R.res                     \
           ..\packages\c6\JvGlobusC6D.res                  \
           ..\packages\c6\JvGlobusC6R.res                  \
           ..\packages\c6\JvHMIC6D.res                     \
           ..\packages\c6\JvHMIC6R.res                     \
           ..\packages\c6\JvInterpreterC6D.res             \
           ..\packages\c6\JvInterpreterC6R.res             \
           ..\packages\c6\JvJansC6D.res                    \
           ..\packages\c6\JvJansC6R.res                    \
           ..\packages\c6\JvManagedThreadsC6D.res          \
           ..\packages\c6\JvManagedThreadsC6R.res          \
           ..\packages\c6\JvMMC6D.res                      \
           ..\packages\c6\JvMMC6R.res                      \
           ..\packages\c6\JvNetC6D.res                     \
           ..\packages\c6\JvNetC6R.res                     \
           ..\packages\c6\JvPageCompsC6D.res               \
           ..\packages\c6\JvPageCompsC6R.res               \
           ..\packages\c6\JvPluginC6D.res                  \
           ..\packages\c6\JvPluginC6R.res                  \
           ..\packages\c6\JvPrintPreviewC6D.res            \
           ..\packages\c6\JvPrintPreviewC6R.res            \
           ..\packages\c6\JvRuntimeDesignC6D.res           \
           ..\packages\c6\JvRuntimeDesignC6R.res           \
           ..\packages\c6\JvStdCtrlsC6D.res                \
           ..\packages\c6\JvStdCtrlsC6R.res                \
           ..\packages\c6\JvSystemC6D.res                  \
           ..\packages\c6\JvSystemC6R.res                  \
           ..\packages\c6\JvTimeFrameworkC6D.res           \
           ..\packages\c6\JvTimeFrameworkC6R.res           \
           ..\packages\c6\JvUIBC6D.res                     \
           ..\packages\c6\JvUIBC6R.res                     \
           ..\packages\c6\JvValidatorsC6D.res              \
           ..\packages\c6\JvValidatorsC6R.res              \
           ..\packages\c6\JvWizardC6D.res                  \
           ..\packages\c6\JvWizardC6R.res                  \
           ..\packages\c6\JvXPCtrlsC6D.res                 \
           ..\packages\c6\JvXPCtrlsC6R.res                 \
           ..\packages\c6per\JvCoreC6R.res                 \
           ..\packages\c6per\JvDotNetCtrlsC6R.res          \
           ..\packages\c6per\JvGlobusC6D.res               \
           ..\packages\c6per\JvGlobusC6R.res               \
           ..\packages\c6per\JvInterpreterC6D.res          \
           ..\packages\c6per\JvInterpreterC6R.res          \
           ..\packages\c6per\JvRuntimeDesignC6R.res        \
           ..\packages\c6per\JvUIBC6R.res                  \
           ..\packages\d10\Jv3rdD10R.res                   \
           ..\packages\d10\JvAppFrmD10D.res                \
           ..\packages\d10\JvAppFrmD10R.res                \
           ..\packages\d10\JvBandsD10D.res                 \
           ..\packages\d10\JvBandsD10R.res                 \
           ..\packages\d10\JvBDED10D.res                   \
           ..\packages\d10\JvBDED10R.res                   \
           ..\packages\d10\JvCmpD10D.res                   \
           ..\packages\d10\JvCmpD10R.res                   \
           ..\packages\d10\JvCoreD10D.res                  \
           ..\packages\d10\JvCoreD10R.res                  \
           ..\packages\d10\JvCryptD10D.res                 \
           ..\packages\d10\JvCryptD10R.res                 \
           ..\packages\d10\JvCtrlsD10D.res                 \
           ..\packages\d10\JvCtrlsD10R.res                 \
           ..\packages\d10\JvCustomD10D.res                \
           ..\packages\d10\JvCustomD10R.res                \
           ..\packages\d10\JvDBD10D.res                    \
           ..\packages\d10\JvDBD10R.res                    \
           ..\packages\d10\JvDlgsD10D.res                  \
           ..\packages\d10\JvDlgsD10R.res                  \
           ..\packages\d10\JvDockingD10D.res               \
           ..\packages\d10\JvDockingD10R.res               \
           ..\packages\d10\JvDotNetCtrlsD10D.res           \
           ..\packages\d10\JvDotNetCtrlsD10R.res           \
           ..\packages\d10\JvEDID10D.res                   \
           ..\packages\d10\JvEDID10R.res                   \
           ..\packages\d10\JvGlobusD10D.res                \
           ..\packages\d10\JvGlobusD10R.res                \
           ..\packages\d10\JvHMID10D.res                   \
           ..\packages\d10\JvHMID10R.res                   \
           ..\packages\d10\JvInterpreterD10D.res           \
           ..\packages\d10\JvInterpreterD10R.res           \
           ..\packages\d10\JvJansD10D.res                  \
           ..\packages\d10\JvJansD10R.res                  \
           ..\packages\d10\JvManagedThreadsD10D.res        \
           ..\packages\d10\JvManagedThreadsD10R.res        \
           ..\packages\d10\JvMMD10D.res                    \
           ..\packages\d10\JvMMD10R.res                    \
           ..\packages\d10\JvNetD10D.res                   \
           ..\packages\d10\JvNetD10R.res                   \
           ..\packages\d10\JvPageCompsD10D.res             \
           ..\packages\d10\JvPageCompsD10R.res             \
           ..\packages\d10\JvPluginD10D.res                \
           ..\packages\d10\JvPluginD10R.res                \
           ..\packages\d10\JvPrintPreviewD10D.res          \
           ..\packages\d10\JvPrintPreviewD10R.res          \
           ..\packages\d10\JvRuntimeDesignD10D.res         \
           ..\packages\d10\JvRuntimeDesignD10R.res         \
           ..\packages\d10\JvStdCtrlsD10D.res              \
           ..\packages\d10\JvStdCtrlsD10R.res              \
           ..\packages\d10\JvSystemD10D.res                \
           ..\packages\d10\JvSystemD10R.res                \
           ..\packages\d10\JvTimeFrameworkD10D.res         \
           ..\packages\d10\JvTimeFrameworkD10R.res         \
           ..\packages\d10\JvUIBD10D.res                   \
           ..\packages\d10\JvUIBD10R.res                   \
           ..\packages\d10\JvValidatorsD10D.res            \
           ..\packages\d10\JvValidatorsD10R.res            \
           ..\packages\d10\JvWizardD10D.res                \
           ..\packages\d10\JvWizardD10R.res                \
           ..\packages\d10\JvXPCtrlsD10D.res               \
           ..\packages\d10\JvXPCtrlsD10R.res               \
           ..\packages\d10per\JvCoreD10R.res               \
           ..\packages\d10per\JvDotNetCtrlsD10R.res        \
           ..\packages\d10per\JvGlobusD10D.res             \
           ..\packages\d10per\JvGlobusD10R.res             \
           ..\packages\d10per\JvInterpreterD10D.res        \
           ..\packages\d10per\JvInterpreterD10R.res        \
           ..\packages\d10per\JvRuntimeDesignD10R.res      \
           ..\packages\d10per\JvUIBD10R.res                \
           ..\packages\d5\Jv3rdD5R.res                     \
           ..\packages\d5\JvAppFrmD5D.res                  \
           ..\packages\d5\JvAppFrmD5R.res                  \
           ..\packages\d5\JvBandsD5D.res                   \
           ..\packages\d5\JvBandsD5R.res                   \
           ..\packages\d5\JvBDED5D.res                     \
           ..\packages\d5\JvBDED5R.res                     \
           ..\packages\d5\JvCmpD5D.res                     \
           ..\packages\d5\JvCmpD5R.res                     \
           ..\packages\d5\JvCoreD5D.res                    \
           ..\packages\d5\JvCoreD5R.res                    \
           ..\packages\d5\JvCryptD5D.res                   \
           ..\packages\d5\JvCryptD5R.res                   \
           ..\packages\d5\JvCtrlsD5D.res                   \
           ..\packages\d5\JvCtrlsD5R.res                   \
           ..\packages\d5\JvCustomD5D.res                  \
           ..\packages\d5\JvCustomD5R.res                  \
           ..\packages\d5\JvDBD5D.res                      \
           ..\packages\d5\JvDBD5R.res                      \
           ..\packages\d5\JvDlgsD5D.res                    \
           ..\packages\d5\JvDlgsD5R.res                    \
           ..\packages\d5\JvDockingD5D.res                 \
           ..\packages\d5\JvDockingD5R.res                 \
           ..\packages\d5\JvDotNetCtrlsD5D.res             \
           ..\packages\d5\JvDotNetCtrlsD5R.res             \
           ..\packages\d5\JvEDID5D.res                     \
           ..\packages\d5\JvEDID5R.res                     \
           ..\packages\d5\JvGlobusD5D.res                  \
           ..\packages\d5\JvGlobusD5R.res                  \
           ..\packages\d5\JvHMID5D.res                     \
           ..\packages\d5\JvHMID5R.res                     \
           ..\packages\d5\JvInterpreterD5D.res             \
           ..\packages\d5\JvInterpreterD5R.res             \
           ..\packages\d5\JvJansD5D.res                    \
           ..\packages\d5\JvJansD5R.res                    \
           ..\packages\d5\JvManagedThreadsD5D.res          \
           ..\packages\d5\JvManagedThreadsD5R.res          \
           ..\packages\d5\JvMMD5D.res                      \
           ..\packages\d5\JvMMD5R.res                      \
           ..\packages\d5\JvNetD5D.res                     \
           ..\packages\d5\JvNetD5R.res                     \
           ..\packages\d5\JvPageCompsD5D.res               \
           ..\packages\d5\JvPageCompsD5R.res               \
           ..\packages\d5\JvPluginD5D.res                  \
           ..\packages\d5\JvPluginD5R.res                  \
           ..\packages\d5\JvPrintPreviewD5D.res            \
           ..\packages\d5\JvPrintPreviewD5R.res            \
           ..\packages\d5\JvRuntimeDesignD5D.res           \
           ..\packages\d5\JvRuntimeDesignD5R.res           \
           ..\packages\d5\JvStdCtrlsD5D.res                \
           ..\packages\d5\JvStdCtrlsD5R.res                \
           ..\packages\d5\JvSystemD5D.res                  \
           ..\packages\d5\JvSystemD5R.res                  \
           ..\packages\d5\JvTimeFrameworkD5D.res           \
           ..\packages\d5\JvTimeFrameworkD5R.res           \
           ..\packages\d5\JvUIBD5D.res                     \
           ..\packages\d5\JvUIBD5R.res                     \
           ..\packages\d5\JvValidatorsD5D.res              \
           ..\packages\d5\JvValidatorsD5R.res              \
           ..\packages\d5\JvWizardD5D.res                  \
           ..\packages\d5\JvWizardD5R.res                  \
           ..\packages\d5\JvXPCtrlsD5D.res                 \
           ..\packages\d5\JvXPCtrlsD5R.res                 \
           ..\packages\d5std\JvCoreD5R.res                 \
           ..\packages\d5std\JvDotNetCtrlsD5R.res          \
           ..\packages\d5std\JvGlobusD5D.res               \
           ..\packages\d5std\JvGlobusD5R.res               \
           ..\packages\d5std\JvInterpreterD5D.res          \
           ..\packages\d5std\JvInterpreterD5R.res          \
           ..\packages\d5std\JvRuntimeDesignD5R.res        \
           ..\packages\d5std\JvUIBD5R.res                  \
           ..\packages\d6\Jv3rdD6R.res                     \
           ..\packages\d6\JvAppFrmD6D.res                  \
           ..\packages\d6\JvAppFrmD6R.res                  \
           ..\packages\d6\JvBandsD6D.res                   \
           ..\packages\d6\JvBandsD6R.res                   \
           ..\packages\d6\JvBDED6D.res                     \
           ..\packages\d6\JvBDED6R.res                     \
           ..\packages\d6\JvCmpD6D.res                     \
           ..\packages\d6\JvCmpD6R.res                     \
           ..\packages\d6\JvCoreD6D.res                    \
           ..\packages\d6\JvCoreD6R.res                    \
           ..\packages\d6\JvCryptD6D.res                   \
           ..\packages\d6\JvCryptD6R.res                   \
           ..\packages\d6\JvCtrlsD6D.res                   \
           ..\packages\d6\JvCtrlsD6R.res                   \
           ..\packages\d6\JvCustomD6D.res                  \
           ..\packages\d6\JvCustomD6R.res                  \
           ..\packages\d6\JvDBD6D.res                      \
           ..\packages\d6\JvDBD6R.res                      \
           ..\packages\d6\JvDlgsD6D.res                    \
           ..\packages\d6\JvDlgsD6R.res                    \
           ..\packages\d6\JvDockingD6D.res                 \
           ..\packages\d6\JvDockingD6R.res                 \
           ..\packages\d6\JvDotNetCtrlsD6D.res             \
           ..\packages\d6\JvDotNetCtrlsD6R.res             \
           ..\packages\d6\JvEDID6D.res                     \
           ..\packages\d6\JvEDID6R.res                     \
           ..\packages\d6\JvGlobusD6D.res                  \
           ..\packages\d6\JvGlobusD6R.res                  \
           ..\packages\d6\JvHMID6D.res                     \
           ..\packages\d6\JvHMID6R.res                     \
           ..\packages\d6\JvInterpreterD6D.res             \
           ..\packages\d6\JvInterpreterD6R.res             \
           ..\packages\d6\JvJansD6D.res                    \
           ..\packages\d6\JvJansD6R.res                    \
           ..\packages\d6\JvManagedThreadsD6D.res          \
           ..\packages\d6\JvManagedThreadsD6R.res          \
           ..\packages\d6\JvMMD6D.res                      \
           ..\packages\d6\JvMMD6R.res                      \
           ..\packages\d6\JvNetD6D.res                     \
           ..\packages\d6\JvNetD6R.res                     \
           ..\packages\d6\JvPageCompsD6D.res               \
           ..\packages\d6\JvPageCompsD6R.res               \
           ..\packages\d6\JvPluginD6D.res                  \
           ..\packages\d6\JvPluginD6R.res                  \
           ..\packages\d6\JvPrintPreviewD6D.res            \
           ..\packages\d6\JvPrintPreviewD6R.res            \
           ..\packages\d6\JvRuntimeDesignD6D.res           \
           ..\packages\d6\JvRuntimeDesignD6R.res           \
           ..\packages\d6\JvStdCtrlsD6D.res                \
           ..\packages\d6\JvStdCtrlsD6R.res                \
           ..\packages\d6\JvSystemD6D.res                  \
           ..\packages\d6\JvSystemD6R.res                  \
           ..\packages\d6\JvTimeFrameworkD6D.res           \
           ..\packages\d6\JvTimeFrameworkD6R.res           \
           ..\packages\d6\JvUIBD6D.res                     \
           ..\packages\d6\JvUIBD6R.res                     \
           ..\packages\d6\JvValidatorsD6D.res              \
           ..\packages\d6\JvValidatorsD6R.res              \
           ..\packages\d6\JvWizardD6D.res                  \
           ..\packages\d6\JvWizardD6R.res                  \
           ..\packages\d6\JvXPCtrlsD6D.res                 \
           ..\packages\d6\JvXPCtrlsD6R.res                 \
           ..\packages\d6per\JvCoreD6R.res                 \
           ..\packages\d6per\JvDotNetCtrlsD6R.res          \
           ..\packages\d6per\JvGlobusD6D.res               \
           ..\packages\d6per\JvGlobusD6R.res               \
           ..\packages\d6per\JvInterpreterD6D.res          \
           ..\packages\d6per\JvInterpreterD6R.res          \
           ..\packages\d6per\JvRuntimeDesignD6R.res        \
           ..\packages\d6per\JvUIBD6R.res                  \
           ..\packages\d7\Jv3rdD7R.res                     \
           ..\packages\d7\JvAppFrmD7D.res                  \
           ..\packages\d7\JvAppFrmD7R.res                  \
           ..\packages\d7\JvBandsD7D.res                   \
           ..\packages\d7\JvBandsD7R.res                   \
           ..\packages\d7\JvBDED7D.res                     \
           ..\packages\d7\JvBDED7R.res                     \
           ..\packages\d7\JvCmpD7D.res                     \
           ..\packages\d7\JvCmpD7R.res                     \
           ..\packages\d7\JvCoreD7D.res                    \
           ..\packages\d7\JvCoreD7R.res                    \
           ..\packages\d7\JvCryptD7D.res                   \
           ..\packages\d7\JvCryptD7R.res                   \
           ..\packages\d7\JvCtrlsD7D.res                   \
           ..\packages\d7\JvCtrlsD7R.res                   \
           ..\packages\d7\JvCustomD7D.res                  \
           ..\packages\d7\JvCustomD7R.res                  \
           ..\packages\d7\JvDBD7D.res                      \
           ..\packages\d7\JvDBD7R.res                      \
           ..\packages\d7\JvDlgsD7D.res                    \
           ..\packages\d7\JvDlgsD7R.res                    \
           ..\packages\d7\JvDockingD7D.res                 \
           ..\packages\d7\JvDockingD7R.res                 \
           ..\packages\d7\JvDotNetCtrlsD7D.res             \
           ..\packages\d7\JvDotNetCtrlsD7R.res             \
           ..\packages\d7\JvEDID7D.res                     \
           ..\packages\d7\JvEDID7R.res                     \
           ..\packages\d7\JvGlobusD7D.res                  \
           ..\packages\d7\JvGlobusD7R.res                  \
           ..\packages\d7\JvHMID7D.res                     \
           ..\packages\d7\JvHMID7R.res                     \
           ..\packages\d7\JvInterpreterD7D.res             \
           ..\packages\d7\JvInterpreterD7R.res             \
           ..\packages\d7\JvJansD7D.res                    \
           ..\packages\d7\JvJansD7R.res                    \
           ..\packages\d7\JvManagedThreadsD7D.res          \
           ..\packages\d7\JvManagedThreadsD7R.res          \
           ..\packages\d7\JvMMD7D.res                      \
           ..\packages\d7\JvMMD7R.res                      \
           ..\packages\d7\JvNetD7D.res                     \
           ..\packages\d7\JvNetD7R.res                     \
           ..\packages\d7\JvPageCompsD7D.res               \
           ..\packages\d7\JvPageCompsD7R.res               \
           ..\packages\d7\JvPluginD7D.res                  \
           ..\packages\d7\JvPluginD7R.res                  \
           ..\packages\d7\JvPrintPreviewD7D.res            \
           ..\packages\d7\JvPrintPreviewD7R.res            \
           ..\packages\d7\JvRuntimeDesignD7D.res           \
           ..\packages\d7\JvRuntimeDesignD7R.res           \
           ..\packages\d7\JvStdCtrlsD7D.res                \
           ..\packages\d7\JvStdCtrlsD7R.res                \
           ..\packages\d7\JvSystemD7D.res                  \
           ..\packages\d7\JvSystemD7R.res                  \
           ..\packages\d7\JvTimeFrameworkD7D.res           \
           ..\packages\d7\JvTimeFrameworkD7R.res           \
           ..\packages\d7\JvUIBD7D.res                     \
           ..\packages\d7\JvUIBD7R.res                     \
           ..\packages\d7\JvValidatorsD7D.res              \
           ..\packages\d7\JvValidatorsD7R.res              \
           ..\packages\d7\JvWizardD7D.res                  \
           ..\packages\d7\JvWizardD7R.res                  \
           ..\packages\d7\JvXPCtrlsD7D.res                 \
           ..\packages\d7\JvXPCtrlsD7R.res                 \
           ..\packages\d7clx\JvQ3rdD7R.res                 \
           ..\packages\d7clx\JvQAppFrmD7D.res              \
           ..\packages\d7clx\JvQAppFrmD7R.res              \
           ..\packages\d7clx\JvQCmpD7D.res                 \
           ..\packages\d7clx\JvQCmpD7R.res                 \
           ..\packages\d7clx\JvQCoreD7D.res                \
           ..\packages\d7clx\JvQCoreD7R.res                \
           ..\packages\d7clx\JvQCryptD7D.res               \
           ..\packages\d7clx\JvQCryptD7R.res               \
           ..\packages\d7clx\JvQCtrlsD7D.res               \
           ..\packages\d7clx\JvQCtrlsD7R.res               \
           ..\packages\d7clx\JvQCustomD7D.res              \
           ..\packages\d7clx\JvQCustomD7R.res              \
           ..\packages\d7clx\JvQDlgsD7D.res                \
           ..\packages\d7clx\JvQDlgsD7R.res                \
           ..\packages\d7clx\JvQDotNetCtrlsD7R.res         \
           ..\packages\d7clx\JvQHMID7D.res                 \
           ..\packages\d7clx\JvQHMID7R.res                 \
           ..\packages\d7clx\JvQJansD7D.res                \
           ..\packages\d7clx\JvQJansD7R.res                \
           ..\packages\d7clx\JvQManagedThreadsD7D.res      \
           ..\packages\d7clx\JvQManagedThreadsD7R.res      \
           ..\packages\d7clx\JvQMMD7D.res                  \
           ..\packages\d7clx\JvQMMD7R.res                  \
           ..\packages\d7clx\JvQNetD7D.res                 \
           ..\packages\d7clx\JvQNetD7R.res                 \
           ..\packages\d7clx\JvQPageCompsD7D.res           \
           ..\packages\d7clx\JvQPageCompsD7R.res           \
           ..\packages\d7clx\JvQRuntimeDesignD7D.res       \
           ..\packages\d7clx\JvQRuntimeDesignD7R.res       \
           ..\packages\d7clx\JvQStdCtrlsD7D.res            \
           ..\packages\d7clx\JvQStdCtrlsD7R.res            \
           ..\packages\d7clx\JvQSystemD7D.res              \
           ..\packages\d7clx\JvQSystemD7R.res              \
           ..\packages\d7clx\JvQUIBD7D.res                 \
           ..\packages\d7clx\JvQUIBD7R.res                 \
           ..\packages\d7clx\JvQValidatorsD7D.res          \
           ..\packages\d7clx\JvQValidatorsD7R.res          \
           ..\packages\d7clx\JvQWizardD7D.res              \
           ..\packages\d7clx\JvQWizardD7R.res              \
           ..\packages\d7clx\JvQXPCtrlsD7D.res             \
           ..\packages\d7clx\JvQXPCtrlsD7R.res             \
           ..\packages\d7per\JvCoreD7R.res                 \
           ..\packages\d7per\JvDotNetCtrlsD7R.res          \
           ..\packages\d7per\JvGlobusD7D.res               \
           ..\packages\d7per\JvGlobusD7R.res               \
           ..\packages\d7per\JvInterpreterD7D.res          \
           ..\packages\d7per\JvInterpreterD7R.res          \
           ..\packages\d7per\JvRuntimeDesignD7R.res        \
           ..\packages\d7per\JvUIBD7R.res                  \
           ..\packages\d9\Jv3rdD9R.res                     \
           ..\packages\d9\JvAppFrmD9D.res                  \
           ..\packages\d9\JvAppFrmD9R.res                  \
           ..\packages\d9\JvBandsD9D.res                   \
           ..\packages\d9\JvBandsD9R.res                   \
           ..\packages\d9\JvBDED9D.res                     \
           ..\packages\d9\JvBDED9R.res                     \
           ..\packages\d9\JvCmpD9D.res                     \
           ..\packages\d9\JvCmpD9R.res                     \
           ..\packages\d9\JvCoreD9D.res                    \
           ..\packages\d9\JvCoreD9R.res                    \
           ..\packages\d9\JvCryptD9D.res                   \
           ..\packages\d9\JvCryptD9R.res                   \
           ..\packages\d9\JvCtrlsD9D.res                   \
           ..\packages\d9\JvCtrlsD9R.res                   \
           ..\packages\d9\JvCustomD9D.res                  \
           ..\packages\d9\JvCustomD9R.res                  \
           ..\packages\d9\JvDBD9D.res                      \
           ..\packages\d9\JvDBD9R.res                      \
           ..\packages\d9\JvDlgsD9D.res                    \
           ..\packages\d9\JvDlgsD9R.res                    \
           ..\packages\d9\JvDockingD9D.res                 \
           ..\packages\d9\JvDockingD9R.res                 \
           ..\packages\d9\JvDotNetCtrlsD9D.res             \
           ..\packages\d9\JvDotNetCtrlsD9R.res             \
           ..\packages\d9\JvEDID9D.res                     \
           ..\packages\d9\JvEDID9R.res                     \
           ..\packages\d9\JvGlobusD9D.res                  \
           ..\packages\d9\JvGlobusD9R.res                  \
           ..\packages\d9\JvHMID9D.res                     \
           ..\packages\d9\JvHMID9R.res                     \
           ..\packages\d9\JvInterpreterD9D.res             \
           ..\packages\d9\JvInterpreterD9R.res             \
           ..\packages\d9\JvJansD9D.res                    \
           ..\packages\d9\JvJansD9R.res                    \
           ..\packages\d9\JvManagedThreadsD9D.res          \
           ..\packages\d9\JvManagedThreadsD9R.res          \
           ..\packages\d9\JvMMD9D.res                      \
           ..\packages\d9\JvMMD9R.res                      \
           ..\packages\d9\JvNetD9D.res                     \
           ..\packages\d9\JvNetD9R.res                     \
           ..\packages\d9\JvPageCompsD9D.res               \
           ..\packages\d9\JvPageCompsD9R.res               \
           ..\packages\d9\JvPluginD9D.res                  \
           ..\packages\d9\JvPluginD9R.res                  \
           ..\packages\d9\JvPrintPreviewD9D.res            \
           ..\packages\d9\JvPrintPreviewD9R.res            \
           ..\packages\d9\JvRuntimeDesignD9D.res           \
           ..\packages\d9\JvRuntimeDesignD9R.res           \
           ..\packages\d9\JvStdCtrlsD9D.res                \
           ..\packages\d9\JvStdCtrlsD9R.res                \
           ..\packages\d9\JvSystemD9D.res                  \
           ..\packages\d9\JvSystemD9R.res                  \
           ..\packages\d9\JvTimeFrameworkD9D.res           \
           ..\packages\d9\JvTimeFrameworkD9R.res           \
           ..\packages\d9\JvUIBD9D.res                     \
           ..\packages\d9\JvUIBD9R.res                     \
           ..\packages\d9\JvValidatorsD9D.res              \
           ..\packages\d9\JvValidatorsD9R.res              \
           ..\packages\d9\JvWizardD9D.res                  \
           ..\packages\d9\JvWizardD9R.res                  \
           ..\packages\d9\JvXPCtrlsD9D.res                 \
           ..\packages\d9\JvXPCtrlsD9R.res                 \
           ..\packages\d9per\JvCoreD9R.res                 \
           ..\packages\d9per\JvDotNetCtrlsD9R.res          \
           ..\packages\d9per\JvGlobusD9D.res               \
           ..\packages\d9per\JvGlobusD9R.res               \
           ..\packages\d9per\JvInterpreterD9D.res          \
           ..\packages\d9per\JvInterpreterD9R.res          \
           ..\packages\d9per\JvRuntimeDesignD9R.res        \
           ..\packages\d9per\JvUIBD9R.res                  
                                                           
# ---------------------------------------------------------------------------
!if !$d(BRCC32)                                            
BRCC32 = brcc32                                            
!endif                                                     
# ---------------------------------------------------------------------------
!if $d(PATHRC)                                             
.PATH.res  = $(PATHRC)                                     
!endif                                                     
# ---------------------------------------------------------------------------
resources.res: $(RESFILES)

# ---------------------------------------------------------------------------
.rc.res:
    &"$(ROOTDIR)\BIN\$(BRCC32)" -fo$@ $<

# ---------------------------------------------------------------------------




