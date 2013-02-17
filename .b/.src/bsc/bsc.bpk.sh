#!/bin/sh
# --verbose
# bsc.bpk.sh - bPackage Tool
# 2012-02-14
#
# bpk.pack (bpk.p): make secure bPackage file at localhost

## Thu Apr  5 01:53:47 KST 2012
##_ver=20130218_004021




_thisprog="`basename $0`"
_prog_bpk_pack="bpk_pack"
_prog_bpk_unpk="bpk_unpk"
_prog_bpk_git_update="bpk_git_update";
_prog_undefined="bpk_undefined"

_b_root="${HOME}/.b"
_bpk_pkg_tgt_default=".src .bdx.d x"	# class 1 directories
_bpk_pkg_tgt=${_bpk_pkg_tgt_default};
if [ "X${_bpk_pkg_tgt}" = "X" ]; then
	_bpk_pkg_tgt=${_bpk_pkg_tgt_default};
fi

_bpk_timestamp="$(date '+%Y%m%d_%H%M%S')"
_bpk_meta_d="..bpk"
_bpk_files_d=".files"
_bpk_f_base="${_b_root}/${_bpk_meta_d}"
_bpk_f_leaf="bpk-$_bpk_timestamp"
_bpk_fakeroot="${_bpk_f_base}/${_bpk_f_leaf}"
_bpk_f="${_bpk_f_leaf}.tgz"
_bpk_f_asc="${_bpk_f}.asc"
_bpk_f_asc_sh="${_bpk_f_asc}.sh"
_bpk_f_asc_sh_gz="${_bpk_f_asc_sh}.gz"
_bpk_f_asc_latest="bpk-latest.asc"
_bpk_f_sh_latest="bpk-latest.sh"
_bpk_f_tgzascshgz_latest="bpk-latest.tgz.asc.sh.gz"
_bpk_f_to_unpack_default="${_bpk_f_asc_latest}"
_gpg="gpg";
_bd="${HOME}/.bd";
_bd_bpk_d="${_bd}/.bpk";
_bpk_bashrc_setup_script="..__${_bpk_timestamp}__";
export _bpk_timestamp;


if [ "X${1}" = "X" ]; then
	_bpk_f_to_unpack="${_bpk_f_to_unpack_default}";
else
	_bpk_f_to_unpack="${1}";
fi


bpk_pack()
{
	echo "";
	echo "> bpk: packing started";
	echo "> --------------------";

	cd ${_b_root};
	(cd .bdx.d; _BDX); # execute sync s2d operation
	mkdir -p ${_bpk_fakeroot}/${_bpk_meta_d}/${_bpk_files_d}; # creates the timestamp'ed directory and an empty directory for files archive
	for _tgt in ${_bpk_pkg_tgt}
	do
		if [ -d ${_tgt} ]; then
			echo ">> now packing... ${_tgt}";
			tar cf - ${_tgt} | (cd ${_bpk_fakeroot}; tar xf -);
		fi
	done

	cd ${_bpk_fakeroot};
	
	cat << EOF_INSTALL_BPK_0 > ${_bpk_bashrc_setup_script}
#!/bin/sh
# ${_bpk_timestamp}

echo "##### dot b system installation: begin #####";

(
cd ~
if [ "X\$(grep BSC_CF_SH_ENV_SET ~/.bashrc > /dev/null; echo \$?)" != "X0" ]; then
cat << EOF_INSTALL_BPK_1 >> ~/.bashrc

### BEEE:: BSC_CF_SH_ENV_SET
### sourcing bsc.cf.sh_env.set file
if [ -r ~/.b/.src/bsc/bsc.cf.sh_env.set ]; then
	. ~/.b/.src/bsc/bsc.cf.sh_env.set
fi

EOF_INSTALL_BPK_1
	echo ">>> .bashrc was patched successfully";
else
	echo ">>> no need to patch .bashrc";
fi
)

(
cd ~;
if [ ! -d bx_data ]; then
	~/.b/.src/bsc/bsc.bx_data.create.sh .;
else
	echo ">>> no need to create bx_data";
fi
)

echo "##### dot b system installation: end #####";

EOF_INSTALL_BPK_0
	chmod 755 ${_bpk_bashrc_setup_script};

	cd ${_bpk_f_base};
	tar cf - ${_bpk_f_leaf} | gzip -c > ${_bpk_f};
	read -p ">> bpp(bpk): " _bpp_bpk;
	echo "${_bpp_bpk}" | $_gpg -ca --cipher-algo twofish --openpgp --comment "bpk ( $_bpk_timestamp // $(uname -srmn) )" --passphrase-fd 0 -o ${_bpk_f_asc} ${_bpk_f}
	rm -fr ${_bpk_f_leaf};
	rm -fr ${_bpk_f};

	if [ -h ${_bpk_f_asc_latest} ]; then
		rm ${_bpk_f_asc_latest};
	fi
	ln -s ${_bpk_f_asc} ${_bpk_f_asc_latest};

	bsc.mksibpk $_bpk_f_asc;
	if [ -f ${_bpk_f_asc_sh} ]; then
		gzip ${_bpk_f_asc_sh};
	fi
	if [ -h ${_bpk_f_tgzascshgz_latest} ]; then
		rm ${_bpk_f_tgzascshgz_latest};
	fi
	ln -s ${_bpk_f_asc_sh_gz} ${_bpk_f_tgzascshgz_latest};
#	echo ">> gzip'ed self-installable bpk file is created";

	if [ -d ${_bd_bpk_d} ]; then
		cp ${_bpk_f_asc_sh_gz} ${_bd_bpk_d};
	fi

	echo "> ----------------------";
	echo "> bpk: packing completed";
	echo "";
}




bpk_git_update()
{
_bpksh="bpk-latest.sh";
_bpksrc="${HOME}/.b/..bpk/$_bpksh";
_bpk_git_d=".bpk";
_bpk_gitrepo=".bpk.git";

_git_access_method="rw_ssh";
#_git_access_method="rw_https";

if [ "X$(basename $(pwd))" = "X$_bpk_git_d" ]; then
	if [ -d .git ]; then
		_cur_giturl="$(find .git -name 'config' -exec grep '\.bpk\.git' {} \; | awk '{ print $3 }')";
		_cur_gitrepo="$(basename $_cur_giturl)";
		if [ "X$_cur_gitrepo" = "X$_bpk_gitrepo" ]; then
			echo ">>> current directory is right bpk git root directory";
			# current directory is right bpk git root directory

			if [ -f ./$_bpksh ]; then
				rm ./$_bpksh;
			fi
			if [ -f $_bpksrc ]; then
				cp $_bpksrc .;
			else
				echo ">>> Could not find the latest bpk file \'$_bpksrc\'";
				echo ">>> Please check that file exists and then retry";
				exit 1;
			fi

			echo ">>> git add $_bpksh";
			git add $_bpksh;
			echo ">>> git commit -a -m \"bpk git update at $_bpk_timestamp\"";
			git commit -a -m "bpk git update at $_bpk_timestamp";
			echo ">>> git push -u";
			git push -u;
			exit 0; # completed successfully
		fi
		# current directory is not bpk git root, although .git dir exists
	fi
fi

if [ ! -d $_bpk_git_d ]; then
	case $_git_access_method in
	"rw_ssh")
		echo ">>> cloning bpk git (R+W access via SSH)";
		git clone git@github.com:blusjune/.bpk.git; # R+W access via SSH
		;;
	"rw_https") # deprecated (does not work well as of 2012-04-19)
		echo ">>> cloning bpk git (R+W access via HTTPS)";
		git clone https://blusjune@github.com/blusjune/.bpk.git; # R+W access via HTTPS 
		;;
	*)
		echo ">>> please set _git_access_method properly";
		exit 1;
		;;
	esac
fi

(
cd $_bpk_git_d;

if [ -f ./$_bpksh ]; then
	rm ./$_bpksh;
fi
if [ -f $_bpksrc ]; then
	cp $_bpksrc .;
else
	echo ">>> Could not find the latest bpk file \'$_bpksrc\'";
	echo ">>> Please check that file exists and then retry";
	exit 1;
fi

echo ">>> git add $_bpksh";
git add $_bpksh;
echo ">>> git commit -a -m \"bpk git update at $_bpk_timestamp\"";
git commit -a -m "bpk git update at $_bpk_timestamp";
echo ">>> git push -u";
git push -u;
)

#	echo ">>> git init";
#	git init;
#	echo ">>> git add $_bpksh";
#	git add $_bpksh;
#	echo ">>> git commit -a -m \"bpk git update at $_bpk_timestamp\"";
#	git commit -a -m "bpk git update at $_bpk_timestamp";
#	echo ">>> git remote add origin git@github.com:blusjune/.bpk.git";
#	git remote add origin git@github.com:blusjune/.bpk.git;
#	echo ">>> git push -u origin master";
#	git push -u origin master;

}




case $_thisprog in
"bpk.pack"|"bpk.p"|"bpk") ## bpk.pack: packing (to create bPackage file at the predefined directory)
        _thisprog=$_prog_bpk_pack;
	bpk_pack;
        ;;
"bpk.git_update"|"bpk.gitupd") ## bpk.git_update: upload latest bpk via to github 
        _thisprog=$_prog_bpk_git_update;
	bpk_git_update;
        ;;
"bpk.unpk"|"bpk.u") ## bpk.unpk: unpacking (to extract bPackage file at the current directory)
        _thisprog=$_prog_bpk_unpk;
	bpk_unpk;
        ;;
*)
        echo "> bpk: undefined command"
        _thisprog=$_prog_undefined
        ;;
esac




