#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# zsh 

# Check if user is root
# if [ $(id -u) != "0" ]; then
#     echo "Error: You must be root to run this script!"
#     exit 1
# fi

echo "+-------------------------------------------+"
echo "|              Welcome to rdtool            |"
echo "+-------------------------------------------+"
echo "|              https://rdhub.cn             |"
echo "+-------------------------------------------+"

arg1=$1
arg2=$2

install_zsh(){
# install package
apt-get -y install  zsh && sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

}

init(){
    apt-get -y install git zsh
}

install_docker(){
    wget -qO- https://get.docker.com/ | sh && sudo pip install -U docker-compose
}


install_node(){
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
  nvm install node $1
}
stark(){
  echo "hi stark $1"
}

addUser(){
  if [ -z ${User} ]; then
      echo "==========================="
      User="stark"
      Echo_Yellow "Please enter username for this system" 
      read -p "Please enter: " User
      if [ "${User}" = "" ]; then
          echo "NO input, will be generated randomly."
      fi
  fi
  echo "your enter username:" ${User}
  useradd ${User}
  mkdir -p /home/${User}
  chown -R ${User}:${User} /home/${User}
  gpasswd -a ${User} sudo
  usermod -s /bin/bash ${User}
  passwd ${Passwd}
}

case "${arg1}" in
    init) init ;;
    zsh) install_zsh ;;
    docker) install_docker ;;
    addUser) addUser ${arg2} ;;
    *)
        echo "Usage: rdtool { zsh|init|docer| addUser}"
        ;;
esac
exit