#!/bin/bash
#Autor: Eudes Paz (eudespaz@live.com)
#Script para procurar as filiais
#SETOR TI NORDESTE 1 

# Historico
# ---------
#
# Modificado e Customizado por: João Augusto (joaoaugustosb@gmail.com)
# Data: 27/12/2017
# 
# Adicionado o dialog ao Script
# Planilha de Domingos Trabalhados 
# Dados e Contatos do Técnicos
# IP dos Servidores de Armazenamento e Arquivos
#
# Historico
# ---------
#
# Data: 18/04/2018
#
# Atualização de Dados
#
#
#
#
#
# ARQUIVOS E LOGs
#----------------------------------------------------------------------------------------------------------------------------------------------------------

DATABASEFL="/home/script/arquivos/Filiais.txt"
DBDOMINGO="/home/script/arquivos/domingos"
LOG="/home/script/arquivos/arquivos.log"
DBFUNCIONARIO="/home/script/arquivos/domingosFuncionarios"

# VERIFICA SE OS ARQUIVOS EXISTEM
#-----------------------------------------------------------------------------------------------------------------------------------------------------------

clear


if [ -e $DATABASEFL ]
then
   echo "INFO $( date "+%d/%m/%y %X" ) - ARQUIVO "$DATABASEFL" FOI VERIFICADO E O MESMO EXISTE EM: $( pwd  ) !!! " >> $LOG
else
   echo "INFO $( date "+%d/%m/%y %X" ) - ARQUIVO "$DATABASEFL" FOI APAGADO OU NAO EXISTE FAVOR VERIFICAR! " >> $LOG
fi


if [ -e $DBDOMINGO ]
then
   echo "INFO $( date "+%d/%m/%y %X" ) - ARQUIVO "$DBDOMINGO" FOI VERIFICADO E O MESMO EXISTE EM: $( pwd  ) !!! " >> $LOG
else
   echo "INFO $( date "+%d/%m/%y %X" ) - ARQUIVO "$DBDOMINGO" FOI APAGADO OU NAO EXITE FAVOR VERIFICAR! " >> $LOG
fi


if [ -e $DBFUNCIONARIO ]
then
   echo "INFO $( date "+%d/%m/%y %X" ) - ARQUIVO "$DBFUNCIONARIO" FOI VERIFICADO E O MESMO EXISTE EM: $( pwd  ) !!! " >> $LOG
else
   echo "INFO $( date "+%d/%m/%y %X" ) - ARQUIVO "$DBFUNCIONARIO" FOI APAGADO OU NAO EXITE FAVOR VERIFICAR! " >> $LOG
fi

#
# COMANDOS
#-----------------------------------------------------------------------------------------------------------------------------------------------------------

IFCONFIG=$( which ifconfig )
ETHTOOL=$( which ethtool )

# VARIAVEIS
#-----------------------------------------------------------------------------------------------------------------------------------------------------------

export MEUIP=$( $IFCONFIG enp4s0 | sed -n '/inet end/{ s/.*end\.: \([0-9.]\+\).*/\1/p }' )
export NOMEMAQUINA=$( hostname )
export VERSAO="201804181600"
export NUMEROMAQUINA=$( echo $MEUIP | cut -f4 -d"." )

# MENSAGENS
#-----------------------------------------------------------------------------------------------------------------------------------------------------------

CABECALHO=" RN COMERCIO VAREJISTA S.A.| SETOR DE T.I NE1 | LOCALIZADOR DE FILIAIS | VERSAO: $VERSAO | IP: $MEUIP  | EXECUTANDO EM: $NOMEMAQUINA $( date "+%d/%m/%y %X" )"
TITULO="LOCALIZADOR DE FILIAIS"
MODULO="DADOS DA FILIAL"
MODULO1="CONSULTA DE REGIAO"
MODULOFUNC="DOMINGOS TRABALHADOS POR FUNCIONARIO"

# CONSULTAS POR REGIÃO
#-----------------------------------------------------------------------------------------------------------------------------------------------------------


consultaregiao() {


while :
        do
            PESQUISAREG=$( dialog --stdout --backtitle "$CABECALHO" --title "$MODULO1" --ok-label "Abrir" --nocancel --menu "\nESCOLHA UMA OPCAO :"  0 0 0    \
                                1 "ALAGOAS"                                                                           \
                                2 "BAHIA"                                                                             \
                                3 "CEARA"                                                                             \
                                4 "PARAIBA"                                                                           \
                                5 "PERNAMBUCO"                                                                        \
                                6 "RIO GRANDE DO NORTE"                                                               \
                                7 "SERGIPE"                                                                           \
                                0 "VOLTAR" )

            

                case "$PESQUISAREG" in
                    1) consulta_al           ;;
                    2) consulta_ba           ;;
                    3) consulta_ce           ;;
                    4) consulta_pb           ;;
                    5) consulta_pe           ;;
                    6) consulta_rn           ;;
                    7) consulta_se           ;;
                    0) break                 ;;
                esac
done

}

consulta_al() {

AL="LOJAS DE ALAGOAS"
dialog --backtitle "$CABECALHO" --title "$AL" --textbox /home/script/Estados/AL 30 80
}

consulta_ba() {

BA="LOJAS DA BAHIA"
dialog --backtitle "$CABECALHO" --title "$BA" --textbox /home/script/Estados/BA 30 80
}

consulta_ce() {

CE="LOJAS DO CEARA"
dialog --backtitle "$CABECALHO" --title "$CE" --textbox /home/script/Estados/CE 30 80
}

consulta_pb() {

PB="LOJAS DA PARAIBA"
dialog --backtitle "$CABECALHO" --title "$PB" --textbox /home/script/Estados/PB 30 80
}

consulta_pe() {

PE="LOJAS DE PERNAMBUCO"
dialog --backtitle "$CABECALHO" --title "$PE" --textbox /home/script/Estados/PE 30 80
}

consulta_rn() {

RN="LOJAS DO RIO GRANDE DO NORTE"
dialog --backtitle "$CABECALHO" --title "$RN" --textbox /home/script/Estados/RN 30 80
}

consulta_se() {

SE="LOJAS DE SERGIPE"
dialog --backtitle "$CABECALHO" --title "$SE" --textbox /home/script/Estados/SE 30 80
}

# CONSULTA POR FILIAL "EM TESTE"
#------------------------------------------------------------------------------------------------------------------------------------------------
#
#consulta_filial()
#{
#MODULO3="CONSULTA DE FILIAL"
#BUSCA=$( dialog --stdout --backtitle "$CABECALHO" --inputbox "INFORME O NUMERO DA FILIAL:\nEX:9075, 4091, 6357, 192 " 8 45 )
#cat $DATABASEFL | grep -i $BUSCA > /home/script/arquivos/buscafilial.txt
#if [ $? -eq 0 ]
#then
#   CLIENTE=$( cat "/home/script/arquivos/buscafilial.txt" ) 
#   dialog --backtitle "$CABECALHO" --title "$MODULO3" --msgbox "\n$CLIENTE " 16 30
#else
#   dialog --backtitle "$CABECALHO" --title "$MODULO3" --msgbox "\n       FILIAL $BUSCA NAO ENCONTRADA OU NAO EXISTE!" 8 70
#
#fi
#
#}
#
# CONSULTA POR FILIAL
#---------------------------------------------------------------------------------------------------------------------------------------------------

consultafilial() {

MODULO="CONSULTA DE FILIAL"
BUSCAFIL=$( dialog --stdout --backtitle "$CABECALHO" --ok-label "Procurar" --nocancel --inputbox "INFORME O NUMERO DA FILIAL : " 8 45 )
   case "$BUSCAFIL" in
	

	9105) ce1 ;;
	9015) pb1 ;;
	9077) funcaoA ;;
	9063) funcaoB ;;
	9044) funcaoC ;;
	4352) funcaoD ;;
	9032) funcaoE ;;
	4227) funcaoF ;;
	9133) funcaoG ;;
	9047) funcaoH ;;
	9135) funcaoI ;;
	9048) funcaoJ ;;
	9040) funcaoL ;;
#	4175) funcaoM ;;
	4345) funcaoN ;;
	9012) funcaoO ;;
	4091) funcaoP ;;
	4273) funcaoQ ;;
	9114) funcaoR ;;
	4237) funcaoAA ;;
	9122) funcaoS ;;
	9009) funcaoT ;;
	9124) funcaoU ;;
	4286) funcaoV ;;
	9071) funcaoX ;;
	9127) funcaoZ ;;
	9116) funcaobb ;;
	4226) funcaocc ;;
	4265) funcaodd ;;
	9003) funcaoee ;;
#	4272) funcaoff ;;
	9031) funcaogg ;;
	4189) funcaohh ;;
#	9011) funcaoii ;;
	9020) funcaojj ;;
	9061) funcaoll ;;
	9137) funcaomm ;;
	9030) funcaonn ;;
	9037) funcaooo ;;
	9049) funcaopp ;;
	9128) funcaoqq ;;
	9103) funcaorr ;;
	9106) funcaoss ;;
	9055) funcaott ;;
	4274) funcaouu ;;
	9134) funcaovv ;;
	9004) funcaoxx ;;
	9014) funcaozz ;;
	9147) funcaoaaa ;;
	9148) funcaobbb ;;
	4182) funcaoccc ;;
	4078) funcaoddd ;;
	4192) funcaoeee ;;
	9022) funcaofff ;;
	9126) funcaoggg ;;
	4342) funcaohhh ;;
	4076) funcaoiii ;;
	9027) funcaojjj ;;
	9121) funcaolll ;;
	9074) funcaonnn ;;
	4290) funcaommm ;;
	9007) funcaoooo ;;
	9082) funcaoppp ;;
	4228) funcaoqqq ;;
	9054) funcaorrr ;;
	9016) funcaosss ;;
#	4208) funcaottt ;;
	4137) funcaouuu ;;
	4156) funcaozzz ;;
	4238) eudesA ;;
	9087) eudesB ;;
#	4104) eudesC ;;
	4225) eudesD ;;
	9045) eudesE ;;
	9039) eudesF ;;
	259) eudesG ;;
	9080) eudesh ;;
	9064) eudesi ;;
	4179) eudesj ;;
#	4241) eudesl ;;
	4281) eudesm ;;
	9139) eudesn ;;
#	4219) eudeso ;;
	9024) eudesp ;;
	9072) eudesq ;;
	9033) abreu ;;
	4116) abreuB ;;
#	4288) abreuC ;;
	9120) igara ;;
	4117) pauli ;;
#	9084) pauliB ;;
	9025) pauliC ;;
	9065) pauliD ;;
	9028) recife ;;
#	9079) recifeB ;;
	9062) al ;;
	4100) alB ;;
	4102) alC ;;
	4324) alD ;;
	163) alE ;;
	192) alF ;;
	191) alG ;;
	4351) alH ;;
	9058) alI ;;
	9059) alJ ;;
	4109) rn ;;
	9053) rnA ;;
	4172) rnB ;;
	4178) rnC ;;	
	4206) rnD ;;
	4300) rnE ;;
	4221) rnF ;;
	4246) rnG ;;
	4235) rnH ;;
	4332) rnI ;;
	4264) rnJ ;;
	4334) rnL ;;
	4267) rnM ;;
	4195) pb ;;
	4338) pbA ;;
	4216) pbB ;;
	4170) pbC ;;
	9013) pbD ;;
#	9038) pbE ;;
	9046) pbF ;;
	9036) pbG ;;
#	9153) pbH ;;
	4177) ce ;;
	9102) ceb ;;
	9110) cec ;;
	9118) ced ;;
	9158) cee ;;
	4259) cef ;;
	9159) ceg ;;
	4203) ceh ;;
	4187) cei ;;
	9108) cej ;;
	9146) cel ;;
	4304) cem ;;
	4214) cen ;;
	4217) ceo ;;
	4276) cep ;;
	4331) ceq ;;
	9107) cer ;;
	4255) ces ;;
	4361) cet ;;
	9109) ceu ;;
	9160) cev ;;
	4283) cex ;;
	4333) cez ;;
	4073) AL ;;
	4224) ALA ;;
	9097) ALB ;; 
	9162) ALC ;;
	4051) ALD ;;
	4110) ALE ;;
	9100) ALF ;;
	4046) ALG ;;
	4079) ALI ;;
	163) ALH ;;
	191) ALJ ;;
	192) ALL ;;
	219) PET ;;
	229) PETR ;;
	087) BA ;;
	090) BAA ;;
	091) BAB ;;
	092) BAC ;;
	093) BAD ;;
	095) BAE ;;
	096) BAF ;;
	098) BAH ;;
	104) BAI ;;
	105) BAJ ;;
	108) BAL ;;
	111) BAG ;;
	112) BAM ;;
	113) BAN ;;
	118) BAO ;;
	119) BAP ;;
	126) BAQ ;;
	128) BAR ;;
	130) BAS ;;
	132) BAT ;;
	134) BAU ;;
	141) BAV ;;
	142) BAX ;;
	185) BAZ ;;
	302) BA1 ;;
	4002) BA2 ;;
	4004) BA3 ;;
	4008) BA4 ;;
	4013) BA5 ;;
	4029) BA6 ;;
	4032) BA7 ;;
	4035) BA8 ;;
	4040) BA9 ;;
	4042) BA10 ;;
	4045) BA11 ;;
	4053) BA12 ;;
	4056) BA13 ;;
	4058) BA14 ;;
	4060) BA15 ;;
	4061) BA16 ;;
	4062) BA17 ;;
	4063) BA18 ;;
	4066) BA19 ;;
	4067) BA20 ;;
	4077) BA21 ;;
	4080) BA22 ;;
	4082) BA23 ;;
	4083) BA24 ;;
	4096) BA25 ;;
	4097) BA26 ;;
	4105) BA27 ;;
	4106) BA28 ;;
	4120) BA29 ;;
	4124) BA30 ;;
	4132) BA31 ;;
	4135) BA32 ;;
	4143) BA33 ;;
	4145) BA34 ;;
	4146) BA35 ;;
	4147) BA36 ;;
	4156) BA37 ;;
	4163) BA38 ;;
	4164) BA39 ;;
	4165) BA40 ;;
	4185) BA41 ;;
	4188) BA42 ;;
	4193) BA43 ;;
	4196) BA44 ;;
	4199) BA45 ;;
	4211) BA46 ;;
	4256) BA47 ;;
	4257) BA48 ;;
	4279) BA49 ;;
	4289) BA50 ;;
	4293) BA51 ;;
	4294) BA52 ;;
	4296) BA53 ;;
	4306) BA54 ;;
	4313) BA55 ;;
	4315) BA56 ;;
	4323) BA57 ;;
	4353) BA58 ;;
	4010) BA59 ;;
	9075) pe1 ;;
	6198) pi ;;	
	6201) pi2 ;;
	6214) pi3 ;;
	6237) pi4 ;;
	6351) pi5 ;;
	6352) pi6 ;;
	6356) pi7 ;;
	6357) pi8 ;;
	4108) pe10 ;;
	*) comandoIN ;;
	
esac
}

pe10(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4108\nCIDADE: Petrolina\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}

pi8(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 6357\nCIDADE: Teresina\nESTADO: PI\n" 16 30 
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
	case $RETORNO in
	0) consultafilial ;;
	1) continue	  ;;

esac

}
pi7(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 6356\nCIDADE: Piripiri\nESTADO: PI\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pi6(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 6352\nCIDADE: Teresina\nESTADO: PI\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pi5(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 6351\nCIDADE: Teresina\nESTADO: PI\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pi4(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 6337\nCIDADE: Teresina\nESTADO: PI\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pi3(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 6214\nCIDADE: Parnaiba\nESTADO: PI\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pi2(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 6201\nCIDADE: Teresina\nESTADO: PI\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pi(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 6198\nCIDADE: Teresina\nESTADO: PI\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pe1(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: CD\nFILIAL: 9075\nCIDADE: Paulista\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pb1(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: CDA\nFILIAL: 9015\nCIDADE: João Pessoa\nESTADO: PB\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ce1(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: CDA\nFILIAL: 9105\nCIDADE: Fortaleza\nESTADO: CE\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}

BA59(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4010\nCIDADE: Lauro de Freitas\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}

BA58(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4353\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}

BA57(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4323\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}

BA56(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4315\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}	
BA55(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4313\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA54(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4306\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA53(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4296\nCIDADE: Amargosa\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA52(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4294\nCIDADE: Jaguaquara\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA51(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4293\nCIDADE: Gandu\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA50(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4289\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA49(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4279\nCIDADE: Porto Seguro\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA48(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4257\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA47(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4256\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA46(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4211\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA45(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4199\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA44(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4196\nCIDADE: Vitoria da Conquista\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA43(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4193\nCIDADE: Catu\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA42(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4188\nCIDADE: Itapetinga\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA41(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4185\nCIDADE: Itaberaba\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA40(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4165\nCIDADE: Camacari\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA39(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4164\nCIDADE: Candeias\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA38(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4163\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA37(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4156\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA36(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4147\nCIDADE: Senhor do Bonfim\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA35(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4146\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA34(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4145\nCIDADE: Ilheus\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA33(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4143\nCIDADE: Itabuna\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA32(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4135\nCIDADE: Feira de Santana\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA31(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4132\nCIDADE: Feira de Santana\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA30(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4124\nCIDADE: Paulo Afonso\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA29(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4120\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA28(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4106\nCIDADE: Santo Antonio de Jesus\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA27(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4105\nCIDADE: Ilheus\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA26(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4097\nCIDADE: Bom Jesus da Lapa\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA25(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4096\nCIDADE: Santo Amaro\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA24(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4083\nCIDADE: Itamaraju\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA23(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4082\nCIDADE: Irece\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}	
BA22(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4080\nCIDADE: Eunapolis\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA21(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4077\nCIDADE: Guanambi\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA20(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4067\nCIDADE: São Sebastião do Passe\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA19(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4066\nCIDADE: Ribeira do Pombal\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA18(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4063\nCIDADE: Salvador\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA17(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4062\nCIDADE: Conceição do Coite\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA16(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4061\nCIDADE: Juazeiro\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA15(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4060\nCIDADE: Alagoinhas\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA14(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4058\nCIDADE: Serrinha\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA13(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4056\nCIDADE: Senhor do Bonfim\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA12(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4053\nCIDADE: Camacari\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA11(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4045\nCIDADE: Ipiau\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA10(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4042\nCIDADE: Brumado\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA9(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4040\nCIDADE: Jacobina\nESTADO: BA\n" 16 30        
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA8(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4035\nCIDADE: Ubaitaba\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA7(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4032\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA6(){
	
dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4029\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA5(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4013\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA4(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4008\nCIDADE: Jequie\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA3(){
	
dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4004\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA2(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4002\nCIDADE: Vitoria da Conquista\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA1(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 302\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAZ(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 185\nCIDADE: Juazeiro\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAX(){
	
dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 142\nCIDADE: Dias D Avila\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAV(){
	
dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 141\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAU(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 134\nCIDADE: Itabuna\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAT(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 132\nCIDADE: Cruz das Almas\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAS(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 130\nCIDADE: Feira de Santana\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAR(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 128\nCIDADE: Valenca\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAQ(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 126\nCIDADE: Candeias\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAP(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 119\nCIDADE: Teixeira de Freitas\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAO(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 118\nCIDADE: Ilheus\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAN(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 113\nCIDADE: Feira de Santana\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAM(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 112\nCIDADE: Feira de Santana\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAG(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 111\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAL(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 108\nCIDADE: Simões Filho\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAJ(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 105\nCIDADE: Santo Antonio de Jesus\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAI(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 104\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAH(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 098\nCIDADE: Vitoria da Conquista\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAF(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 096\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAE(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 095\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAD(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 093\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAC(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 092\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAB(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 091\nCIDADE: Camacari\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BAA(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 090\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
BA(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 087\nCIDADE: Salvador\nESTADO: BA\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ALL(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 192\nCIDADE: Maceio\nESTADO: AL\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ALJ(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 191\nCIDADE: Maceio\nESTADO: AL\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ALH(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 163\nCIDADE: Maceio\nESTADO: AL\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
PETR(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 229\nCIDADE: Petrolina\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
PET(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 219\nCIDADE: Petrolina\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac	
}
ALI(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4079\nCIDADE: São Miguel dos Campos\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ALG(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4046\nCIDADE: Penedo\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ALF(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9100 - Santana do Ipanema I\nCIDADE: Santana do Ipanema\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 15" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ALE(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4110\nCIDADE: Santana do Ipanema\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 15" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ALD(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4051\nCIDADE: Palmeiras do Indios\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 15" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac	
}
ALC(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9162 - Arapiraca III\nCIDADE: Arapiraca\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ALB(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9097 - Arapiraca II\nCIDADE: Arapiraca\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ALA(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4224\nCIDADE: Arapiraca\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
AL(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4073\nCIDADE: Arapiraca\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cez(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4333\nCIDADE: Itapipoca\nESTADO: CE\nLOCALIZACAO: Interior\nREGIONAL: 17" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cex(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4283\nCIDADE: Sobral\nESTADO: CE\nLOCALIZACAO: Interior\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cev(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9160 - Maracanau III\nCIDADE: Maracanau\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ceu(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9109 - Shopping Via Sul\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cet(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4361 Fortaleza IX\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ces(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4255\nCIDADE: Agua Fria\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cer(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9107 - Shopping Maracanau\nCIDADE: Maracanau\nESTADO: CE\nLOCALIZACAO: Interior\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ceq(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4331\nCIDADE: Pacajus\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cep(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4276 - Fortaleza IV\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Interior\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ceo(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4217 - Fortaleza II\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Interior\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cen(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4214 - Fortaleza I\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Interior\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cem(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4304\nCIDADE: Caucaia\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cel(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9146 - Noth Shop Joquei\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cej(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9108 - Noth Shopping\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cei(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4187 - Noth Shopping\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ceh(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4203 - Shopping Iguatemi Fortaleza\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ceg(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9159 - Messejana\nCIDADE: Messejana\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cef(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4259 - Messejana\nCIDADE: Messejana\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cee(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9158 - Fortaleza X\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ced(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9118 - Montese\nCIDADE: Montese\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
cec(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9110 - Fortaleza III\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ceb(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9102 - Fortaleza II\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesi(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9064 - Agua Fria\nCIDADE: Olinda\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
ce(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4177\nCIDADE: Fortaleza\nESTADO: CE\nLOCALIZACAO: Capital\nREGIONAL: 17" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pbG(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9036 - Mangabeira\nCIDADE: Mangabeira\nESTADO: PB\nLOCALIZACAO: Capital\nREGIONAL: 24\nCELULAR: 81 98582-7403\nFIXO: 83 3015-5400 / 3015-5403\nRAMAL: 58110361 / 58110362" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pbF(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9046 - Lagoa\nCIDADE: Lagoa\nESTADO: PB\nLOCALIZACAO: Capital\nREGIONAL: 24\nCELULAR: 81 98582-7413\nFIXO: 83 3022-6261\nRAMAL: 58110461 / 58110462" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pbE(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9038 - Shopping Manaira\nCIDADE: Joao Pessoa\nESTADO: PB\nLOCALIZACAO: Capital\nREGIONAL: 24\nCELULAR: 81 98582-7410\nFIXO: 83 2106-6184\nRAMAL: 58110381 / 58110382\nSTATUS: ATIVIDADES ENCERRADAS" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pbD(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9013 - João Pessoa I\nCIDADE: João Pessoa\nESTADO: PB\nLOCALIZACAO: Capital\nREGIONAL: 24\nCELULAR: 81 98582-6563\nFIXO: 83\nRAMAL: 58110131 / 58110132" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pbC(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4170 - Joao Pessoa III\nCIDADE: João Pessoa\nESTADO: PB\nLOCALIZACAO: Capital\nREGIONAL: 24\nCELULAR: 83 98857-4038\nFIXO: 83 3214-3410 / 3015-5403\nRAMAL: 57111701 / 57111702" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pbB(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4216 - Joao Pessoa IV\nCIDADE: Joao Pessoa\nESTADO: PB\nLOCALIZACAO: Capital\nREGIONAL: 24\nCELULAR: 83 98853-5630\nFiXO: 83\nRAMAL: 57112161 / 57112162" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pbA(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4338 - Campina Grande III\nCIDADE: Campina Grande\nESTADO: PB\nLOCALIZACAO: Interior\nREGIONAL: 24\nCELULAR: 83\nFIXO: 83\nRAMAL: 5711" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pb(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4195 - Campina Grande II\nCIDADE: Campina Grande\nESTADO: PB\nLOCALIZACAO: Interior\nREGIONAL: 24\nCELULAR: 83 98856-9516\nFIXO: 83 3315-3114 / 3015-5403\nRAMAL: " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnM(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4267\nCIDADE: Acu\nESTADO: RN\nLOCALIZACAO: Interior\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnL(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4334\nCIDADE: Mossoro\nESTADO: RN\nLOCALIZACAO: Interior\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnJ(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4264\nCIDADE: Mossoro\nESTADO: RN\nLOCALIZACAO: Interior\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnI(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4332\nCIDADE: Parnamirim\nESTADO: RN\nLOCALIZACAO: Interior\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnH(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4235\nCIDADE: Parnamirim\nESTADO: RN\nLOCALIZACAO: Interior\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
rnG(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4246\nCIDADE: Igapo\nESTADO: RN\nLOCALIZACAO: Interior\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnF(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4221\nCIDADE: Natal\nESTADO: RN\nLOCALIZACAO: Interior\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnE(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4300\nCIDADE: Pontegi\nESTADO: RN\nLOCALIZACAO: Interior\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnD(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4206\nCIDADE: Natal\nESTADO: RN\nLOCALIZACAO: Capital\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
} 
rnC(){
	
dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4178\nCIDADE: Natal\nESTADO: RN\nLOCALIZACAO: Capital\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnB(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4172\nCIDADE: Natal\nESTADO: RN\nLOCALIZACAO: Capital\nREGIONAL: 22" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rnA(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9053\nCIDADE: Alecrim\nESTADO: RN\nLOCALIZACAO: Capital\nREGIONAL: 22\nCELULAR: 84\nFIXO: 84\nRAMAL: 58110531 / 58110532" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
rn(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4109\nCIDADE: Alecrim\nESTADO: RN\nLOCALIZACAO: Capital\nREGIONAL: 22\nCELULAR: 84\nFIXO: 84\nRAMAL: 57111091 / 58111092" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
alJ(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9059\nCIDADE: Maceio\nESTADO: AL\nLOCALIZACAO: Capital\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
alI(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9058\nCIDADE: Maceio\nESTADO: AL\nLOCALIZACAO: Capital\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
alH(){
dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4351\nCIDADE: Maceio\nESTADO: AL\nLOCALIZACAO: Capital\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
alG(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 191\nCIDADE: Maceio\nESTADO: AL\nLOCALIZACAO: Capital\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
alF(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 192\nCIDADE: Maceio\nESTADO: AL\nLOCALIZACAO: Capital\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
alE(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 163 - MACEIO SHOPPING\nCIDADE: Maceio\nESTADO: AL\nLOCALIZACAO: Capital\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
alD(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4324 - SHOPPING PATIO MACEIO\nCIDADE: Maceio\nESTADO: AL\nLOCALIZACAO: Capital\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
alC(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4102\nCIDADE: Rio Largo\nESTADO: AL\nLOCALIZACAO: Capital\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
alB(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4100\nCIDADE: Maceio\nESTADO: AL\nLOCALIZACAO: Capital\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
al(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9062\nCIDADE: União dos Palmares\nESTADO: AL\nLOCALIZACAO: Interior\nREGIONAL: 16" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
recifeB(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9079 - Shopping Rio Mar\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21\nCELULAR: 81 98582- \nFIXO: 81\nRAMAL: 58110791 / 58110792 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac	
}
recife(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9028 - Shopping Tacaruna\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21\nCELULAR: 81 98582- \nFIXO: 81\nRAMAL: 58110281 / 58110282 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pauliD(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9065 - North Way Shopping\nCIDADE: Paulista\nESTADO: PE\nLOCALIZACAO: RMR\nREGIONAL: 21\nCELULAR: 81 98582- \nFIXO: 81\nRAMAL: 58110651 / 58110652 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pauliC(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9025 - Paulista I\nCIDADE: Paulista\nESTADO: PE\nLOCALIZACAO: RMR\nREGIONAL: 21\nCELULAR: 81 98582- \nFIXO: 81\nRAMAL: 58110251 / 58110252 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
pauli(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4117 - Paulista \nCIDADE: Paulista\nESTADO: PE\nLOCALIZACAO: RMR\nREGIONAL: 21\nCELULAR: 81 \nFIXO: 81\nRAMAL: 57111171 / 57111172 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
igara(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9120 - Igarassu \nCIDADE: Igarassu\nESTADO: PE\nLOCALIZACAO: RMR\nREGIONAL: 21\nCELULAR: 81 \nFIXO: 81\nRAMAL: 58111201 / 58111202 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
abreuC(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4288 (LOJA FECHADA)\nCIDADE: Abreu e Lima\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
abreuB(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4116\nCIDADE: Abreu e Lima\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
abreu(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9033\nCIDADE: Abreu e Lima\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesq(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9072 - Casa Amarela\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesp(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9024 - Casa Amarela\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudeso(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4219 - Encruzilhada\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21\nRAMAL: 57112191 / 57112192\n\nSTATUS: Encerrada as Atividades!" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesn(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9139 - Carmo\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 19" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesm(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4281\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 19" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesl(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4241\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 19" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesj(){
dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4179\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 19" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudes(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9064 - Agua Fria\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesh(){
dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9080 - Beberibe\nCIDADE: Olinda\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesG(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: CD\nFILIAL: 259 - Simoes Filho \nCIDADE: Simões Filho\nESTADO: BA\nLOCALIZACAO: INTERIOR\nCELULAR: 77 \nFIXO: 77\nRAMAL: " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac	
}
eudesF(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9039 - Beberibe\nCIDADE: Olinda\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesE(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9045 - Peixinhos\nCIDADE: Olinda\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesD(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4225 - Peixinhos\nCIDADE: Olinda\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesB(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9087\nCIDADE: Olinda\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 21" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
eudesA(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4238\nCIDADE: Patos\nESTADO: PB\nLOCALIZACAO: Interior\nREGIONAL: 21\nCELULAR: 83 98845-3890 \nFIXO: 83 3423-1548\nRAMAL: 57112381 / 57112382 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
funcaozzz(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4156\nCIDADE: Guarabira\nESTADO: PB\nLOCALIZACAO: Interior\nREGIONAL: 24\nCELULAR: \nFIXO:\nRAMAL: 57111561 / 57111562 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
}
funcaouuu(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4137\nCIDADE: Catole\nESTADO: PB\nLOCALIZACAO: Interior\nREGIONAL: 24\nCELULAR: 83 98855-3870 \nFIXO: 83 3337-6257\nRAMAL: 57111371 / 57111372 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaottt(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4208\nCIDADE: Campina Grande\nESTADO: PB\nLOCALIZACAO: Interior\nREGIONAL: 24\nCELULAR: 83 98853-7468 \nFIXO: 83 3310-9904\nRAMAL: 57112081 / 57112082 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaosss(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9016\nCIDADE: Campina Grande\nESTADO: PB\nLOCALIZACAO: Interior\nREGIONAL: 24\nCELULAR: 83 98582-6567 / 83 8714-7887 \nFIXO:\nRAMAL: 57110161 / 57110162 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaorrr(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9054\nCIDADE: Santa Cruz do Capibaribe\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL: 58110541 / 58110542 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoqqq(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4228\nCIDADE: Santa Cruz do Capibaribe\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL: 57112281 / 57112282 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoppp(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9082\nCIDADE: Surubim\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL:58110821 / 58110822 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoooo(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9007\nCIDADE: Surubim\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL:58110071 / 58110072 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaommm(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4290\nCIDADE: Surubim\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL:57112901 / 57112902 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaonnn(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9074\nCIDADE: Lajedo\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 20\nCELULAR: 81 \nFIXO: 81\nRAMAL: 58110741 / 58110742 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaolll(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9121\nCIDADE: Garanhuns\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 20\nCELULAR: 81 \nFIXO: 81\nRAMAL: 58111211 / 58111212 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaojjj(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9027\nCIDADE: Garanhuns\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 20\nCELULAR: 81 \nFIXO: 81\nRAMAL: 58110271 / 58110272 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoiii(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4076\nCIDADE: Garanhuns\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 20\nCELULAR: 81 \nFIXO: 81\nRAMAL: 57110761 / 57110762 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaohhh(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4342\nCIDADE: Caruaru\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL: 57113421 / 57113422 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoggg(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9126\nCIDADE: Caruaru\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL: 58111261 / 58111262 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaofff(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9022\nCIDADE: Caruaru\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL: 58110221 / 58110222 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoeee(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4192\nCIDADE: Caruaru\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL: 57111921 / 57111922 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoddd(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4078\nCIDADE: Caruaru\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 23\nCELULAR: 81 \nFIXO: 81\nRAMAL: 57110781 / 57110782 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoccc(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4182\nCIDADE: Juazeiro do Norte\nESTADO: CE\nLOCALIZACAO: Interior\nREGIONAL: 20\nCELULAR: 88 \nFIXO: 88\nRAMAL: 57111821 / 57111822 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaobbb(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9148\nCIDADE: Brejo Santo\nESTADO: CE\nLOCALIZACAO: Interior\nREGIONAL: 20\nCELULAR: 88 \nFIXO: 88\nRAMAL: 58111481 / 58111482 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoaaa(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9147\nCIDADE: Crato\nESTADO: CE\nLOCALIZACAO: Interior\nREGIONAL: 20\nCELULAR: 88 \nFIXO: 88\nRAMAL: 58111471 / 58111472 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaozz(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9014 - Palma II\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 19\nCELULAR: 81 \nFIXO: 81\nRAMAL: 58110141 / 58110142 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoxx(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9004 - Palma IV\nCIDADE: Recife\nESTADO: PE\nLOCALIZACAO: Capital\nREGIONAL: 19\nCELULAR: 81 \nFIXO: 81\nRAMAL: 58110041 / 58110042 " 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaovv(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9134\nCIDADE: Belo Jardim\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 20" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaouu(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4274\nCIDADE: Salgueiro\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 20" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaott(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9055\nCIDADE: Serra Talhada\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: 20" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoss(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9106\nCIDADE: Arcoverde\nESTADO: PE\nLOCALIZACAO: Interior\nREGIONAL: \nRAMAL: 58111061/ 58111062" 16 50
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaorr(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9103\nCIDADE: Pesqueira\nESTADO: PE\nLOCALIZACAO: Interior\nRAMAL: 58111031/ 58111032" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoqq(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9128\nCIDADE: Escada\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaopp(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9049\nCIDADE: Palmares\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaooo(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9037\nCIDADE: Barreiros\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaonn(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9030\nCIDADE: Camaragibe\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
        
}

funcaomm(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9137\nCIDADE: Goiana\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoll(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9061\nCIDADE: Goiana\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaojj(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9020\nCIDADE: Recife\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoii(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9011\nCIDADE: Vitória\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaohh(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4186\nCIDADE: Vitória\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaogg(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9031\nCIDADE: São Lourenço\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoff(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4272\nCIDADE: São Lourenço\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoee(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9003\nCIDADE: Camaragibe\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac    

}
funcaodd(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4265\nCIDADE: Camaragibe\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaocc(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4226\nCIDADE: Camaragibe\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
   
}

funcaobb(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9116\nCIDADE: Recife\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoZ(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9127\nCIDADE: Ipojuca\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoX(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9071 - Shopping Costa Dourada\nCIDADE: Cabo\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoV(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4286\nCIDADE: Cabo\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoU(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9124\nCIDADE: Cabo\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoT(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9009\nCIDADE: Cabo\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoS(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9122\nCIDADE: Moreno\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoAA(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4237\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoR(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9114\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoQ(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4273\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoP(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4091\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoO(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9012\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoN(){
	
dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4345\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoM(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4175\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoL(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9040\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoJ(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9048\nCIDADE: Bezerros\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoI(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9135\nCIDADE: Gravata\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoH(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9047\nCIDADE: limoeiro\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoG(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9133\nCIDADE: Paudalho\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoF(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4227\nCIDADE: Timbaúba\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}
funcaoE(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9032\nCIDADE: Carpina\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
       
}

funcaoD(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 4352\nCIDADE: Carpina\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoA(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9077\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac

}

funcaoB(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9063\nCIDADE: Jaboatão\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
	
}

funcaoC(){

dialog --backtitle "$CABECALHO" --title "$MODULO" --msgbox "TIPO: Loja\nFILIAL: 9044\nCIDADE: Recife\nESTADO: PE\n" 16 30
dialog --backtitle "$CABECALHO" --title "NOVA CONSULTA"  --yesno "\n\n       DESEJA REALIZAR NOVA CONSULTA?" 10 50
RETORNO=$?
        case $RETORNO in
        0) consultafilial ;;
        1) continue       ;;

esac
	
}

# DOMINGO TRABALHADO
#------------------------------------------------------------------------------------------------------------------------------------------------------

menudomingos(){

MENUDOMINGO="MENU DOMINGOS TRABALHADOS"

while :
              do
              MENUDOM=$( dialog --stdout --backtitle "$CABECALHO" --title "$MENUDOMINGO" --ok-label "Confirmar" --menu "\nESCOLHA UMA OPCAO ABAIXO:" 10 50 0         \
                                          1 "CONSULTAR GERAL"                                                                    \
                                          2 "CONSULTA POR MATRICULA"                                                             \
                                          3 "SEQUENCIA FERIADOS TRABALHADOS"                                                     \
                                          0 "VOLTAR" )

        [ $? -ne 0 ] && break

                                case $MENUDOM          in
                                1) domingogeral        ;;
                                2) domingos            ;;
                                3) feriados            ;;
                                0) break               ;;
                                *) comandoIN           ;;


                           esac

done

}

domingogeral(){

MODULOD="ESCALA DOMINGOS TRABALHADOS 2018"
dialog --backtitle "$CABECALHO" --title "$MODULOD" --ok-label "Voltar" --textbox /home/script/arquivos/domingos 40 110


}

domingos(){

MODULOC="DOMINGOS TRABALHADOS"
BUSCAFUNC=$( dialog --stdout --backtitle "$CABECALHO" --ok-label "Confirmar" --inputbox "INFORME A MATRICULA DO FUNCIONARIO : " 8 45 )
cat $DBFUNCIONARIO | grep -i $BUSCAFUNC > /home/script/arquivos/buscafuncionario.txt
if [ $? -eq 0 ]
then
   FUNCIONARIO=$( cat "/home/script/arquivos/buscafuncionario.txt" )
   dialog --backtitle "$CABECALHO" --title "$MODULOC" --msgbox "\n$FUNCIONARIO " 20 35
else
   dialog --backtitle "$CABECALHO" --title "$MODULOC" --ok-label "Voltar" --msgbox "\n      MATRICULA Nº $BUSCAFUNC NAO ENCONTRADO OU NAO EXISTE!" 8 70

fi

}

feriados(){

MODULOF="SEQUENCIA DE FERIADOS"
dialog --backtitle "$CABECALHO" --title "$MODULOF" --ok-label "Voltar" --msgbox "\n1 - AUGUSTO\n2 - EUDES\n3 - ANDERSON\n4 - MARIO\n5 - ALEX\n6 - ANGELO\n7 - BRENO\n8 - CRISTIANO" 15 30 


}

# DADOS DOS TECNICOS
#------------------------------------------------------------------------------------------------------------------------------------------------------

contatos(){

MODULOC="CONTATOS"
dialog --backtitle "$CABECALHO" --title "$MODULOC" --ok-label "Voltar" --textbox /home/script/arquivos/contatos 15 40

}


acessorestrito()
{
MODULO="DADOS DOS COLABORADORES"
MODULOIN="DADOS INVALIDOS"
SENHA=$( dialog --stdout --backtitle "$CABECALHO" --ok-label "Confirmar" --passwordbox "DIGITE A SENHA: " 0 0 )
   
    if [ $SENHA == "mumia" ]
      then
      dialog --backtitle "$CABECALHO" --title "$MODULO" --textbox /home/script/arquivos/dadosfuncionarios 20 60
    else
      dialog --backtitle "$CABECALHO" --title "  $MODULOIN" --ok-label "Voltar" --msgbox "\n\n     SENHA INCORRETA!" 10 30

fi

}

# IP's DOS SERVIDORES
#-----------------------------------------------------------------------------------------------------------------------------------------------------

servidores(){

MODULOS="IP's DOS SERVIDORES"
dialog --backtitle "$CABECALHO" --title "$MODULOS" --ok-label "Voltar" --msgbox "\n\n10.80.2.223 SERVER-TI\n\n10.80.2.225 SERVER-BACKUP\n\n10.80.2.226 DIGITALIZAÇÕES  " 15 40

}


# DADOS BANCARIOS
#------------------------------------------------------------------------------------------------------------------------------------------------------

dadosbancarios(){

MODULO="DADOS BANCARIOS"
dialog --backtitle "$CABECALHO" --title "$MODULO" --ok-label "Voltar" --textbox /home/script/arquivos/dadosbancarios 15 50

}

# MENSAGEM DE ERRO
#------------------------------------------------------------------------------------------------------------------------------------------------------

comandoIN(){

MODULOIN="  ERRO DE DADOS"
dialog --backtitle "$CABECALHO" --title " $MODULOIN" --ok-label "Voltar" --msgbox "\n\n         DADOS INVALIDOS" 10 40

}

# ENCERRA PROGRAMA
#--------------------------------------------------------------------------------------------------------------------------------------------------------

encerra()
{

dialog --backtitle "$CABECALHO" --title "ENCERRAR APLICACAO"  --yesno "\n\n    DESEJA REALMENTE ENCERRAR O PROGRAMA?" 10 50
if [ $? -eq 0 ]
then
  exit
else
  continue
fi

}

# MENU PRINCIPAL
#----------------------------------------------------------------------------------------------------------------------------------------------------------

while :
         do
         MENUPRINCIPAL=$( dialog --stdout --backtitle "$CABECALHO" --title "$TITULO" --ok-label "Confirmar" --nocancel --menu "\nESCOLHA UMA OPCAO ABAIXO:" 10 50 0         \
                                          1 "CONSULTAR FILIAL"                                                                   \
                                          2 "CONSULTA FILIAL POR REGIAO"                                                         \
                                          3 "FUNCIONARIOS X MATRICULA"                                                           \
                                          4 "DOMINGOS/FERIADOS TRABALHADOS"                                                      \
                                          5 "IP SERVIDORES"                                                                      \
                                          6 "DADOS BANCARIOS"                                                                    \
                                          7 "ACESSO RESTRITO"                                                                    \
                                          8 "INFORMACOES"                                                                        \
                                          0 "ENCERRAR" )

        [ $? -ne 0 ] && break

                                case $MENUPRINCIPAL    in
                                1) consultafilial      ;;
                                2) consultaregiao      ;;
                                3) contatos            ;;
                                4) menudomingos        ;;
                                5) servidores          ;;
                                6) dadosbancarios      ;;
                                7) acessorestrito      ;;
                                8) informacoes         ;;
                                0) encerra             ;;
                                *) comandoIN           ;;


                           esac

done
#-------------------------------------------------------------------------------------------------------------------------------------------------------------
