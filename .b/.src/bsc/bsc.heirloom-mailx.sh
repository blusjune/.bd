#!/bin/sh

## mailx (heirloom-mailx)
## -N	: Inhibits the initial display of message headers when reading mail or editing a mail folder.
## -S	: Sets the internal option variable and, in case of a string option, assigns value to it.
## -f	: Read in the contents of the user's mbox for processing.
mailx -N -S cmd=/bin/sh -f ~/.getmail/mbox/gmail.mbox
