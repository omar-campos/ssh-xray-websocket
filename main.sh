#!/bin/bash
clear
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "        SSH XRAY-WEBSOCKET - INSTALADOR"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Verificar root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este instalador debe ejecutarse como root."
    exit 1
fi

# Ubicación base de los scripts
BASE_DIR="/etc/sshxray"
mkdir -p $BASE_DIR
cd $BASE_DIR

# Descargar todos los scripts desde tu GitHub
REPO="https://raw.githubusercontent.com/Omar-campos/ssh-xray-websocket/main"

echo "Descargando archivos..."
for file in tools.sh certificate.sh webserver.sh badvpn.sh dropbear.sh websocket.sh ghostray.sh \
            addssh.sh changedomain.sh deletessh.sh listusers.sh renewcertificate.sh restartservices.sh \
            sshlogin.sh addtrojan.sh addvless.sh addvmess.sh block_site_trojan.sh block_site_vless.sh \
            block_site_vmess.sh bot.sh changebanner.sh checkbandwith.sh checkconfigtrojan.sh \
            checkconfigvless.sh checkconfigvmess.sh checkuserlogintrojan.py checkuserloginvless.py \
            checkuserloginvmess.py deletetrojan.sh deletevless.sh deletevmess.sh listblockeddomains.sh \
            renewtrojan.sh renewvless.sh renewvmess.sh serviceactivities.sh SSH-MENU.sh \
            systemstatus.sh trojanmenu.sh vlessmenu.sh vmessmenu.sh flags.sh webserver.sh \
            not_found.html
do
    wget -q -O "$file" "$REPO/$file"
    chmod +x "$file"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "        CONFIGURACIÓN INICIAL DE DOMINIO"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo ""
read -p "Ingresa tu dominio manualmente: " DOMAIN
echo "$DOMAIN" > /etc/domain

echo ""
echo "Dominio configurado: $DOMAIN"
sleep 1

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "     INICIANDO INSTALACIÓN DE SERVICIOS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -e "\n→ Ejecutando tools.sh..."
bash tools.sh

echo -e "\n→ Configurando certificados..."
bash certificate.sh

echo -e "\n→ Instalando webserver..."
bash webserver.sh

echo -e "\n→ Instalando BadVPN..."
bash badvpn.sh

echo -e "\n→ Instalando Dropbear..."
bash dropbear.sh

echo -e "\n→ Instalando WebSocket..."
bash websocket.sh

echo -e "\n→ Instalando Ghostray/Xray..."
bash ghostray.sh

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "    INSTALACIÓN COMPLETA - SSH XRAY-WEBSOCKET"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Para abrir el menú usa:  SSH-MENU"
echo ""
exit
