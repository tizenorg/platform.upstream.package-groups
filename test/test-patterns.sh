#!/bin/sh


TMPDIR=`mktemp -d`
mkdir -p $TMPDIR
CMD="zypper -v --no-gpg-checks --non-interactive --gpg-auto-import-keys -R $TMPDIR  "

function setup_repos() {
    test -d "download.meego.com"  || (
        wget -m  --no-parent    http://download.meego.com/snapshots/latest/repos/non-oss/ia32/packages/repodata/
        wget -m  --no-parent    http://download.meego.com/snapshots/latest/repos/oss/ia32/packages/repodata/
    )
    $CMD ar file://$PWD/download.meego.com/snapshots/latest/repos/oss/ia32/packages/ oss
    $CMD ar file://$PWD/download.meego.com/snapshots/latest/repos/non-oss/ia32/packages/ non-oss
}
function show()
{
    setup_repos
    $CMD pt
}
function patterns()
{
    setup_repos
    PATTERNS=$(echo $1 | sed 's/,/ /g')
    $CMD in --dry-run --type pattern $PATTERNS

}
while getopts ":sp:n:c" opt; do
  case $opt in
    n)
      echo "Using new pattern file $OPTARG"
      NEW_PATTERN_FILE=$OPTARG
      ;;
    p)
      echo "$OPTARG" >&2
      PATTERNS=$OPTARG
      ;;
    s)
      SHOW_PATTERNS=1
      ;;
    c)
      CLEAN=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ -z "$1" ]; then
  echo "You need to provide a pattern name as an argument"
  exit 1
fi


if [ -n "$CLEAN" ]; then
   rm -rf download.meego.com
fi 

if [ -n "$NEW_PATTERN_FILE" ]; then
    test -f $NEW_PATTERN_FILE && modifyrepo $NEW_PATTERN_FILE download.meego.com/snapshots/latest/repos/oss/ia32/packages/repodata/
fi
if [ -n "$SHOW_PATTERNS" ]; then
    show
fi
if [ -n "$PATTERNS" ]; then
    patterns $PATTERNS
fi

rm -rf $TMPDIR
