set -eo pipefail

git clone https://github.com/coryb/osht osht || :
git clone https://github.com/andrii-suse/environs environs || :

(
cd environs
OSHT_LOCATION=$(pwd)/../osht PRIVILEGED_TESTS=1 BASEIMAGE=__container .product/mb/.example/system.sh 
)
