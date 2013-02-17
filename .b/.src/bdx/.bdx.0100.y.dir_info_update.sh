#!/bin/sh
## .bdx.0100.y.dir_info_update.sh
##
##tstamp: 20120930_223943

tstamp > README;
uname -srmn >> README;
echo '--
' >> README;
(echo '$ pwd'; pwd; echo ''; echo '$ ls -alF'; ls -alF; echo ''; ) >> README;
