##.bdx.0110.n.gfp_github_push.sh
##gfp: gpgized file processing
##_ver=20121219_232613
##_ver=20140819_225745

echo "#>> update gighub source tree (add-commit-push)";

rm -f .tstamp.*;
touch .tstamp.$(tstamp);

if [ -d '.git.foo' ]; then
	mv .git.foo .git;
else
	echo "ERROR: directory '.git.foo' is not found -- EXIT";
	exit 1;
fi

git add -A
git commit -a
git push --all -u

if [ -d '.git' ]; then
	mv .git .git.foo;
else
	echo "ERROR: directory '.git' is not found -- EXIT";
	exit 1;
fi
