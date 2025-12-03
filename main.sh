#!/bin/bash
clear
echo "=========================================="
echo "     SSH + XRAY Websocket Installer"
echo "          By Omar Campos"
echo "=========================================="

REPO="https://raw.githubusercontent.com/Omar-campos/ssh-xray-websocket/main"

# -----------------------------------------
# 1. Actualizar sistema
# -----------------------------------------
echo "[+] Actualizando servidor..."
apt update -y && apt upgrade -y

apt install -y curl wget unzip python3 python3-pip socat cron jq

# -----------------------------------------
# 2. Crear directorio de instalación
# -----------------------------------------
INSTALL_DIR="/etc/sshxray"
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

echo "[+] Directorio listo: $INSTALL_DIR"

# -----------------------------------------
# 3. Lista de archivos del repositorio
# -----------------------------------------
FILES=(
tools.sh
certificate.sh
webserver.sh
badvpn.sh
dropbear.sh
websocket.sh
ghostray.sh
not_found.html
addssh.sh
changedomain.sh
deletessh.sh
listusers.sh
renewcertificate.sh
restartservices.sh
sshlogin.sh
addtrojan.sh
addvless.sh
addvmess.sh
block_site_trojan.sh
block_site_vless.sh
block_site_vmess.sh
bot.sh
changebanner.sh
checkbandwith.sh
checkconfigtrojan.sh
checkconfigvless.sh
checkconfigvmess.sh
checkuserlogintrojan.py
checkuserloginvless.py
checkuserloginvmess.py
deletetrojan.sh
deletevless.sh
deletevmess.sh
listblockeddomains.sh
renewtrojan.sh
renewvless.sh
renewvmess.sh
serviceactivities.sh
SSH-MENU.sh
systemstatus.sh
trojanmenu.sh
vlessmenu.sh
vmessmenu.sh
flags.sh
)

echo "[+] Descargando scripts desde GitHub..."

for file in "${FILES[@]}"; do
    wget -q "$REPO/$file" -O "$file"
    if [[ -f "$file" ]]; then
        chmod +x "$file"
        echo "   ✔ $file descargado"
    else
        echo "   ✖ ERROR: No se pudo descargar $file"
    fi
done

# -----------------------------------------
# 4. Instalar XRAY
# -----------------------------------------
echo "[+] Instalando XRAY..."
bash <(curl -Ls https://raw.githubusercontent.com/XTLS/Xray-install/main/install-release.sh)

# -----------------------------------------
# 5. Dominio manual
# -----------------------------------------
echo ""
echo "============================================"
echo " Ingresa tu dominio (sin Cloudflare API) "
echo "============================================"
read -p "Dominio: " DOMAIN

if [[ -z "$DOMAIN" ]]; then
    echo "✖ No ingresaste un dominio. Abortando."
    exit 1
fi

echo "$DOMAIN" > /etc/xray/domain

bash certificate.sh "$DOMAIN"

# -----------------------------------------
# 6. Crear comando 'menu'
# -----------------------------------------
echo "#!/bin/bash
bash $INSTALL_DIR/SSH-MENU.sh" > /usr/bin/menu

chmod +x /usr/bin/menu

# -----------------------------------------
# 7. Instalación finalizada
# -----------------------------------------
echo ""
echo "=========================================="
echo "     Instalación completada con éxito"
echo "=========================================="
echo "   Dominio: $DOMAIN"
echo "   Menú: menu"
echo "   Ruta de instalación: $INSTALL_DIR"
echo ""
echo "=========================================="
