# Save and restore setup

save_restoreSet_status_prefix("${P}${R}")
save_restoreSet_Debug(0)

save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(300)

set_savefile_path("/var/opt/rffe-epics-ioc", "autosave")

set_pass0_restoreFile("$(P)$(R)_settings.sav")
set_pass1_restoreFile("$(P)$(R)_settings.sav")

set_requestfile_path("$(TOP)", "BPMRFFEApp/Db")
