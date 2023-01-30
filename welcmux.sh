#!/usr/bin/env bash
#
############################################################
#
#  B4r@'|'^o
#  tk0082@hotmail.com
#
############################################################
#
#  Para configurar a apresentação na inicialização do Termux,
#  configure o arquivo 
#     /data/data/com.termux/files/usr/bin/login
#
#  Comente a linha:
#     cat /data/data/com.termux/files/usr/etc/motd
#
#  Adicione embaixo o comando:
#     clear
#
############################################################
#  
#  Edite o arquvo: 
#     /data/data/com.termux/files/usr/etc/bash.bashrc
#
#  Comente a linha com PS1 e adicione estes comandos [do if até fi ]:
:,
if [ $(whoami) == 'root' ]; then
   clear
   bash /data/data/com.termux/files/usr/bin/welcmux
   cd $HOME
   PS1='[1;31m[\u:[1;30m\w[1;31m]\$[0;32m '
else
   clear
   bash /data/data/com.termux/files/usr/bin/welcmux
   cd $HOME
   PS1='[1;32m[[1;30m\W[1;32m]\$[0;36m '
fi
,
############################################################
#

c=clear

# Cores
k='\033\e[1;30m'
az='\033\e[1;34m'
vd='\033\e[1;32m'
vm='\033\e[1;31m'
cy='\033\e[1;36m'
z='\033\e[0m'

dp=0
dir="/bin"
distro=$(cat /etc/*release*|grep NAME|sed 's/.*="//'|sed -n 1p|sed 's/ .*//g')

[ -f /data/data/com.termux/files/usr/etc/motd ] && {
   dir=/data/data/com.termux/files/usr/bin
   distro=$(cat ~/../usr/etc/motd|grep Termux|sed 's/.* //g;s/!//g')
}

msg="
$cy   WelcMux$vd - Apresentação para início de Shell Termux

   Opções de uso:

      welcmux$k [$cy -c, -r, -h$k ]

      $cy -c$vd -- Configurar programa no Sistema
      $cy -h$vd -- Mostra esta memsagem - HELP
      $cy -r$vd -- Remover programa
"

config(){
   $c
   cp $0 $dir/welcmux
   echo -e "$vd Programa instalado, use$k [$cy wlcmux$k ]."
   sleep 1
   $c
   welcmux
}

remove(){
   $c
   rm -f $dir/welcmux
   echo -e "$vm WemcMux Removido!"
   sleep 1
   $c
}

# Dependências de programa
deps(){
$c

prog="
figlet
sed
grep
"
case $distro in
Debian | Ubuntu | Mint | Termux)
  for i in $prog; do
    pr=$(dpkg-query --list |grep -i $i )
    if [ ! "$pr" ];then
      echo "$VRMi Instalando, $i.."
      apt-get install -y $i > /dev/null 2>&1 
    fi
    if [ -f "$pr" ];then
      echo "$VRD Programa $i já instalado"
    fi
  done
   ;;
RedHat | CentOS | Fedora)
  for i in $prog; do
    pr=$(rpm -qa |grep -i $i )
    if [ ! "$pr" ];then
      echo "$VRMi Instalando, $i.."
      yum install -y $i > /dev/null 2>&1 
    fi
    if [ -f "$pr" ];then
      echo "$VRD Programa $i já instalado"
    fi
  done
  ;;
esac

dp=1

}

display(){
$c
FIG=$(figlet  "||| T4nkr0$ \\\\\\\\\\\\") # Mude para seu Nickname
UN=$(uname -nosrm)
echo -e "${az}$FIG"
echo -e "$distro - $UN\n $z"
}

case $1 in
   -c)
      config
      ;;
   -h)
      $c
      echo -e "$msg"
      echo -ne "Pressione Enter para sair: "; read
      $c
      ;;
   -r)
      remove ;;
   '')
      if [ $dp = 0 ]; then
         deps
         display
      else
         display
      fi
      ;;
   *)
      echo -e "$vm Opção Inválida!!\n"
      exit 0
      ;;
esac

#=[I.G.W.T.]==========
