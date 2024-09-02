#!/bin/bash
FECHA=$(date +"%Y-%m-%d")
cor1='\033[1;31m'
cor2='\033[0;34m'
cor3='\033[1;35m'
clear
scor='\033[0m'
echo -e "\E[44;1;37m       ELEGIR UNA OPCION      \E[0m"
echo -e "\033[1;32m    1: INSTALAR git "
echo -e "             2: CLONAR git Wondershare"
echo -e "        3: Crear Carpeta Wondershaper"
echo -e "         4: Instalar Wondershaper "
echo -e "         5: ACTIVAR eth0"
echo  -e "        6: Velocidad 1mb max"
echo -e  "      7: Velocidad  2mb max"
echo -e  "      8: Velocidad  4mb max"
echo -e  "      9: PROBAR VELOCIDAD"
echo  -e "       10: APAGAR Wondershaper"
echo -e  "       11: Verificar Wondershaper \e[m"

#leemos del teclado sentado
read n

                case $n in
        1) apt install git ;;
        2) git clone https://github.com/magnific0/wondershaper.git;;
        3) cd wondershaper ;; 
        4) apt install wondershaper ;; 
        5) wondershaper -a eth0 -d 2500 -u 2500  ;; 
        6) wondershaper eth0 4000 2000 ;; 
        7) wondershaper eth0 7000 2000 ;; 
        8) wondershaper eth0 12000 3000 ;; 
        9) speedtest 
echo -ne "\n\033[1;31mEnter  \033[1;33m para volver al   \033[1;32mMENU!\033[0m"; read
;; 
         10) wondershaper clean eth0 ;; 
        11) which wondershaper 
               sleep 4  ;;
        *) echo "Opción incorrecta";;
esac