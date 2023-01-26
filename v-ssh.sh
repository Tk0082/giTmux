#!/usr/bin/env bash
#################################################################################
#										#
#	connect-ssh.sh								#
#	    ** Interface que facilita a conexao via SSH, entre maquinas		#
#										#
#	B^r@t4º					            		#
#	tk0082@hotmail.com							#
#	10.02.2020								#
#										#
#-------------------------------------------------------------------------------#
#										#
#	1.0 - 20.01.2018 - Testes de aplicação sem interface			#
#	1.1 - 15.02.1018 - Configuração de parâmetros				#
#	1.2 - 18.02.1018 - Interface com Dialog					#
#										#
#################################################################################

#-------------------------------------------------------------------------------#
# SETANDO AS CORES DE EXIBICAO - Sera criado um arquivo em /home/.dialogrc	#
#-------------------------------------------------------------------------------#
dp=0

dialog --create-rc $HOME/.dialogrc
echo " 
  use_shadow  			= OFF
  use_colors  			= ON 
  screen_color 			= (GREEN, BLACK, OFF) 
  dialog_color 			= (BLACK, GREEN, OFF) 
  title_color  			= (GREEN, BLACK, ON) 
  border_color 			= (GREEN, BLACK, ON) 
  button_active_color 		= (BLACK, GREEN, OFF) 
  button_inactive_color 	= (BLACK, GREEN, OFF) 
  button_key_active_color 	= (GREEN, BLACK, OFF)
  button_key_inactive_color 	= (BLACK, GREEN, OFF)
  button_label_active_color	= (GREEN, BLACK, OFF)
  button_label_inactive_color	= (BLACK, GREEN, OFF)
  inputbox_color 		= (GREEN, BLACK, ON) 
  inputbox_border_color 	= (GREEN, BLACK, ON) 
  position_indicator_color 	= (BLACK, GREEN, OFF) 
  searchbox_title_color 	= (GREEN, BLACK, OFF) 
  searchbox_border_color 	= (GREEN, BLACK, OFF) 
  " > $HOME/.dialogrc

#-----------------------------------------------------------------------------------------------#

v="\033\e[38;5;160;1m"
k="\033\e[38;51;30m"
vd="\033\e[38;5;76;1m"
cy="\033\e[38;5;80;1m"
of="\033\e[0m"
c=clear
dir=/data/data/com.termux/files/usr/share/vssh
dirt=/data/data/com.termux/files/usr/tmp
dirb=/data/data/com.termux/files/usr/bin
brr="$k[$v CONECTANDO $k]$v==============================$k[ "
br1="$k]"

msg="
$vd
  V-SSH simplifica o uso de conexao SSH, com uma interface de fácil uso.

  Uso:
  $vd	Caso já configurado no sistema,$cy vssh$vd apenas.
  
  $cy	v-ssh $k[ $vd-c, -h, -r $k]
  $cy	  -c $vd-- Configurar aplicação no sistema$k [$vd Chamada simples com$cy vssh$k ]
  $cy	  -h $vd-- Mostra esta mensagem -$cy HELP
  $cy	  -r $vd-- Remover o programa do sistema
"

load(){
for i in '| ' '/ ' '--' '\ '; do
	echo -e "$brr$v$i$br1"; sleep 0.1
	$c
done
}

# Dependências de programa
deps(){ 
prog="
dialog
"
  for i in $prog; do
    pr=$(dpkg-query --list |grep -i $i )
    if [ ! "$pr" ];then
      echo "$vd Instalando,$cy $i$vd.."
      apt-get install -y $i > /dev/null 2>&1 
      dp=1
    fi
    if [ -f "$pr" ];then
      echo "$vd Programa$cy $i$vd já instalado.."
      sleep 1
      $c
    fi
  done
}

configure(){
$c
deps
if [ -d "$dir" ];then
	$c
	echo -e "$vd Programa já instalado, verifique em $dir!"
	echo -ne "$vd Desea reinstalar?[ S/N ]: "; read resp;

	if [ "$resp" == 'S' -o "$resp" == 's' ];then
		$c
		cp $dir/vssh.sh $dirt/vssh.sh
		cp $0 $dirt/vssh.sh
		rm -rf $dir
		rm -f $dirb/vssh
		mkdir $dir
		mv -f $dirt/vssh.sh $dir/vssh.sh
		ln -s $dir/vssh.sh $dirb/vssh
		echo -e "$cy V-SSH$vd instalado em $dir!"
		sleep 2
		$c
	else
		$c
		echo -e "$vd Nada a fazer!!"
		sleep 1
		$c
	fi	
else
	$c
	mkdir $dir
	cp $0 $dir/vssh.sh
	ln -s $dir/vssh.sh $dirb/vssh
	echo -e "$cy V-SSH$vd instalado em $dir!"
	sleep 2
	$c
fi
}

remove(){
	$c
	rm -rf $dir $dirb/vssh > /dev/null 2>&1
	echo -ne "$vd Removendo$cy V-SSH$vd do sistema, aguarde.."
	$c
	echo -e "$v Programa removido do sistema!"
	sleep 1.5
	$c
	exit 0
}

con(){

	setterm --cursor on
	ssh $usr@$ip -p $port
	if [ ! $con ];then
		$c
		echo -ne "$v ### SAINDO! ###"; sleep 1.5
		$c
		exit 0
	fi
	return
}

connect(){
dialog  --title ' CONEXAO SSH ' --yesno 'Conectar via SSH? ' 5 30 			# CONFIRMACAO DE CONEXAO
if [ $? = 0 ]; then
	dialog --infobox 'A seguir, alguns ajustes para conectar..' 4 30; sleep 1; 	# DADOS DA CONEXAO

	usr=$( dialog --stdout --inputbox " ** Qual o usuario: " 5 40 )
	[ "$usr" ] || {
		dialog --infobox ' ** Campo Obrigatório!! ** ' 3 30
		sleep 1
		$c 
		exit 1
	}
	ip=$( dialog --stdout --inputbox ' ** Digite o IP: ' 5 40 )
	[ "$ip" ] || {
		dialog --infobox ' ** Campo Obrigatório!! ** ' 3 30
		sleep 1
		$c
		exit 1
	}
	port=$( dialog --stdout --inputbox ' ** Informe a porta [Padrão 22]: ' 5 40 )
	[ "$port" ] ||  
		port=22 

	dialog --stdout --yesno " ** Confirmar Conexao $usr@$ip:$port " 6 60		# CONFIRMACAO DE DADOS E
	if [ $? = 0 ]; then								# INICIO DA CONEXAO
		$c
		if [ ! $con ]; then
			setterm --cursor off
			load
      fi
		con
		sleep 0.3
	else
		dialog --infobox ' ** Conexao cancelada! ** ' 3 30 
		sleep 1
		setterm --cursor on
		$c
		exit 0
	fi
elif [ $? = 1 ]; then
	dialog --infobox ' ** Conexao cancelada ** ' 3 30
	sleep 1
	setterm --cursor on
	$c
	exit 1
else	 
	setterm --cursor on
	$c
	exit 1
fi
}

case $1 in
 -h) 
	$c
       	echo -e "$msg"
	echo -ne "$vd  Pressione 'Enter' para sair: ";read
        $c ;;
 -c) configure ;;
 -r) remove ;;
 '') connect ;;
 * ) $c; echo "$v Opção inválida!"
     sleep 1
     $c ;;
esac

#-----------------------------------------------------------------------------------------------#

#=[I.G.W.T]==========

