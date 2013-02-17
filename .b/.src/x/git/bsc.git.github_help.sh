#!/bin/sh

## bsc.github.help_b_src.sh
##
## Tue Apr  3 04:07:18 KST 2012
## Sun May  6 21:16:08 KST 2012


_this_prog="$(basename $0)";

echo "
https://github.com/blusjune
        Name		: blusjune (Brian M. JUNG)
        ID		: blusjune
        PW		: 08[q11]
        Email		: blusjune+github00@gmail.com
        Website/Blog	: https://sites.google.com/site/brianmjung/
        Member Since	: Sep 29, 2011
        API Token	: 4a980e009f54986ff80affb9483677e9


https://github.com/brian-m-jung
        Name		: Brian M. JUNG
        ID		: brian-m-jung
        PW		: 08[q11]
        Email		: brian.m.jung+github01@gmail.com
        Website/Blog	: https://sites.google.com/site/brianmjung/
        Member Since	: May 6, 2012
        API Token	: 


--
## .b_src repository

https://github.com/blusjune/.b_src

Global setup:
  Set up git
  git config --global user.name \"Brian Myungjune JUNG (blusjune)\"
  git config --global user.email blusjune+github00@gmail.com
  git config --global github.user blusjune

SSH keygen and registration
  ssh-keygen -t rsa -C \"blusjune+github@gmail.com\"

Next steps:
  mkdir .b_src
  cd .b_src
  git init
  touch README
  git add README
  git commit -m 'first commit'
  git remote add origin git@github.com:blusjune/.b_src.git
  git push -u origin master

  git clone git@github.com:blusjune/.b_src.git # R+W access via SSH
  git clone https://blusjune@github.com/blusjune/.b_src.git # R+W access via HTTPS
  git clone git://github.com/blusjune/.b_src.git # R-only access

  git commit -a -m 'commit all the things'
  git push -u origin master

Existing Git Repo?
  cd existing_git_repo
  git remote add origin git@github.com:blusjune/.b_src.git
  git push -u origin master

Importing a Subversion Repo?
  Check out the guide for step by step instructions.

When you're done:
  Continue

--
## blusjune's github repository
blusjune/.bd		# https://github.com/blusjune/.bd.git
blusjune/.blib		# https://github.com/blusjune/.blib.git
blusjune/.b_src		# https://github.com/blusjune/.b_src.git
blusjune/.b_src_full	# https://github.com/blusjune/.b_src_full.git
blusjune/.b_rc		# https://github.com/blusjune/.b_rc.git
blusjune/test		# https://github.com/blusjune/test.git
blusjune/-_-		# https://github.com/blusjune/-_-.git
blusjune/_		# https://github.com/blusjune/_.git

--
" | more;
