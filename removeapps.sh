#!/usr/bin/env bash
#
######################################################################
#
#  B4r@'|'^o
#  tk0082@hotmail.com
#  github.com/Tk0082
#
#  1.0.0 - [16.Mar.24] -- Início da aplicação
#  1.0.2 - [18.Mar.24] -- Funções a serem chamadas por opções na CLI
#  1.0.6 - [20.Mar.24] -- Adição de apps na lista e adição de cores
#  1.0.8 - [24.Mar.24] -- Correções em funções da aplicação
#
######################################################################
#
#  RemoveApps
#
#  * Script que facilita a remoção (ou desativação) de apps
#    bloatwares, do celular.
#
#  ** Necessário root!
#
#    É importante verificar os apps a serem desabilitados ou
#  removidos, para não prejudicar a funcionalidade do 
#  seu aparelho.
#    Caso queira remover alguns dos apps da lista 'APPLIST',
#  comente com um # no início da linha.
#
######################################################################

clear

BK="[1;30m"
VM="[1;31m"
VD="[1;32m"
YL="[1;33m"
CC="[1;36m"
CE="[0;36m"

#==[VERSÃO]=============================
VS="$VD RemoveApps - Versão:$CC 1.0.8"

LISTAPPS="
com.skms.android.agent
com.sidia.suframa.notification
com.enhance.gameservice
com.facebook.katana
com.facebook.system
com.facebook.appmanager
com.facebook.services
com.linkedin.android
com.microsoft.skydrive
com.sec.android.diagmonagent
com.sec.android.easyonehand
com.sec.android.app.sbrowser
com.sec.android.easyMover.Agent
com.sec.android.app.chromecustomizations
com.sec.android.mimage.avatarstickers
com.sec.android.app.kidshome
com.android.settings.intelligence
com.android.stk
com.android.stk2
com.android.chrome
com.android.dreams.phototable
com.android.internal.systemui.onehanded.gestural
com.samsung.SMT
com.sec.spp.push
com.samsung.android.scpm
com.samsung.android.aware.service
com.samsung.android.mdx.kit
com.samsung.android.sdk
com.samsung.android.lool
com.samsung.android.dqagent
com.samsung.android.sdm.config
com.samsung.android.bixby.wakeup
com.samsung.android.app.spage
com.samsung.android.app.routines
com.samsung.android.bixby.service
com.samsung.android.visionintelligence
com.samsung.android.bixby.agent
com.samsung.android.bixby.agent.dummy
com.samsung.android.bixbyvision.framework
com.samsung.storyservice
com.samsung.sait.sohservice
com.samsung.aasaservice
com.samsung.faceservice
com.samsung.storyservice
com.samsung.android.app.appsedge
com.samsung.android.game.gamehome
com.samsung.android.gametuner.thin
com.samsung.android.game.gos
com.samsung.android.game.gametool
com.samsung.android.aremoji
com.samsung.android.easysetup
com.samsung.android.emojiupdater
com.samsung.android.mateagent
com.samsung.android.drivelink.stub
com.samsung.android.accessibility.talkback
com.samsung.android.app.social
com.samsung.ecomm.global
com.samsung.android.oneconnect
com.samsung.android.voc
com.samsung.android.scloud
com.samsung.android.sdk.handwriting
com.samsung.android.visioncloudagent
com.samsung.android.visionintelligence
com.samsung.android.widgetapp.yahooedge.finance
com.samsung.android.widgetapp.yahooedge.sport
com.samsung.android.service.aircommand
com.samsung.android.da.daagent
com.samsung.android.kidsinstaller
com.samsung.android.app.camera.sticker.facearavatar.preload
com.google.ar.lens
com.google.android.documentsui
com.google.android.apps.docs
com.google.android.apps.photos
com.google.android.music
com.google.android.videos
com.google.android.apps.tachyon
com.google.android.apps.wellbeing
com.google.android.googlequicksearchbox
com.google.android.inputmethod.latin
com.google.android.feedback
com.google.android.as.oss
com.google.android.marvin.talkback
com.google.android.youtube
com.google.android.printservice.recommendation
com.google.android.gms.supervis
com.google.android.apps.turbo
com.google.android.tts
"

MSG="
$CC   RemoveApps$VD - Script que facilita na remoção (ou desativação), de apps do celular

   Opções de uso:

      removeapps.sh$BK [$CC -d, -e, -r$BK ] ${YL}com.nome.pacote $VD
      removeapps.sh$BK [$CC -c, --disableall, --enableall, -h, -l, --removeall, -v$BK ]

      $CC -c$VD -- Configurar programa no Sistema
      $CC -d$VD -- Desabilitar um App específico, passando seu pacote
      $CC --disableall$VD -- Desabilitar todos os Apps da$YL LISTA
      $CC -e$VD -- Habilitar um App específico, passando seu pacote
      $CC --enableall$VD -- Habilitar todos os Apps da$YL LISTA
      $CC -h$VD -- Mostra esta memsagem - HELP
      $CC -l$VD -- Mostra a lista de Apps a remover$YL (Adicionar ou Remover Apps na Lista)
      $CC -r$VD -- Remover um App específico, passando o seu pacote
      $CC --removeall$VD -- Remover todos os Apps da$YL LISTA
      $CC -v$VD -- Versão do programa
"

APK="$2"
PTH="/data/data/com.termux/files/usr/bin"

configure(){
   cp $0  $PTH/removeapps
   chmod 755 $PTH/removeapps
   echo -e "$VD Configurando Aplicação no sistema.."; sleep 1
   echo -e "\n${CC}Use removeapps -h para conferir o Modo de Uso!"
   echo -ne "Aperte Enter para sair: "; read
   clear
}

disableapp(){
   echo $VD
   pr=$(sudo pm list packages $APK )
   if [ "$pr" ];then
      su -c pm clear $APK
      echo -ne "$VD✓ $CC$APK - ${YL}limpo! $VD \n"
      su -c pkill -9  $APP
      su -c pm disable --user 0 $APK; sleep 1
   else
      paste <(printf "$VM✗ $CE%s " "$APK") <(printf "......") <(printf "${BK}App não instalado! $VD \n")
   fi
}

disableall(){
   echo $VD
   for APP in $LISTAPPS;do
      pr=$(sudo pm list packages | grep -i "$APP" )
      if [ "$pr" ];then
         su -c pm clear $APP
         echo -ne "$VD✓ $CC$APP - ${YL}limpo! $VD \n"; sleep .5
         su -c pkill -9  $APP
         su -c pm disable --user 0 $APP; sleep .5
      else
         paste <(printf "$VM✗ $CE%s " "$APP") <(printf "......") <(printf "${BK}App não instalado! $VD \n")
      fi
   done
}

enableapp(){
   echo $VD
   pr=$(sudo pm list packages $APK )
   if [ "$pr" ];then
      su -c pm enable --user 0 $APK; sleep 1
   else
      paste <(printf "$VM✗ $CE%s " "$APK") <(printf "......") <(printf "${BK}App não instalado! $VD \n")
   fi
}

enableall(){
   echo $VD
   for APP in $LISTAPPS;do
      pr=$(sudo pm list packages | grep -i "$APP" )
      if [ "$pr" ];then
         su -c pm enable --user 0 $APP; sleep 1
      else
         paste <(printf "$VM✗ $CE%s " "$APP") <(printf "......") <(printf "${BK}App não instalado! $VD \n")
      fi
   done
}

removeapp(){
   echo $VD
   pr=$(sudo pm list packages $APK )
   if [ "$pr" ];then
      su -c pm clear $APK
      echo -ne "$VD✓ $CC$APK - ${YL}limpo! $VD \n"
      su -c pkill -9  $APP
      su -c pm uninstall -k --user 0 $APK; sleep 1
   else
      paste <(printf "$VM✗ $CE%s " "$APK") <(printf "......") <(printf "${BK}App não instalado! $VD \n")
   fi
}

removeall(){
   echo $VD
   for APP in $LISTAPPS;do
      pr=$(sudo pm list packages | grep -i "$APP" )
      if [ "$pr" ];then
         su -c pm clear $APP
         su -c pkill -9  $APP
         su -c pm uninstall -k --user 0 $APP; sleep 1
         echo -ne "$VD✓ $CC$APP - ${VM}Removido! $VD \n"
      else
         paste <(printf "$VM✗ $CE%s " "$APP") <(printf "......") <(printf "${BK}App não instalado! $VD \n")
      fi
   done
}

case $1 in
   -c)
      configure ;;
   -d)
      disableapp ;;
   --disableall)
      disableall ;;
   -e)
      enableapp ;;
   --enableall)
      enableall ;;
   -h)
      echo -e "$MSG"
      ;;
   -l)
      echo -e "$VD#############[ LISTA DE APPS ]##############"
      echo -e "$CC $LISTAPPS"
      echo -e "$VD############################################"
      ;;
   -r)
      removeapp ;;
   --removeall)
      removeall ;;
   -v)
      echo -e $VS
      ;;
   *)
      echo -e "$CC  VERIFIQUE O MODO DE USO!"
      echo -e "$VD  removeapps -h"
      ;;
esac

echo

#=[I.G.W.T]==========
