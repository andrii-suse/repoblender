set -eo pipefail

thisdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

zypper -n addrepo /$thisdir/../../download.opensuse.org/repositories/__projectpath/__repo __repo
zypper -n --gpg-auto-import-keys --no-gpg-checks refresh

for f in $thisdir/../../download.opensuse.org/repositories/__projectpath/__repo/x86_64/*.rpm; do 
    f=$(basename $f)
    zypper -n install --from __repo ${f%%-[0-9]*} || exit 1
done
