#!/bin/sh
## Thu Mar 15 00:29:06 KST 2012


_this_prog="$(basename $0)";


case $_this_prog in
"w3m.gmail") ## gmail html version
	w3m 'https://mail.google.com/mail/?ui=html&zy=s';
	;;
*)
	echo ">>> undefined command";
	exit 1;
esac

	
