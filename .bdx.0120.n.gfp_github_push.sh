##.bdx.0110.n.gfp_github_push.sh
##gfp: gpgized file processing
##_ver=20121219_232613
##_ver=20140819_225745

echo "#>> update gighub source tree (add-commit-push)";

rm -f .tstamp.*;
touch .tstamp.$(tstamp);

_gitdir_foo=".git.foo";
_gitdir=".git";

if [ -d $_gitdir_foo ]; then
	mv $_gitdir_foo $_gitdir;
else
	echo "ERROR: directory '$_gitdir_foo' is not found -- EXIT";
	exit 1;
fi

git add -A
git commit -a
git push --all -u

if [ -d $_gitdir ]; then
	mv $_gitdir $_gitdir_foo;
else
	echo "ERROR: directory '$_gitdir' is not found -- EXIT";
	exit 1;
fi
