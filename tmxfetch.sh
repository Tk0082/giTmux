#!/usr/bin/env bash
#
####################################################
# TmxFetch - Fetch para Termux com ifos de Sistema
#
# B4r@'|'^o
# tk0082@hotmail.com
#
#   - 1.0.0 [Mar 2022] -- Início de projeto
#   - 1.0.1 [Ago 2022] -- Opções de cores
#   - 1.1.0 [Ago 2022] -- Ajuste de dependências de programas
#   - 1.1.1 [Dez 2022] -- Opções de uso
#
####################################################

clear

dp=0
c=clear
vc='[38;2;179;212;64m'
vm='[38;2;120;144;45m'
vd='[1;32m'
k='[1;30m'
azd='[1;34m'
azc='[0;36m'
cy='[1;36m'
red='[1;31m'
cla='[1m'
z='[0m'
dir="/data/data/com.termux/files"

#==[VERSÃO]=========================================
vrs="$vd TmxFetch - Versão:$cy 1.1.1"

msg="
$vd
  TmxFetch - Fetch personalizado com informacoes de Sistema.

  Uso:
  $vd   Caso já configurado no sistema,$cy tmxfetch$vd apenas.
  
  $cy   tmxfecth $k[ $vd-c, -h, -r, -v $k]
  $cy     -c $vd-- Configurar aplicação no sistema$k [$vd Chamada simples com$cy tmxfetch$k ]
  $cy     -h $vd-- Mostra esta mensagem -$cy HELP
  $cy     -r $vd-- Remover o programa do sistema
  $cy     -v $vd-- Versão
"

#==[ Verificação de usuário ]=======================
if [ "$(whoami)" != "root" ];then
	usr='tmux'
else
	usr='root'
fi

#==[ Dependências de programas ]====================
# prog - Lista de programas a verificar
deps(){
prog="
getconf
bc
sed
grep
"
  for i in $prog; do
    pr=$(dpkg-query --list |grep -i $i )
    if [ ! "$pr" ];then
      echo "$vm Instalando, $i.."
      apt-get install -y $i > /dev/null 2>&1
      dp=1
      clear
    fi
    if [ -f "$pr" ];then
      echo "$vd Programa $i já instalado"
    fi
  done
}

config(){
   $c
   cp $0 $dir/usr/bin/tmxfetch
   echo -e "$vd Programa instalado, use:$k [$cy tmxfetch$k ].$z"
   sleep 1
   exit 0
   $c
}

remove(){
   $c
   rm -f $dir/usr/bin/tmxfetch
   echo -ne "$vm Programa removido!!"
   sleep 1
   $c
   exit 0
}

get_info(){
	title=$usr@$HOSTNAME
	#d=$(uname -a |awk '{print $2}')
	da=$(uname -m |sed 's/^a/A/')
	#d=$(termux-info |grep TERMUX_VER* |sed 's/.*=//g')
	d=$(compgen -e TERMUX_VERSION | while read v; do echo "${!v}"; done)
	os=$(uname -o)
	#knm=$(cat /proc/sys/kernel/ostype)
	knm=$(uname -s)
	#kvs=$(cat /proc/sys/kernel/osrelease)
	kvs=$(uname -r)
	time=$(uptime | awk '{print $3}'|sed 's/,//')" min.."
	shell=$(basename $SHELL)
	#resol=$(xrand | sed -n '1p' | sed 's/.current.//g;s/,.*//g;s/ //g')
	#d_cpu=$(sudo cat /proc/cpuinfo | grep -o 'model name.*' | sed -n 1p | sed 's/.*:.//g;s/(.*)//g')
	d_cpu=$(lscpu |grep -i 'model name' | sed 's/.* //g')
	d_mem=$(echo "scale=1;$(cat /proc/meminfo | sed -n 1p | tr -d [A-Za-z:' '])" / 1000000 | bc)" Gb"
	d_memfree=$(echo "scale=2;$(cat /proc/meminfo | sed -n 3p | tr -d [A-Za-z:' '])" / 1000000 | bc)" Gb"
	d_arch=$(getconf LONG_BIT)"-bits"
	d_char=$(expr length "$title"); qtd=
	for i in $(seq 1 $d_char); do
		qtd="$qtd─"
	done
}

display_info(){
get_info
cat <<EOF 



$azd $title
$azd $qtd
$azd Distro:$cy	 Termux $d
$azd OS:$cy		 $os
$azd K. Name:$cy	 $knm
$azd K. Version:$cy     $kvs
$azd Shell:$cy		 ${shell^}
$azd Uptime:$cy	 $time $zr
$azd CPU:$cy		 $d_cpu
$azd RAM:$cy		 $d_mem
$azd Mem Free:$cy	 $d_memfree
$azd Architeture:$cy	 $da $d_arch

EOF
}

droid="
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;4;4;4m [0m[38;2;81;95;36m,[0m[38;2;55;63;25m.[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;26;31;12m [0m[38;2;60;72;25m.[0m[38;2;8;9;4m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;5;5;5m [0m[38;2;7;8;4m [0m[38;2;15;17;9m [0m[38;2;94;111;42m:[0m[38;2;171;204;63mO[0m[38;2;11;13;5m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;49;49;49m [0m[38;2;125;125;125m [0m[38;2;125;157;45mo[0m[38;2;100;122;41m:[0m[38;2;89;111;32m;[0m[38;2;121;149;44ml[0m[38;2;148;179;53md[0m[38;2;168;201;62mk[0m[38;2;185;214;80mO[0m[38;2;197;222;100m0[0m[38;2;189;219;75m0[0m[38;2;185;215;68mO[0m[38;2;177;202;67mk[0m[38;2;160;182;62mx[0m[38;2;134;150;55mo[0m[38;2;100;110;44m:[0m[38;2;55;61;27m.[0m[38;2;4;4;2m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;2;2;1m [0m[38;2;67;77;34m'[0m[38;2;134;156;60mo[0m[38;2;169;207;63mk[0m[38;2;176;214;60mO[0m[38;2;184;218;64mO[0m[38;2;191;221;68m0[0m[38;2;196;223;72m0[0m[38;2;201;226;76m0[0m[38;2;205;227;79mK[0m[38;2;207;228;80mK[0m[38;2;208;228;81mK[0m[38;2;208;228;81mK[0m[38;2;208;229;81mK[0m[38;2;208;228;81mK[0m[38;2;208;228;80mK[0m[38;2;208;228;81mK[0m[38;2;210;230;87mK[0m[38;2;199;215;94m0[0m[38;2;142;152;78mo[0m[38;2;58;63;32m.[0m[38;2;2;2;2m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;1;1;1m [0m[38;2;59;69;29m'[0m[38;2;166;190;80mk[0m[38;2;182;219;74m0[0m[38;2;171;212;58mO[0m[38;2;186;219;65m0[0m[38;2;198;224;73m0[0m[38;2;204;227;78mK[0m[38;2;208;229;81mK[0m[38;2;210;230;83mK[0m[38;2;211;230;84mK[0m[38;2;212;230;84mK[0m[38;2;212;230;84mK[0m[38;2;211;230;84mK[0m[38;2;212;230;84mK[0m[38;2;211;230;84mK[0m[38;2;211;230;83mK[0m[38;2;212;230;83mK[0m[38;2;211;230;83mK[0m[38;2;211;230;83mK[0m[38;2;211;230;83mK[0m[38;2;212;230;88mK[0m[38;2;220;235;110mX[0m[38;2;173;183;98mk[0m[38;2;41;44;22m.[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;2;2;2m [0m[38;2;99;116;47m:[0m[38;2;197;225;92m0[0m[38;2;168;211;62mO[0m[38;2;163;209;52mk[0m[38;2;186;219;65mO[0m[38;2;202;226;76m0[0m[38;2;208;229;81mK[0m[38;2;210;229;83mK[0m[38;2;211;230;84mK[0m[38;2;211;230;84mK[0m[38;2;211;230;84mK[0m[38;2;212;230;84mK[0m[38;2;211;230;84mK[0m[38;2;211;230;84mK[0m[38;2;211;230;84mK[0m[38;2;183;201;72mO[0m[38;2;99;115;46m:[0m[38;2;181;190;151mO[0m[38;2;167;179;108mx[0m[38;2;211;229;84mK[0m[38;2;212;230;84mK[0m[38;2;211;230;84mK[0m[38;2;211;230;84mK[0m[38;2;215;232;95mK[0m[38;2;220;233;121mX[0m[38;2;77;83;42m,[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;62;75;30m.[0m[38;2;193;222;90m0[0m[38;2;170;211;65mO[0m[38;2;152;203;46mk[0m[38;2;168;211;55mO[0m[38;2;193;222;70m0[0m[38;2;203;223;79m0[0m[38;2;111;128;45mc[0m[38;2;173;183;134mk[0m[38;2;178;189;128mk[0m[38;2;194;213;77m0[0m[38;2;211;230;84mK[0m[38;2;211;230;84mK[0m[38;2;211;230;83mK[0m[38;2;211;230;83mK[0m[38;2;211;230;83mK[0m[38;2;204;222;79m0[0m[38;2;150;167;59md[0m[38;2;139;156;57mo[0m[38;2;167;184;65mx[0m[38;2;211;230;84mK[0m[38;2;211;230;84mK[0m[38;2;211;230;84mK[0m[38;2;211;230;84mK[0m[38;2;210;229;83mK[0m[38;2;211;230;86mK[0m[38;2;216;230;109mK[0m[38;2;38;42;20m.[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;3;4;2m [0m[38;2;165;196;74mk[0m[38;2;183;215;80mO[0m[38;2;146;197;45mx[0m[38;2;151;202;46mk[0m[38;2;169;210;56mO[0m[38;2;193;221;71m0[0m[38;2;206;227;81mK[0m[38;2;152;170;61md[0m[38;2;128;145;54ml[0m[38;2;141;159;57mo[0m[38;2;205;224;81m0[0m[38;2;211;230;83mK[0m[38;2;210;229;82mK[0m[38;2;210;229;82mK[0m[38;2;210;229;81mK[0m[38;2;210;229;82mK[0m[38;2;208;228;81mK[0m[38;2;198;219;76m0[0m[38;2;188;212;72mO[0m[38;2;182;207;69mO[0m[38;2;176;204;66mO[0m[38;2;173;201;65mk[0m[38;2;171;201;64mk[0m[38;2;170;200;63mk[0m[38;2;168;199;63mk[0m[38;2;168;200;63mk[0m[38;2;175;204;68mk[0m[38;2;113;129;50mc[0m[38;2;3;3;3m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;13;16;7m [0m[38;2;163;200;65mk[0m[38;2;155;197;58mk[0m[38;2;138;192;41mx[0m[38;2;156;203;49mk[0m[38;2;176;213;60mO[0m[38;2;190;218;70m0[0m[38;2;198;221;76m0[0m[38;2;202;223;78m0[0m[38;2;203;224;79m0[0m[38;2;202;222;79m0[0m[38;2;201;222;80m0[0m[38;2;202;222;83m0[0m[38;2;204;223;87m0[0m[38;2;211;227;101mK[0m[38;2;212;227;109mK[0m[38;2;192;210;99m0[0m[38;2;171;194;86mk[0m[38;2;160;187;74mx[0m[38;2;155;184;63mx[0m[38;2;150;180;58mx[0m[38;2;146;179;56md[0m[38;2;144;178;54md[0m[38;2;139;175;51md[0m[38;2;133;171;48md[0m[38;2;126;168;47mo[0m[38;2;117;158;47ml[0m[38;2;34;47;15m.[0m[38;2;33;33;33m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;13;13;13m [0m[38;2;16;20;7m [0m[38;2;105;133;41mc[0m[38;2;152;185;57mx[0m[38;2;178;208;65mO[0m[38;2;188;213;70mO[0m[38;2;193;217;72m0[0m[38;2;187;212;70mO[0m[38;2;169;199;61mk[0m[38;2;163;194;57mk[0m[38;2;173;202;61mk[0m[38;2;191;218;68m0[0m[38;2;196;222;71m0[0m[38;2;197;223;72m0[0m[38;2;199;223;73m0[0m[38;2;201;222;79m0[0m[38;2;205;224;86m0[0m[38;2;202;221;86m0[0m[38;2;202;221;83m0[0m[38;2;205;224;81m0[0m[38;2;205;224;80m0[0m[38;2;205;224;82m0[0m[38;2;206;225;83mK[0m[38;2;206;224;84m0[0m[38;2;203;222;84m0[0m[38;2;202;222;79m0[0m[38;2;206;226;82mK[0m[38;2;194;215;85m0[0m[38;2;132;148;62mo[0m[38;2;9;9;9m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;37;44;18m.[0m[38;2;94;121;37m:[0m[38;2;114;159;39ml[0m[38;2;131;180;42md[0m[38;2;152;201;47mk[0m[38;2;172;211;57mO[0m[38;2;192;220;69m0[0m[38;2;202;225;75m0[0m[38;2;205;226;77mK[0m[38;2;205;227;78mK[0m[38;2;203;225;76m0[0m[38;2;187;211;69mO[0m[38;2;165;193;59mk[0m[38;2;161;188;58mx[0m[38;2;185;207;75mO[0m[38;2;194;217;77m0[0m[38;2;184;208;68mO[0m[38;2;181;206;67mO[0m[38;2;185;208;68mO[0m[38;2;188;210;71mO[0m[38;2;204;224;79m0[0m[38;2;208;228;81mK[0m[38;2;208;228;81mK[0m[38;2;208;228;81mK[0m[38;2;208;228;81mK[0m[38;2;209;229;82mK[0m[38;2;204;222;86m0[0m[38;2;201;222;78m0[0m[38;2;200;224;80m0[0m[38;2;186;210;82mO[0m[38;2;1;1;1m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;44;53;20m.[0m[38;2;159;198;61mk[0m[38;2;121;173;37mo[0m[38;2;116;170;35mo[0m[38;2;114;167;35mo[0m[38;2;121;167;40mo[0m[38;2;143;194;45mx[0m[38;2;151;199;47mx[0m[38;2;172;210;58mO[0m[38;2;192;220;70m0[0m[38;2;202;225;77m0[0m[38;2;205;226;79mK[0m[38;2;206;227;79mK[0m[38;2;205;227;78mK[0m[38;2;200;222;75m0[0m[38;2;185;208;68mO[0m[38;2;185;208;68mO[0m[38;2;193;216;71m0[0m[38;2;200;223;74m0[0m[38;2;203;225;76m0[0m[38;2;205;226;77m0[0m[38;2;205;227;78mK[0m[38;2;206;227;79mK[0m[38;2;207;227;79mK[0m[38;2;207;228;80mK[0m[38;2;207;228;80mK[0m[38;2;207;228;80mK[0m[38;2;205;225;85m0[0m[38;2;197;218;76m0[0m[38;2;199;224;80m0[0m[38;2;185;209;82mO[0m[38;2;1;1;1m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;16;20;7m [0m[38;2;158;198;60mk[0m[38;2;117;170;36mo[0m[38;2;112;166;33mo[0m[38;2;111;165;33mo[0m[38;2;104;157;31ml[0m[38;2;101;142;34mc[0m[38;2;127;174;42mo[0m[38;2;134;186;41md[0m[38;2;151;196;49mx[0m[38;2;174;210;63mO[0m[38;2;195;221;76m0[0m[38;2;205;226;84mK[0m[38;2;208;228;85mK[0m[38;2;207;228;84mK[0m[38;2;207;227;82mK[0m[38;2;205;227;80mK[0m[38;2;203;225;78m0[0m[38;2;201;224;75m0[0m[38;2;198;222;73m0[0m[38;2;196;221;71m0[0m[38;2;196;221;71m0[0m[38;2;196;221;72m0[0m[38;2;198;221;73m0[0m[38;2;199;222;76m0[0m[38;2;198;219;77m0[0m[38;2;200;220;80m0[0m[38;2;199;219;78m0[0m[38;2;202;224;76m0[0m[38;2;197;222;78m0[0m[38;2;181;206;79mO[0m[38;2;1;1;1m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;7;7;7m [0m[38;2;69;69;69m [0m[38;2;121;121;121m [0m[38;2;84;116;29m;[0m[38;2;107;155;35ml[0m[38;2;101;149;32mc[0m[38;2;93;138;30mc[0m[38;2;81;120;27m;[0m[38;2;95;135;33mc[0m[38;2;111;157;38ml[0m[38;2;127;174;42mo[0m[38;2;147;188;52mx[0m[38;2;169;202;67mk[0m[38;2;168;202;65mk[0m[38;2;164;199;60mk[0m[38;2;161;197;58mk[0m[38;2;159;196;56mk[0m[38;2;153;193;53mx[0m[38;2;148;189;50mx[0m[38;2;143;182;49md[0m[38;2;142;179;49md[0m[38;2;148;182;52mx[0m[38;2;160;191;57mx[0m[38;2;176;203;65mk[0m[38;2;189;212;71mO[0m[38;2;199;221;75m0[0m[38;2;203;224;76m0[0m[38;2;202;224;76m0[0m[38;2;199;223;75m0[0m[38;2;194;220;75m0[0m[38;2;179;204;77mO[0m[38;2;1;1;1m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;69;90;29m'[0m[38;2;101;149;32mc[0m[38;2;93;141;29mc[0m[38;2;91;138;28mc[0m[38;2;91;140;28mc[0m[38;2;91;141;27mc[0m[38;2;83;128;25m:[0m[38;2;80;122;25m;[0m[38;2;90;131;30m:[0m[38;2;98;138;34mc[0m[38;2;99;141;34mc[0m[38;2;97;139;33mc[0m[38;2;96;137;32mc[0m[38;2;97;139;33mc[0m[38;2;101;144;33mc[0m[38;2;110;152;35ml[0m[38;2;127;168;41mo[0m[38;2;152;189;50mx[0m[38;2;175;206;61mO[0m[38;2;190;217;68m0[0m[38;2;196;221;72m0[0m[38;2;198;222;74m0[0m[38;2;200;223;75m0[0m[38;2;201;223;75m0[0m[38;2;200;223;75m0[0m[38;2;197;221;73m0[0m[38;2;191;217;72m0[0m[38;2;177;202;75mO[0m[38;2;21;21;21m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;78;100;32m,[0m[38;2;121;172;39mo[0m[38;2;103;159;30ml[0m[38;2;104;159;30ml[0m[38;2;105;160;30ml[0m[38;2;105;160;30ml[0m[38;2;105;160;31ml[0m[38;2;103;157;30ml[0m[38;2;101;153;30ml[0m[38;2;101;151;30ml[0m[38;2;104;154;31ml[0m[38;2;111;160;34ml[0m[38;2;121;169;37mo[0m[38;2;136;181;41md[0m[38;2;153;193;48mx[0m[38;2;167;202;55mk[0m[38;2;177;209;60mO[0m[38;2;183;213;63mO[0m[38;2;187;215;65mO[0m[38;2;191;217;68m0[0m[38;2;193;218;70m0[0m[38;2;196;220;72m0[0m[38;2;198;222;73m0[0m[38;2;198;222;74m0[0m[38;2;198;222;74m0[0m[38;2;195;219;72m0[0m[38;2;188;215;70mO[0m[38;2;174;199;73mO[0m[38;2;12;12;12m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;73;96;29m,[0m[38;2;115;166;37mo[0m[38;2;99;153;29ml[0m[38;2;100;154;29ml[0m[38;2;101;155;30ml[0m[38;2;102;156;30ml[0m[38;2;104;157;30ml[0m[38;2;105;159;31ml[0m[38;2;108;161;32ml[0m[38;2;111;163;33ml[0m[38;2;113;165;34mo[0m[38;2;116;167;35mo[0m[38;2;120;170;36mo[0m[38;2;127;175;39md[0m[38;2;138;182;42md[0m[38;2;153;192;48mx[0m[38;2;168;202;55mk[0m[38;2;177;209;59mO[0m[38;2;182;212;63mO[0m[38;2;185;214;64mO[0m[38;2;188;215;66mO[0m[38;2;192;217;69m0[0m[38;2;194;219;70m0[0m[38;2;195;219;71m0[0m[38;2;195;219;72m0[0m[38;2;192;217;70m0[0m[38;2;185;213;68mO[0m[38;2;173;198;73mO[0m[38;2;10;10;10m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;75;96;29m,[0m[38;2;113;163;36mo[0m[38;2;93;146;26mc[0m[38;2;94;147;27mc[0m[38;2;95;149;28mc[0m[38;2;97;149;28mc[0m[38;2;99;151;29mc[0m[38;2;100;153;29ml[0m[38;2;102;154;30ml[0m[38;2;103;156;31ml[0m[38;2;105;157;31ml[0m[38;2;107;158;31ml[0m[38;2;109;160;32ml[0m[38;2;112;163;33ml[0m[38;2;118;167;35mo[0m[38;2;128;174;39md[0m[38;2;144;185;44mx[0m[38;2;157;194;50mx[0m[38;2;161;197;52mk[0m[38;2;159;195;51mx[0m[38;2;157;194;51mx[0m[38;2;159;195;53mx[0m[38;2;163;197;55mk[0m[38;2;168;200;57mk[0m[38;2;172;203;59mk[0m[38;2;173;204;59mk[0m[38;2;176;207;65mO[0m[38;2;161;189;66mk[0m[38;2;10;10;10m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;60;60;60m [0m[38;2;60;81;22m'[0m[38;2;110;158;36ml[0m[38;2;95;146;29mc[0m[38;2;89;141;26mc[0m[38;2;89;141;26mc[0m[38;2;91;142;26mc[0m[38;2;92;144;27mc[0m[38;2;94;146;27mc[0m[38;2;95;147;28mc[0m[38;2;97;147;28mc[0m[38;2;98;148;29mc[0m[38;2;99;150;29mc[0m[38;2;101;152;30ml[0m[38;2;104;154;31ml[0m[38;2;105;155;31ml[0m[38;2;107;157;32ml[0m[38;2;111;160;34ml[0m[38;2;112;161;35ml[0m[38;2;112;160;35ml[0m[38;2;116;163;36mo[0m[38;2;124;168;39mo[0m[38;2;133;175;43md[0m[38;2;144;183;48md[0m[38;2;153;190;54mx[0m[38;2;159;193;60mx[0m[38;2;124;154;46mo[0m[38;2;92;92;92m [0m[38;2;3;3;3m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;9;9;9m [0m[38;2;27;36;10m.[0m[38;2;91;129;31m:[0m[38;2;93;133;32m:[0m[38;2;93;136;31mc[0m[38;2;94;138;30mc[0m[38;2;94;141;30mc[0m[38;2;93;141;29mc[0m[38;2;90;139;27mc[0m[38;2;88;138;26m:[0m[38;2;87;137;25m:[0m[38;2;88;137;25m:[0m[38;2;89;139;26mc[0m[38;2;92;142;27mc[0m[38;2;97;146;30mc[0m[38;2;103;151;32ml[0m[38;2;104;153;31ml[0m[38;2;123;168;37mo[0m[38;2;152;188;49mx[0m[38;2;173;203;59mk[0m[38;2;184;211;66mO[0m[38;2;189;214;69mO[0m[38;2;192;216;70m0[0m[38;2;190;215;69mO[0m[38;2;187;213;70mO[0m[38;2;141;166;56mo[0m[38;2;3;3;3m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;18;18;18m [0m[38;2;58;84;20m'[0m[38;2;66;101;20m,[0m[38;2;61;96;18m,[0m[38;2;64;99;19m,[0m[38;2;67;103;20m,[0m[38;2;72;110;22m;[0m[38;2;76;114;24m;[0m[38;2;79;117;25m;[0m[38;2;79;118;26m;[0m[38;2;80;120;26m;[0m[38;2;80;116;27m;[0m[38;2;82;82;82m [0m[38;2;3;4;2m [0m[38;2;109;153;37ml[0m[38;2;96;144;28mc[0m[38;2;113;159;34ml[0m[38;2;143;182;45md[0m[38;2;166;199;55mk[0m[38;2;183;210;64mO[0m[38;2;192;216;70m0[0m[38;2;194;217;71m0[0m[38;2;193;216;71m0[0m[38;2;188;214;70mO[0m[38;2;170;196;68mk[0m[38;2;2;2;1m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;4;6;1m [0m[38;2;85;124;29m:[0m[38;2;66;102;19m,[0m[38;2;70;108;20m,[0m[38;2;76;117;22m;[0m[38;2;79;122;23m;[0m[38;2;79;123;23m:[0m[38;2;79;123;23m;[0m[38;2;78;121;23m;[0m[38;2;77;121;23m;[0m[38;2;83;124;26m:[0m[38;2;2;2;1m [0m[38;2;2;2;2m [0m[38;2;28;39;10m.[0m[38;2;110;156;37ml[0m[38;2;93;141;28mc[0m[38;2;107;153;32ml[0m[38;2;137;177;43md[0m[38;2;162;195;53mk[0m[38;2;181;208;63mO[0m[38;2;188;213;67mO[0m[38;2;188;213;68mO[0m[38;2;184;210;66mO[0m[38;2;181;208;72mO[0m[38;2;10;12;4m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;3;3;3m [0m[38;2;4;4;4m [0m[38;2;39;53;16m.[0m[38;2;81;119;26m:[0m[38;2;78;118;24m;[0m[38;2;80;121;24m;[0m[38;2;81;123;24m:[0m[38;2;82;125;24m:[0m[38;2;83;127;25m:[0m[38;2;83;127;25m:[0m[38;2;81;126;24m:[0m[38;2;71;108;22m,[0m[38;2;27;29;22m [0m[38;2;22;22;22m [0m[38;2;24;26;20m [0m[38;2;86;122;31m:[0m[38;2;107;154;36ml[0m[38;2;93;140;28mc[0m[38;2;105;151;31ml[0m[38;2;132;173;41md[0m[38;2;157;191;51mx[0m[38;2;173;202;59mk[0m[38;2;178;205;61mO[0m[38;2;174;202;60mk[0m[38;2;178;206;69mO[0m[38;2;27;33;10m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;6;6;6m [0m[38;2;19;19;19m [0m[38;2;28;28;28m [0m[38;2;37;37;37m [0m[38;2;44;44;44m [0m[38;2;1;2;1m [0m[38;2;2;2;1m [0m[38;2;2;3;1m [0m[38;2;2;2;1m [0m[38;2;1;1;1m [0m[38;2;2;2;2m [0m[38;2;6;6;6m [0m[38;2;12;12;12m [0m[38;2;21;21;21m [0m[38;2;37;46;22m.[0m[38;2;89;128;30m:[0m[38;2;111;157;37ml[0m[38;2;117;161;38mo[0m[38;2;125;168;40mo[0m[38;2;142;180;47md[0m[38;2;164;195;57mk[0m[38;2;173;203;63mk[0m[38;2;173;202;63mk[0m[38;2;157;186;59mx[0m[38;2;37;44;18m.[0m[38;2;7;7;7m [0m[38;2;4;4;4m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;2;2;2m [0m[38;2;5;5;5m [0m[38;2;10;10;10m [0m[38;2;14;14;14m [0m[38;2;20;20;20m [0m[38;2;28;28;28m [0m[38;2;39;39;39m [0m[38;2;1;1;1m [0m[38;2;3;3;2m [0m[38;2;5;6;3m [0m[38;2;9;10;5m [0m[38;2;11;13;7m [0m[38;2;10;11;7m [0m[38;2;6;7;6m [0m[38;2;3;3;3m [0m[38;2;31;31;31m [0m[38;2;7;7;7m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
[0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;2;2;2m [0m[38;2;8;8;8m [0m[38;2;12;12;12m [0m[38;2;13;13;13m [0m[38;2;13;13;13m [0m[38;2;7;7;7m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m[38;2;0;0;0m [0m
"


case $1 in
   -c)
      config ;;
   -h)
      $c
      echo -e "$msg"
      echo -ne "Aperte Enter para sair: ";read
      $c
      ;;
   '')
      deps
      paste <(printf "%s" "$droid") <(printf "%s" "$(display_info)")
      ;;
   -r)
      remove ;;
   -v)
      $c
      echo -e "$vrs"
      sleep 1.5
      $c ;;
   *)
      $c
      echo -e "$vd Opção inválida, nada a fazer!$z"
      sleep 1.5
      $c
      exit 0
      ;;
esac

#=[I.G.W.T]===========
