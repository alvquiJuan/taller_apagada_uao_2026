#!/bin/bash
# =============================================================
#  VALIDADOR DE ENTREGA - "LA GRAN APAGADA"
#  Curso: Sistemas Operativos
# =============================================================

BASE="$HOME/caso_apagada"
EVIDENCIAS="$BASE/EVIDENCIAS"
LOG_MODIFICADO="$BASE/logs_sistema/acceso_servidor.log"
LOG_ORIGINAL="$EVIDENCIAS/logs/log_original_sin_modificar.txt"
HISTORIAL="$EVIDENCIAS/reporte/historial_comandos.txt"
REPORTE="$EVIDENCIAS/reporte/conclusiones.txt"

PUNTOS=0
TOTAL=100
ERRORES=()

# -------------------------------------------------------------
# Colores
# -------------------------------------------------------------
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No color

ok()   { echo -e "  ${GREEN}✅ $1${NC}"; }
fail() { echo -e "  ${RED}❌ $1${NC}"; ERRORES+=("$1"); }
info() { echo -e "  ${CYAN}ℹ️  $1${NC}"; }
warn() { echo -e "  ${YELLOW}⚠️  $1${NC}"; }

# -------------------------------------------------------------
# ENCABEZADO
# -------------------------------------------------------------
echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}   VALIDACIÓN DE ENTREGA - CASO #2024-119  ${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""
echo -e "  Perito:  $(whoami)"
echo -e "  Fecha:   $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "  Máquina: $(hostname)"
echo ""

# -------------------------------------------------------------
# VALIDACIÓN 1 — Log de acceso modificado correctamente (40 pts)
# -------------------------------------------------------------
echo -e "${CYAN}[1/3] Verificando log de acceso modificado...${NC}"

if [ ! -f "$LOG_MODIFICADO" ]; then
    fail "El archivo acceso_servidor.log no existe"
else
    # 1a. La palabra CORRUPTO ya no debe aparecer (20 pts)
    if grep -q "CORRUPTO" "$LOG_MODIFICADO"; then
        fail "El archivo aún contiene la palabra CORRUPTO (usa :%s/CORRUPTO//g en vi)"
    else
        ok "Palabra CORRUPTO eliminada del log"
        PUNTOS=$((PUNTOS + 20))
    fi

    # 1b. El culpable debe ser identificable en el log limpio (20 pts)
    if grep -q "amorales" "$LOG_MODIFICADO"; then
        ok "El usuario del culpable (amorales) es visible en el log"
        PUNTOS=$((PUNTOS + 20))
    else
        fail "El usuario del culpable no aparece en el log limpio"
    fi

    # Bonus informativo: verificar que el shutdown también es visible
    if grep -q "shutdown" "$LOG_MODIFICADO"; then
        info "Comando shutdown encontrado en el log"
    else
        warn "El comando shutdown no es visible — ¿se borró más de lo necesario?"
    fi
fi
echo ""

# -------------------------------------------------------------
# VALIDACIÓN 2 — Log original en carpeta de evidencias (30 pts)
# -------------------------------------------------------------
echo -e "${CYAN}[2/3] Verificando log original en EVIDENCIAS...${NC}"

# 2a. Carpeta EVIDENCIAS/logs existe (5 pts)
if [ ! -d "$EVIDENCIAS/logs" ]; then
    fail "La carpeta EVIDENCIAS/logs no existe"
else
    ok "Carpeta EVIDENCIAS/logs existe"
    PUNTOS=$((PUNTOS + 5))
fi

# 2b. El archivo del log original existe (15 pts)
if [ ! -f "$LOG_ORIGINAL" ]; then
    fail "El log original no está en EVIDENCIAS/logs/"
    info "Esperado en: $LOG_ORIGINAL"
    info "Recuerda descomprimir con: unzip -P amorales00002024 sala_servidores/backup_logs.zip -d EVIDENCIAS/logs/"
else
    ok "Log original encontrado en EVIDENCIAS/logs/"
    PUNTOS=$((PUNTOS + 15))

    # 2c. El log original contiene la evidencia del culpable (10 pts)
    if grep -q "amorales" "$LOG_ORIGINAL" && grep -q "shutdown" "$LOG_ORIGINAL"; then
        ok "Log original contiene la evidencia del culpable"
        PUNTOS=$((PUNTOS + 10))
    else
        fail "El log original no contiene la evidencia esperada — puede estar corrupto"
    fi
fi
echo ""

# -------------------------------------------------------------
# VALIDACIÓN 3 — Historial de comandos (30 pts)
# -------------------------------------------------------------
echo -e "${CYAN}[3/3] Generando y verificando historial de comandos...${NC}"

# Crear carpeta del reporte si no existe
mkdir -p "$EVIDENCIAS/reporte"

# Extraer historial automáticamente
history > "$HISTORIAL" 2>/dev/null || \
    fc -l 1 > "$HISTORIAL" 2>/dev/null || \
    cat ~/.bash_history > "$HISTORIAL" 2>/dev/null

if [ ! -s "$HISTORIAL" ]; then
    fail "No se pudo extraer el historial de comandos"
else
    ok "Historial exportado en: $HISTORIAL"
    PUNTOS=$((PUNTOS + 10))

    # Verificar comandos clave usados durante el taller
    COMANDOS_ESPERADOS=("vi" "mkdir" "touch" "echo" "unzip" "tar" "whoami" "lsblk")
    ENCONTRADOS=0

    info "Comandos del taller encontrados en el historial:"
    for cmd in "${COMANDOS_ESPERADOS[@]}"; do
        if grep -q "$cmd" "$HISTORIAL"; then
            ok "  $cmd"
            ENCONTRADOS=$((ENCONTRADOS + 1))
        else
            warn "  $cmd — no encontrado en historial"
        fi
    done

    # Puntaje proporcional según cuántos comandos usaron (20 pts)
    PUNTOS_CMDS=$(( (ENCONTRADOS * 20) / ${#COMANDOS_ESPERADOS[@]} ))
    PUNTOS=$((PUNTOS + PUNTOS_CMDS))
    info "Comandos encontrados: $ENCONTRADOS de ${#COMANDOS_ESPERADOS[@]}"
fi
echo ""

# -------------------------------------------------------------
# BONUS — Expediente empacado con tar (informativo)
# -------------------------------------------------------------
echo -e "${CYAN}[BONUS] Verificando expediente empacado...${NC}"
TAR_FILE=$(find "$BASE" -maxdepth 1 -name "*.tar.gz" 2>/dev/null | head -1)
if [ -n "$TAR_FILE" ]; then
    ok "Expediente empacado encontrado: $(basename $TAR_FILE)"
    info "Contenido del paquete:"
    tar -tzf "$TAR_FILE" 2>/dev/null | sed 's/^/     /'
else
    warn "No se encontró un archivo .tar.gz — recuerda empacar con:"
    warn "  tar -czf expediente_caso_2024.tar.gz EVIDENCIAS/"
fi
echo ""

# -------------------------------------------------------------
# RESULTADO FINAL
# -------------------------------------------------------------
echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}   RESULTADO FINAL                         ${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""
echo -e "  Puntaje obtenido: ${GREEN}$PUNTOS${NC} / $TOTAL"
echo ""

if [ ${#ERRORES[@]} -gt 0 ]; then
    echo -e "  ${RED}Puntos pendientes:${NC}"
    for err in "${ERRORES[@]}"; do
        echo -e "    ${RED}• $err${NC}"
    done
    echo ""
fi

# Nota final según puntaje
if   [ $PUNTOS -ge 90 ]; then
    echo -e "  ${GREEN}🏆 Excelente trabajo, detective. Caso resuelto.${NC}"
elif [ $PUNTOS -ge 70 ]; then
    echo -e "  ${YELLOW}👍 Buen trabajo. Revisa los puntos pendientes.${NC}"
elif [ $PUNTOS -ge 50 ]; then
    echo -e "  ${YELLOW}🔍 Vas por buen camino, pero faltan evidencias.${NC}"
else
    echo -e "  ${RED}🚨 El caso necesita más investigación.${NC}"
fi

echo ""

# -------------------------------------------------------------
# GUARDAR REPORTE DE VALIDACIÓN
# -------------------------------------------------------------
REPORTE_VALIDACION="$EVIDENCIAS/reporte/validacion_$(date +%Y%m%d_%H%M%S).txt"
mkdir -p "$EVIDENCIAS/reporte"
{
    echo "REPORTE DE VALIDACIÓN - CASO #2024-119"
    echo "Perito:  $(whoami)"
    echo "Fecha:   $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Máquina: $(hostname)"
    echo "Puntaje: $PUNTOS / $TOTAL"
    echo ""
    echo "Errores:"
    for err in "${ERRORES[@]}"; do
        echo "  - $err"
    done
} > "$REPORTE_VALIDACION"

echo -e "  Reporte guardado en: ${CYAN}$REPORTE_VALIDACION${NC}"
echo ""