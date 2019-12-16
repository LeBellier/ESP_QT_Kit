# ESP_QT_Kit

## Pré requis 
Building and flashing programs to ESP8266 requires following software.

sudo apt -y install libtool-bin build-essential cmake make unrar-free autoconf automake libtool gcc g++ gperf \
                      flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
                      sed unzip help2man wget bzip2 curl
                      
# Avoir QT
                      
                    
# Install Pip 
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
sudo python get-pip.py
pip install pyserial

## Installation
# Init.sh with modification 

bash ./init.sh
// There is a problem with th script install replace ssh:\\ by https:\\

# Or init_edited.sh
bash ./init_edited.sh

// esp-open-sdk/crosstool-NG/configure.ac ligne 193 :  |$EGREP '^GNU bash, version ([0-9\.]+)')

cd $ESPROOT/esp-open-sdk
make STANDALONE=y




