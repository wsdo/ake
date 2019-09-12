#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# zsh 

# Check if user is root
# if [ $(id -u) != "0" ]; then
#     echo "Error: You must be root to run this script!"
#     exit 1
# fi


arg1=$1
arg2=$2

install_zsh(){
# install package
apt-get -y install  zsh && sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

}

init(){
    # apt-get -y install git zsh
    echo '暂不支持该功能'
}

tag(){
#get highest tag number
# git fetch --tags
VERSION=`git tag --sort=taggerdate | tail -1`
if [ !$VERSION ]
then 
VERSION='v0.0.0'
fi
# VERSION=`git describe --abbrev=0 --tags`

arg1=$1

#replace . with space so can split into an array
VERSION_BITS=(${VERSION//./ })

#get number parts and increase last one by 1
VNUM1=${VERSION_BITS[0]}
VNUM2=${VERSION_BITS[1]}
VNUM3=${VERSION_BITS[2]}
VNUM3=$((VNUM3+1))

#create new tag
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"

echo "Updating $VERSION to \033[1;32m$NEW_TAG \033[0m"

while :;do
message=""
read -p "Enter tag message: " message
if [ "${message}" = "" ]; then
    echo "Error: message can't be NULL!!"
else
    break
fi
done

#get current hash and see if it already has a tag
GIT_COMMIT=`git rev-parse HEAD`
NEEDS_TAG=`git describe --contains $GIT_COMMIT`

#only tag if no tag already (would be better if the git describe command above could have a silent option)
if [ -z "$NEEDS_TAG" ]; then
    echo "Tagged with $NEW_TAG (Ignoring fatal:cannot describe - this means commit is untagged) "
    git tag -a $NEW_TAG -m"${message}"
    git push --tags
else
    echo "Already a tag on this commit"
fi
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
  echo "hi ${arg1}"
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
    tag) tag ${arg2};;
    zsh) install_zsh ;;
    stark) stark ${arg1} ;;
    docker) install_docker ;;
    addUser) addUser ${arg2} ;;
    *)
        echo "+-------------------------------------------+"
        echo "|              Welcome to ake sh            |"
        echo "+-------------------------------------------+"
        echo "|              https://shudong.wang         |"
        echo "+-------------------------------------------+"
        echo "Usage: ake { tag | zsh|init|docer| addUser}"
        ;;
esac
exit
