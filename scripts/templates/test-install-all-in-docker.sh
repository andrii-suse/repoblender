set -eo pipefail

thisdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ident=repoblender.__prj.__repo
ident=${ident,,}
ident=${ident//:/.}
containername=${ident}

docker ps >/dev/null || exit 1 # Docker doesn't seem to be running

echo __container
(
cat << 'EOF'
FROM opensuse/__container
ENV container docker
ENV LANG en_US.UTF-8

ADD __repo/ /__repo
RUN zypper -n addrepo /__repo __repo
RUN zypper -n --gpg-auto-import-keys --no-gpg-checks refresh

RUN for f in /__repo/x86_64/*.rpm; do f=$(basename $f); zypper -n install --from __repo ${f%%-[0-9]*} || exit 1; done
EOF

) | docker build -t $ident.image -f - "$thisdir/../../download.opensuse.org/repositories/__projectpath/"
