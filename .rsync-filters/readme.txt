# Reminder: rsync is stricly hierarchical

# https://linux.die.net/man/1/rsync
# exclude, - specifies an exclude pattern.
# include, + specifies an include pattern.
# merge, . specifies a merge-file to read for more rules.
# dir-merge, : specifies a per-directory merge-file.
# hide, H specifies a pattern for hiding files from the transfer.
# show, S files that match the pattern are not hidden.
# protect, P specifies a pattern for protecting files from deletion.
# risk, R files that match the pattern are not protected.
# clear, ! clears the current include/exclude list (takes no arg)