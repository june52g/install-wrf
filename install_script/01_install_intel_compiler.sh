# basic command
apt-get update
apt-get install -y vim-tiny wget sudo make m4 lzip unzip dos2unix sudo

# https://estuarine.jp/2021/03/install-oneapi/
# Ubuntu 20.04 LTS에 Intel oneAPI (Intel Fortran) 설치

# install intel compiler
sudo apt-get update
sudo apt-get install -y cmake pkg-config build-essential gpg libpng-dev
sudo apt-get install -y bison flex libibverbs-dev

cd /tmp
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB

echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
sudo apt-get update

sudo apt-get install -y intel-basekit
sudo apt-get install -y intel-hpckit
