#!/bin/bash

fun_bar() {
    comando[0]="$1"
    comando[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${comando[0]} >/dev/null 2>&1
        ${comando[1]} >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -e "\033[1;31m---------------------------------------------------\033[1;37m"
    echo -ne "${col7}    ESPERE..\033[1;35m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[1;34m#"
            sleep 0.2s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "${col5}"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "\033[1;37m    ESPERE POR FAVOR...\033[1;35m["
    done
    echo -e "\033[1;35m]\033[1;37m -\033[1;32m INSTALADO !\033[1;37m"
    tput cnorm
    echo -e "\033[1;31m---------------------------------------------------\033[1;37m"
}

clear && clear
echo -e "\033[1;31m———————————————————————————————————————————————————\033[1;37m"
echo -e "\033[1;32m              WS + SSL | 2024 "
echo -e "\033[1;31m———————————————————————————————————————————————————\033[1;37m"
echo -e "\033[1;36m              SCRIPT AUTOCONFIGURACIÓN "
echo -e "\033[1;31m———————————————————————————————————————————————————\033[1;37m"
echo -e "\033[1;37mRequisito: Puertos libres, 80 y 443"
echo
echo -e "\033[1;33mVerificando estado de los puertos..."

# Verificar si los puertos 80 y 443 están en uso
ssl_port=$(lsof -i :443)
py_port=$(lsof -i :80)

if [[ -z "$ssl_port" ]] && [[ -z "$py_port" ]]; then
    echo -e "\033[1;33mPuertos libres. Activando SSL y Python..."
    echo -e "\033[1;33m                 INSTALANDO SSL... "

    inst_ssl() {
        apt-get install stunnel4 -y
        echo -e "client = no\n[SSL]\ncert = /etc/stunnel/stunnel.pem\naccept = 443 \nconnect = 127.0.0.1:80" >/etc/stunnel/stunnel.conf
        openssl genrsa -out stunnel.key 2048 >/dev/null 2>&1
        (
            echo ""
            echo ""
            echo ""
            echo ""
            echo ""
            echo ""
            echo "@cloudflare"
        ) | openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt
        cat stunnel.crt stunnel.key >stunnel.pem
        mv stunnel.pem /etc/stunnel/
        sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
        service stunnel4 restart
        rm -rf /etc/ger-frm/stunnel.crt
        rm -rf /etc/ger-frm/stunnel.key
        rm -rf /root/stunnel.crt
        rm -rf /root/stunnel.key
    }

    fun_bar 'inst_ssl'

    echo -e "\033[1;33m                 CONFIGURANDO PYTHON... "

    inst_py() {
        apt install python -y
        apt install screen -y

        pt=$(netstat -nplt | grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)

        cat <<EOF >proxy.py
# Código del proxy aquí...
EOF

        screen -dmS pythonwe python proxy.py -p 80 &
    }

    fun_bar 'inst_py'
    rm -rf proxy.py
    echo -e "             SSL + PYTHON Instalado"
else
    echo -e "\033[1;33mLos puertos 80 y/o 443 están en uso. Cerrando puertos..."

    # Cerrar puertos SSL y Python
    if [[ -n "$ssl_port" ]]; then
        echo -e "\033[1;31mCerrando puerto SSL (443)..."
        pkill -f stunnel
    fi

    if [[ -n "$py_port" ]]; then
        echo -e "\033[1;31mCerrando puerto Python (80)..."
        pkill -f python
    fi
fi

echo -e "\033[1;31m———————————————————————————————————————————————————\033[1;37m"
