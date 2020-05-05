set -eo pipefail

git clone https://github.com/coryb/osht osht || :
git clone https://github.com/andrii-suse/environs environs || :

(
cd environs
sudo bash -x .product/mb/system/.install.sh
bash -x .product/mb/.example/system.sh __prj
)
