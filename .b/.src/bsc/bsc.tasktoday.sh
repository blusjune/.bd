#!/bin/sh
# bsc.tasktoday.sh

_bsc_descr="tt (task today) management program (Thu Feb 26 10:37:37 KST 2009)"

_prog_undefined="tt.undefined"
_prog_ttmkdir1="tt.mkdir1" # make tt directory type 1 and link /x/tt to that
_prog_ttmd1="tt.md1" # same to _prog_ttmkdir1
_prog_ttmkdir2="tt.mkdir2" # make tt directory type 1 and link /x/tt to that and make tt directory type 2
_prog_ttmd2="tt.md2" # same to _prog_ttmkdir2
_tt_dir_root="${HOME}/x"
_tt_dir_t1="${_tt_dir_root}/tt" # link to ~/x/tsk/YYYY/mm/dd (task today directory type 1)
_tt_dir_t2="${_tt_dir_root}/ttl" # link to ~/x/tsk/YYYY/mm/dd/directory_with_tasktitle created lastly (task today directory type 2)

_thisprog="`basename $0`"
case $_thisprog in
"tt.mkdir1"|"tt.md1"|"ttmd1"|"ttmd")
        ## make task today directory type 1
        _thisprog=$_prog_ttmkdir1
        ;;
"tt.mkdir2"|"tt.md2"|"ttmd2"|"ttl")
        ## make task today directory type 2 with tasktitle and update a link for latest tt directory
        _thisprog=$_prog_ttmkdir2
        ;;
*)
        echo ">>> program undefined"
        _thisprog=$_prog_undefined
        ;;
esac

if [ "X$_thisprog" = "X$_prog_undefined" ]; then
        exit 1 # exit now if _thisprog is undefined
fi

_dir_title_default="untitled"
if [ "X$1" = "X" ]; then
#       read _dir_title
        :
else
        _dir_title="$1"
fi

if [ "X$_dir_title" = "X" ]; then
        _dir_title="$_dir_title_default"
fi

_year="`date +%Y`"
_month="`date +%m`"
_date="`date +%d`"

# '${HOME}/x' may be real directory as it is or symlink to '/home/bx_home/x'
_dir_step_1="${_tt_dir_root}/tsk"
_dir_step_2="$_year/$_month/$_date"
_dir_step_3="$_dir_step_1/$_dir_step_2" # directory today
if [ ! -d "$_dir_step_3" ]; then
        mkdir -p "$_dir_step_3"
        chmod 775 $_dir_step_3
        cd $_dir_step_3
        echo "$_dir_step_3" > ._DESCR.$_year.$_month.$_date
fi
if [ -h $_tt_dir_t1 ]; then
        rm $_tt_dir_t1
fi
ln -s $_dir_step_3 $_tt_dir_t1


if [ "X$_thisprog" = "X$_prog_ttmkdir1" ]; then
        echo $_thisprog creates $_dir_step_3
        exit 0
elif [ "X$_thisprog" = "X$_prog_ttmkdir2" ]; then
        _num_of_c_items="`cd $_dir_step_3 && ls -1 | wc -l`"
        _num_of_n_items="`expr $_num_of_c_items + 1`"
        _dir_step_4="`printf \"t%02d\" $_num_of_n_items`"
        _dir_step_5="${_dir_step_3}/${_dir_step_4}.$_dir_title" # directory today/task
        mkdir -p "$_dir_step_5"
        chmod 775 $_dir_step_5
        cd $_dir_step_5
        echo "$_dir_step_5" > ._DESCR.$_year.$_month.$_date.$_dir_step_4.$_dir_title
        chmod 775 "$_dir_step_5"
        if [ -h $_tt_dir_t2 ]; then
                rm $_tt_dir_t2
        fi
        ln -s $_dir_step_5 $_tt_dir_t2
        echo $_thisprog creates $_dir_step_5
fi


