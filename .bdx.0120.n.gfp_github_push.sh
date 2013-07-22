##.bdx.0110.n.gfp_github_push.sh
##gfp: gpgized file processing
##_ver=20121219_232613

echo "#>> update gighub source tree (add-commit-push)";

rm -f .tstamp.*;
touch .tstamp.$(tstamp);

git add -A
git commit -a
git push --all -u

