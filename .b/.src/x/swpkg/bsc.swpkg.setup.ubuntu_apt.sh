#!/bin/sh

##tstamp: 20120127_004244
##tstamp: 20121109_005459
##tstamp: 20121207_000343
##_ver=20130127_224936
##_ver=20130227_011315
##_ver=20130307_153731




_this_prog="$(basename $0)";
_timestamp="$(date +%Y%m%d_%H%M%S)";
_config_out=".bdx.0001.y.swpkg_install_${_timestamp}.sh";
_exec_log="swpkg_install_${_timestamp}.log";




#if [ ! -f /sbin/.x ]; then
#	echo ">>> Install .x"; sleep 1;
#	cp -p $(which sudo) /sbin/.x
#fi





##
## actual execution of tasks
##

cat > $_config_out << EOF
## $_config_out
## // START of list {


## meta works
alias _inst='aptitude -y install'


_task_01__prerequisites()
{
## aptitude installation
apt-get update
apt-get install libnss3-1d libxss1 libcurl3
apt-get install aptitude
aptitude update
}


_task_02__syslib_n_service()
{
## basic system libraries and services

_inst \\
apparmor-utils \\
gadmin-samba \\
libncurses5 \\
libncurses5-dev \\
mysql-client \\
mysql-navigator \\
mysql-server \\
mysql-testsuite \\
mysql-workbench \\
mysqltcl \\
nfs-common \\
nfs-kernel-server \\
nfswatch \\
openssh-client \\
openssh-server \\
samba \\
samba-tools \\
ssh \\
system-config-samba \\
zssh \\

}


_task_03__devel_n_sysutil()
{
## development environment

_inst \\
alleyoop \\
ant \\
autoconf \\
automake \\
bcc \\
bin86 \\
binutils \\
bison \\
bittorrent \\
bittorrent-gui \\
blktrace \\
bootchart \\
bouml \\
bridge-utils \\
build-essential \\
burn \\
bzip2 \\
cflow \\
chkconfig \\
clisp \\
clisp-dev \\
clisp-doc \\
codeblocks \\
codelite \\
coreutils \\
cscope \\
dbench \\
devmem2 \\
dissy \\
dsniff \\
dvdbackup \\
dvdrip \\
dvdrip-utils \\
dvdrtools \\
e2dbg \\
e2fslibs-dev \\
eclipse \\
eclipse-cdt \\
eclipse-egit \\
eclipse-emf \\
eclipse-emf-examples \\
eclipse-emf-sdk \\
eclipse-rse \\
eclipse-xsd \\
eclipse-xsd-sdk \\
elfsh \\
emacs \\
etrace \\
exuberant-ctags \\
flex \\
gawk \\
gcc \\
gcc-multilib \\
gdebi \\
git-all \\
git-cola \\
git-completion \\
git-core \\
git-sh \\
gitmagic \\
gitstats \\
gnuplot \\
gnuplot-doc \\
gnuplot-x11 \\
graphviz \\
gtkwave \\
happycoders-libdbg \\
iasl \\
inotify-tools \\
iotop \\
iproute \\
iscsitarget \\
iscsitarget-dkms \\
iscsitarget-source \\
java7-jdk \\
kernel-package \\
kernelshark \\
kerneltop \\
libatlas-dev \\
libbz2-dev \\
libcurl3 \\
libcurl4-openssl-dev \\
libinotifytools0-dev \\
libjpeg62-dev \\
libncurses5-dev \\
libpci-dev \\
libsdl1.2-dev \\
libvncserver-dev \\
libx11-dev \\
linux-kernel-headers \\
linux-source \\
linux-tools-common \\
linuxinfo \\
lmbench \\
lmbench-doc \\
lsdvd \\
lsscsi \\
ltrace \\
make \\
maven2 \\
mc \\
mdadm \\
mediawiki \\
mediawiki-extensions \\
mediawiki-math \\
memdump \\
memstat \\
mercurial \\
mkrboot \\
module-init-tools \\
mp3burn \\
mtd-utils \\
nasm \\
nautilus-cd-burner \\
ncc \\
nccnav \\
netsniff-ng \\
network-config \\
nmap \\
ocaml \\
ocaml-findlib \\
octave \\
open-iscsi \\
open-iscsi-utils \\
openjdk-6-dbg \\
openjdk-6-demo \\
openjdk-6-doc \\
openjdk-6-jdk \\
openjdk-6-jre \\
openjdk-6-source \\
openjdk-7-dbg \\
openjdk-7-demo \\
openjdk-7-doc \\
openjdk-7-jdk \\
openjdk-7-jre \\
openjdk-7-source \\
oprofile \\
oprofile-gui \\
packagesearch \\
patch \\
pstack \\
pybootchartgui \\
rand \\
rcs \\
rtorrent \\
scamper \\
scanmem \\
science-machine-learning \\
skyeye \\
smartmontools \\
smem \\
sniffit \\
springgraph \\
sysbench \\
sysprof \\
sysstat \\
system-config-cluster \\
system-config-date \\
system-config-lvm \\
system-config-printer-udev \\
system-config-samba \\
tcptrace \\
texinfo \\
texlive-fonts-extra \\
texlive-fonts-recommended \\
texlive-latex-base \\
texlive-latex-recommended \\
tgif \\
tiobench \\
transfig \\
uboot-envtools \\
uboot-mkimage \\
umlet \\
uuid-dev \\
valgrind \\
vim \\
vim-doc \\
vite \\
weka \\
weka-doc \\
xz-utils \\
zlib1g-dev \\
icheck \\

}


_task_04__comm()
{
## communication
##
## DO INSTALL "heirloom-mailx" which supports '-a' option for an attachment
## BUT, NEVER INSTALL "mailutils" and "mailutils-mh"

_inst \\
fetchmail \\
fetchmail-ssl \\
fetchmailconf \\
getmail4 \\
heirloom-mailx \\
lynx \\
mh \\
mh-book \\
mh-e \\
nmh \\
procmail \\
ssmtp \\
w3m \\

}


_task_11__desktop()
{
## desktop

_inst \\
gnome \\
gnome-commander \\
gnome-do \\
gnome-genius \\
gnome-gmail \\
kde-full \\
language-pack-ko \\
language-pack-ko-base \\
language-selector \\
language-selector-common \\
language-selector-gnome \\
language-selector-kde \\
language-selector-qt \\
ubuntustudio-desktop \\

#ubuntu-desktop \\

}


_task_12__office()
{
## office/productivity

_inst \\
dict \\
dict-freedict-deu-eng \\
dict-freedict-eng-deu \\
dict-freedict-eng-fra \\
dict-freedict-eng-ita \\
dict-freedict-eng-lat \\
dict-freedict-eng-rus \\
dict-freedict-eng-spa \\
dict-freedict-fra-eng \\
dict-freedict-ita-eng \\
dict-freedict-lat-eng \\
dict-freedict-spa-eng \\
dictd \\
freemind \\
gimp \\
gnote \\
inkscape \\
note \\
pdfshuffler \\
pencil \\
rednotebook \\

}


_task_13__entertainment()
{
## entertainment

_inst \\
gtkguitune \\
guitarix \\
ipod \\
tuxguitar \\
tuxguitar-alsa \\
tuxguitar-fluidsynth \\
tuxguitar-jack \\
tuxguitar-jsa \\
tuxguitar-oss \\

}


_task_31__large_scale_system()
{
## large scale system

_inst \\
glusterfs-client \\
glusterfs-common \\
glusterfs-dbg \\
glusterfs-examples \\
glusterfs-server \\
liblustre \\
linux-patch-lustre \\
lustre-dev \\
lustre-source \\
lustre-tests \\
lustre-utils \\
ubuntu-orchestra-modules-gluste \\

}


_task_32__virtualization()
{
## virtualization

_inst \\
imvirt \\
libxen-dev \\
ubuntu-virt \\
ubuntu-virt-mgmt \\
ubuntu-virt-server \\
virt-goodies \\
virt-manager \\
virt-top \\
virt-viewer \\
virt-what \\
virtinst \\
virtualbox \\
virtualbox-dbg \\
virtualbox-dkms \\
virtualbox-fuse \\
virtualbox-guest-additions \\
virtualbox-guest-additions-iso \\
virtualbox-guest-dkms \\
virtualbox-guest-utils \\
virtualbox-guest-x11 \\
virtualbox-ose \\
virtualbox-ose-dbg \\
virtualbox-ose-dkms \\
virtualbox-ose-fuse \\
virtualbox-ose-guest-dkms \\
virtualbox-ose-guest-utils \\
virtualbox-ose-guest-x11 \\
virtualbox-ose-qt \\
virtualbox-qt \\
xen-docs-4.1 \\
xen-hypervisor \\
xen-hypervisor-4.1 \\
xen-hypervisor-4.1-amd64 \\
xen-hypervisor-amd64 \\
xen-hypervisor-i386 \\
xen-tools \\
xen-utils \\
xen-utils-4.1 \\
xen-utils-common \\

}


_task_51__python()
{
## python and related

_inst \\
idle-python2.7 \\
ipython \\
ipython-notebook \\
ipython3 \\
python \\
python-all \\
python-dev \\
python-git \\
python-gnuplot \\
python-inotifyx \\
python-libsvm \\
python-matplotlib \\
python-numpy \\
python-scipy \\
python-setuptools \\
python-sklearn \\
python-twisted \\
python2.7-dev \\
python3-all \\
python3-all-dev \\
vim-python \\

}


_task_52__r_stat_comp()
{
## R statistical computing software

_inst \\
r-base \\
r-base-dev \\
r-bioc-biobase \\
r-cran-bayesm \\
r-cran-bitops \\
r-cran-boot \\
r-cran-class \\
r-cran-cluster \\
r-cran-codetools \\
r-cran-combinat \\
r-cran-dbi \\
r-cran-foreach \\
r-cran-foreign \\
r-cran-gdata \\
r-cran-getopt \\
r-cran-gmodels \\
r-cran-gplots \\
r-cran-gtools \\
r-cran-inline \\
r-cran-int64 \\
r-cran-iterators \\
r-cran-kernsmooth \\
r-cran-lattice \\
r-cran-lpsolve \\
r-cran-mass \\
r-cran-matrix \\
r-cran-mcmcpack \\
r-cran-mgcv \\
r-cran-misc3d \\
r-cran-multicore \\
r-cran-nlme \\
r-cran-nnet \\
r-cran-plotrix \\
r-cran-pvclust \\
r-cran-rgl \\
r-cran-rmpi \\
r-cran-rodbc \\
r-cran-rpart \\
r-cran-spatial \\
r-cran-survival \\
r-cran-tseries \\
r-cran-vcd \\
r-cran-xml \\
r-doc-html \\
r-doc-info \\
r-doc-pdf \\
r-mathlib \\

}


_task_99__readme()
{
## display README information

echo "
---------------------------------------------
README
--
Please do not forget the followings,
even though apt-get does not support (yet)
---------------------------------------------
# RStudio IDE: Powerful IDE for R
# (free and open source)
	http://www.rstudio.com/ide/download/
---------------------------------------------

";

}


## // END of list }


##
## actual execution of tasks
##
date > ${_exec_log};

#_task_01__prerequisites;
#_task_02__syslib_n_service;
#_task_03__devel_n_sysutil;
#_task_04__comm;

#_task_11__desktop;
#_task_12__office;
#_task_13__entertainment;

#_task_31__large_scale_system;
#_task_32__virtualization;

#_task_51__python;
#_task_52__r_stat_comp;

_task_99__readme;

date >> ${_exec_log};
EOF

echo ">>> Good! a configuration output file is created.";
echo ">>> whose file name is: $_config_out";




exit 0;








##
## main setup
##


_task_30__misc_setup()
{

## web browser
read -p ">>> Do you want to install google chrome web browser?" _answer
if [ "X${_answer}" = "Xy" ]; then
	echo "dpkg -i google-chrome-stable_current_amd64.deb"
	bash;
fi
_answer=""


## vigr and visudo
read -p ">>> Please modify sudo policy using visudo" _answer
if [ "X${_answer}" = "Xy" ]; then
	echo "vigr; vigr -s"
	echo "visudo; %wheel ALL = NOPASSWD: ALL"
	bash;
fi
_answer=""


## .exrc
read -p ">>> Please create and configure .exrc" _answer
if [ "X${_answer}" = "Xy" ]; then
	echo "touch > ~/.exrc"
	echo "set nocompatible"
	echo "set nu ai cin"
	bash;
fi
_answer=""

}




