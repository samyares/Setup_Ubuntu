#!/bin/bash

#---------------------------------------------------------------------------------

ME=$(whoami)
# docker_install_flag = 1
# vscode_install_flag = 1
# telegram_install_flag = 1
# vlc_install_flag = 1
# rasanegar_flag = 1
# nekoray_flag = 1
# output_flag = 1

echo "Welcome to the Sina's OS Greeting Generator :))"

echo 'use Rasanegar as Repo? (1 for YES and ENTER for NO)'
read rasanegar_flag

echo 'need Docker? (1 for YES and ENTER for NO)'
read docker_install_flag

echo 'need VSCode? (1 for YES and ENTER for NO)'
read vscode_install_flag

echo 'need Telegram? (1 for YES and ENTER for NO)'
read telegram_install_flag

echo 'need VLC? (1 for YES and ENTER for NO)'
read vlc_install_flag

echo 'need Nekoray for V2ray? (1 for YES and ENTER for NO)'
read nekoray_flag

echo 'need Output? (1 for YES and ENTER for NO)'
read output_flag

#---------------------------------------------------------------------------------

# Switch current user to root
sudo su

#---------------------------------------------------------------------------------

# update and upgrade OS
if [ $rasanegar_flag -eq 1 ]
then
    #change miror to rasanegar, check if rasanegar is not active comment it.
    echo "changing repository to rasanegar"
    # Function to update a repository URL
    update_repository() {
        local old_url=$1
        local new_url=$2
        local sources_file="/etc/apt/sources.list"

        # Update repository URLs in sources.list file
        sed -i "s|${old_url}|${new_url}|g" ${sources_file}
    }

    # Ubuntu Main Repos
    old_main_repo="http://archive.ubuntu.com/ubuntu"
    new_main_repo="http://mirror.rasanegar.com/ubuntu/archive/"
    update_repository ${old_main_repo} ${new_main_repo}

    # Ubuntu Update Repos
    old_update_repo="http://archive.ubuntu.com/ubuntu"
    new_update_repo="http://mirror.rasanegar.com/ubuntu/archive/"
    update_repository ${old_update_repo} ${new_update_repo}

    # Ubuntu Security Repos
    old_security_repo="http://security.ubuntu.com/ubuntu"
    new_security_repo="http://mirror.rasanegar.com/ubuntu/archive/"
    update_repository ${old_security_repo} ${new_security_repo}

    # Ubuntu Proposed Repos
    old_proposed_repo="http://archive.ubuntu.com/ubuntu"
    new_proposed_repo="http://mirror.rasanegar.com/ubuntu/archive/"
    update_repository ${old_proposed_repo} ${new_proposed_repo}

    # Ubuntu Backports Repos
    old_backports_repo="http://archive.ubuntu.com/ubuntu"
    new_backports_repo="http://mirror.rasanegar.com/ubuntu/archive/"
    update_repository ${old_backports_repo} ${new_backports_repo}

    # Update the operating system
    echo "Primary Update (can take much time..)"
    apt update
    apt upgrade -y
then
    # Update the operating system
    echo "Primary Update (can take much time..)"
    apt update
    apt upgrade -y
fi

#---------------------------------------------------------------------------------

sudo add-apt-repository universe
sudo apt install -y gnome-tweaks
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

#---------------------------------------------------------------------------------

# install docker
if [ $docker_install_flag -eq	1 ]
then
   echo "Setup docker"
   sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
   sudo apt install -y docker-ce
   sudo usermod -aG docker ${USER}
   su - ${USER}
   sudo usermod -aG docker ${USER}
   # install docker compose (check last version)
   echo "Setup docker-compose"
   curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   chmod +x /usr/local/bin/docker-compose
#   docker-compose --version
fi

#---------------------------------------------------------------------------------

if [ $vscode_install_flag -eq	1 ]
then
   echo "Setup vscode"
   sudo snap install code --classic
fi

#---------------------------------------------------------------------------------

if [ $telegram_install_flag -eq	1 ]
then
   echo "Setup Telegram"
   sudo snap install telegram-desktop
fi

#---------------#---------------------------------------------------------------------------------

if [ $vlc_install_flag -eq 1 ]
then
   echo "Setup VLC"
   sudo snap install vlc
fi
------------------------------------------------------------------

if [ $vlc_install_flag -eq 1 ]
then
   echo "Setup VLC"
   sudo snap install vlc
fi

#---------------------------------------------------------------------------------

if [ $vlc_install_flag -eq 1 ]
then
   echo "Setup VLC"
   sudo snap install vlc
fi

#---------------------------------------------------------------------------------

if [ $output_flag -eq 1 ]
then
    echo "Setup Output"
    OUTPUT_URL = "https://www.outputmessenger.com/OutputMessenger_amd64.deb"  
    OUTPUT_FILE = "OutputMessenger_amd64.deb"
    curl -L "$OUTPUT_URL" -o "$OUTPUT_FILE"
    sudo apt install -y ./$OUTPUT_FILE
fi

#---------------------------------------------------------------------------------

if [ $nekoray_flag -eq 1 ]
then
    echo "Setup Nekoray"
    NEKORAY_URL="https://github.com/MatsuriDayo/nekoray/releases/download/2.28/nekoray-2.28-2023-05-03-debian-x64.deb"
    NEKORAY_FILE="nekoray-2.28-2023-05-03-debian-x64.deb"
    curl -L "$NEKORAY_URL" -o "$NEKORAY_FILE"
    sudo apt install -y ./$NEKORAY_FILE
fi

#---------------------------------------------------------------------------------

#config terminal:
echo "configing terminal"
apt install zsh git curl -y
zsh --version
chsh -s $(which zsh) $ME

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' /home/$ME/.zshrc

mkdir /home/$ME/.fonts
ln -s /usr/share/fonts /home/$ME/.fonts
wget -P /home/$ME/.fonts  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
wget -P /home/$ME/.fonts  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
wget -P /home/$ME/.fonts  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
wget -P /home/$ME/.fonts  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"

apt-get install -y fonts-powerline

apt-get install -y dconf-cli

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

sed -i 's/^plugins=(.*)$/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' /home/$ME/.zshrc


p10k configure

#---------------------------------------------------------------------------------


sudo snap install libreoffice


