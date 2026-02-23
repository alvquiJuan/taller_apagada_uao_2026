#!/bin/bash
# =============================================================
#  TALLER: "LA GRAN APAGADA"
#  Script de configuración del ambiente
#  Curso: Sistemas Operativos
# =============================================================

set -e

BASE="$HOME/caso_apagada"

echo "================================================"
echo "  Configurando ambiente: LA GRAN APAGADA"
echo "================================================"

# -------------------------------------------------------------
# ESTRUCTURA DE DIRECTORIOS (pre-existente, como escena)
# -------------------------------------------------------------
mkdir -p "$BASE"/{sala_servidores,logs_sistema,personal,accesos,EVIDENCIAS}

# -------------------------------------------------------------
# ARCHIVOS DE LA ESCENA (los estudiantes los descubren con ls)
# -------------------------------------------------------------

# Mensaje de bienvenida
cat > "$BASE/LEEME.txt" << 'EOF'
=====================================================
   UNIDAD DE FORENSIA DIGITAL - CASO #2024-119
       "LA GRAN APAGADA"
=====================================================

A las 00:00 del 14 de marzo de 2024, el servidor
principal de la universidad fue apagado de forma
no autorizada. Los servicios estuvieron caídos
por 6 horas, afectando a más de 3.000 estudiantes.

El responsable de sistemas, Luis Cárdenas, afirma
que fue un error de Valentina Torres, técnica
de turno. Valentina lo niega.

TU MISIÓN como perito forense:
  1. Identifica la máquina asignada a tu caso
  2. Reconstruye la línea de tiempo del incidente
  3. Analiza los archivos comprometidos
  4. Descubre quién intentó borrar sus huellas
  5. Empaca el expediente para entregarlo

INSTRUCCIONES:
  Lee este archivo con:  cat LEEME.txt
  Ve los archivos con:   ls -la
  Empieza por:          cat sala_servidores/reporte_incidente.txt

¡El sistema no miente, pero las personas sí!
EOF

# Reporte del incidente
cat > "$BASE/sala_servidores/reporte_incidente.txt" << 'EOF'
REPORTE DE INCIDENTE - SISTEMAS
================================
Fecha:    14 de Marzo, 2024
Hora:     00:00 - 06:14
Servidor: SRV-UNIV-001
Tipo:     Apagado no autorizado

DESCRIPCIÓN:
El servidor principal fue apagado a medianoche.
No hubo mantenimiento programado para esa fecha.
Al reiniciar, se encontró que varios archivos de
log habían sido modificados o eliminados.

PERSONAL CON ACCESO ESA NOCHE:
  - Luis Cárdenas   (Jefe de Sistemas)
  - Valentina Torres (Técnica de turno)
  - Andrés Morales   (Administrador de red)

ARCHIVOS COMPROMETIDOS:
  - logs_sistema/acceso_servidor.log  (modificado)
  - logs_sistema/historial_comandos   (eliminado)
  - accesos/registro_llaves.txt       (intacto)

NOTA DEL INVESTIGADOR:
Se encontró un archivo comprimido sospechoso:
  sala_servidores/backup_logs.tar.gz
Está protegido con contraseña.
La clave puede estar en los archivos del sistema.
EOF

# Perfiles del personal
cat > "$BASE/personal/luis_cardenas.txt" << 'EOF'
PERFIL - LUIS CÁRDENAS
=======================
Cargo:     Jefe de Sistemas
Años:      12 años en la universidad
Acceso:    ROOT en todos los servidores
Turno:     Diurno (8AM - 6PM)

DECLARACIÓN:
"Yo ya me había ido a las 6 PM. Revisé las cámaras
y Valentina fue la última en salir de la sala de
servidores. Ella tenía el turno nocturno."

ANTECEDENTES:
Sin sanciones disciplinarias.
Evaluación reciente: Sobresaliente.

DATO CURIOSO:
Su usuario en el sistema es: lcardenas
EOF

cat > "$BASE/personal/valentina_torres.txt" << 'EOF'
PERFIL - VALENTINA TORRES
==========================
Cargo:     Técnica de Turno - Nocturno
Años:      2 años en la universidad
Acceso:    Limitado (sin permisos root)
Turno:     Nocturno (10PM - 6AM)

DECLARACIÓN:
"Yo nunca apagué el servidor. Además, no tengo
permisos para hacerlo. Solo Luis y Andrés pueden
ejecutar un shutdown. Revisen los logs de acceso."

ANTECEDENTES:
Sin sanciones. Excelentes referencias.

DATO CURIOSO:
Su usuario en el sistema es: vtorres
EOF

cat > "$BASE/personal/andres_morales.txt" << 'EOF'
PERFIL - ANDRÉS MORALES
========================
Cargo:     Administrador de Red
Años:      5 años en la universidad
Acceso:    ROOT (obtenido hace 3 meses)
Turno:     Flexible (puede conectarse remoto)

DECLARACIÓN:
"Estaba en casa. Me conecté brevemente a las 11PM
para revisar unas métricas de red. Nada más."

ANTECEDENTES:
Amonestación hace 6 meses por acceso fuera de horario.

DATO CURIOSO:
Su usuario en el sistema es: amorales
EOF

# Registro de llaves físicas (intacto, una pista limpia)
cat > "$BASE/accesos/registro_llaves.txt" << 'EOF'
REGISTRO DE ACCESO FÍSICO - SALA DE SERVIDORES
===============================================
Fecha: 14 de Marzo, 2024

HORA        PERSONA             ACCIÓN
---------   -----------------   --------
08:15 AM    Luis Cárdenas       ENTRADA
05:52 PM    Luis Cárdenas       SALIDA
10:05 PM    Valentina Torres    ENTRADA
11:47 PM    Valentina Torres    SALIDA  (*)
11:47 PM    ???                 ENTRADA (tarjeta no reconocida)
12:03 AM    ???                 SALIDA
06:10 AM    Valentina Torres    ENTRADA (alerta incidente)

(*) Valentina salió antes de su turno habitual.
    ¿Por qué?

NOTA: El sistema de tarjetas registra el ID del
chip. La tarjeta usada a las 11:47 PM tiene ID:
  CHIP-ID: 00-4F-A3-19
EOF

# Log de acceso al servidor (el archivo manipulado)
# Este es el archivo principal que los estudiantes deben analizar con vi
cat > "$BASE/logs_sistema/acceso_servidor.log" << 'EOF'
=== LOG DE ACCESO - SRV-UNIV-001 ===
Generado: 2024-03-14
CORRUPTO===========================CORRUPTO
CORRUPTO                           CORRUPTO
2024-03-13 08:22:10 | LOGIN  | lcardenas | OK
2024-03-13 09:14:33 | CMD    | lcardenas | apt update
2024-03-13 17:45:01 | LOGOUT | lcardenas | OK
CORRUPTO===========================CORRUPTO
2024-03-14 08:15:44 | LOGIN  | lcardenas | OK
2024-03-14 10:33:21 | CMD    | lcardenas | df -h
2024-03-14 17:51:08 | LOGOUT | lcardenas | OK
2024-03-14 22:05:19 | LOGIN  | vtorres   | OK
2024-03-14 22:11:02 | CMD    | vtorres   | ls /var/log
2024-03-14 23:46:55 | LOGOUT | vtorres   | OK
CORRUPTO===========================CORRUPTO
CORRUPTO  LAS SIGUIENTES LÍNEAS FUERON  CORRUPTO
CORRUPTO  ALTERADAS. USA :%s PARA       CORRUPTO
CORRUPTO  LIMPIARLAS Y VER LA VERDAD.   CORRUPTO
CORRUPTO===========================CORRUPTO
2024-03-14 23:CORRUPTO47:CORRUPTO03 | LOGIN  | aCORRUPTOmorales  | OK
2024-03-14 23:CORRUPTO51:CORRUPTO29 | CMD    | aCORRUPTOmorales  | ssh srv-univ-001
2024-03-15 00:CORRUPTO00:CORRUPTO01 | CMD    | aCORRUPTOmorales  | sudo shutdown -h now
2024-03-15 00:CORRUPTO01:CORRUPTO47 | CMD    | aCORRUPTOmorales  | rm -rf /var/log/syslog
2024-03-15 00:CORRUPTO03:CORRUPTO12 | LOGOUT | aCORRUPTOmorales  | OK
CORRUPTO===========================CORRUPTO
CORRUPTO                           CORRUPTO
CORRUPTO===========================CORRUPTO
EOF

# Agregar al final del log (requiere G en vi para llegar aquí)
cat >> "$BASE/logs_sistema/acceso_servidor.log" << 'EOF'


~
~
~
~  Si llegaste hasta aquí con G, vas bien, detective.
~  El archivo backup_logs.tar.gz tiene la prueba final.
~  La contraseña está formada por:
~
~  [usuario del culpable] + [hora exacta del shutdown] + [año]
~
~  Ejemplo de formato: nombreHHMM2024
~
~  (Elimina estas líneas con dd antes de entregar tu reporte)
~
EOF

# Crear el archivo tar.gz protegido con contraseña
# Contiene el log original sin modificar como "prueba final"
TMPDIR_LOG=$(mktemp -d)
cat > "$TMPDIR_LOG/log_original_sin_modificar.txt" << 'EOF'
=== LOG ORIGINAL - PRUEBA FORENSE ===
Recuperado de respaldo cifrado.

2024-03-14 23:47:03 | LOGIN  | amorales  | OK
2024-03-14 23:51:29 | CMD    | amorales  | ssh srv-univ-001
2024-03-15 00:00:01 | CMD    | amorales  | sudo shutdown -h now
2024-03-15 00:01:47 | CMD    | amorales  | rm -rf /var/log/syslog
2024-03-15 00:03:12 | LOGOUT | amorales  | OK

CONCLUSIÓN:
Andrés Morales (amorales) ejecutó el shutdown a las
00:00 del 15 de marzo de 2024 de forma remota,
usando sus credenciales de administrador de red.
Luego intentó eliminar el rastro borrando los logs
del sistema y corrompiendo este archivo de acceso.

La contraseña que usaste para abrir este archivo
es la evidencia: contiene su usuario, la hora
exacta del apagado y el año del incidente.

CASO RESUELTO.
EOF

# Comprimir con contraseña (amorales00002024)
cd "$TMPDIR_LOG"
zip -P "amorales00002024" "$BASE/sala_servidores/backup_logs.zip" log_original_sin_modificar.txt > /dev/null 2>&1
rm -rf "$TMPDIR_LOG"
cd "$BASE"

# Cheat sheet de vi incluido (para que no se bloqueen)
cat > "$BASE/GUIA_VI.txt" << 'EOF'
==============================
  GUIA RÁPIDA DE VI
==============================

MODOS:
  i         Entrar a modo inserción (editar)
  ESC       Volver a modo normal
  :w        Guardar
  :q        Salir
  :wq       Guardar y salir
  :q!       Salir sin guardar

NAVEGACIÓN:
  G         Ir a la ÚLTIMA línea del archivo
  gg        Ir a la primera línea
  /texto    Buscar "texto" en el archivo
  n         Siguiente resultado de búsqueda

EDICIÓN EN MODO NORMAL:
  dd        Eliminar (borrar) la línea actual
  5dd       Eliminar 5 líneas de una vez
  u         Deshacer último cambio

SUSTITUCIÓN GLOBAL:
  :%s/TEXTO_VIEJO/TEXTO_NUEVO/g
            Reemplaza TODAS las ocurrencias
  Ejemplo:
  :%s/CORRUPTO//g    (borra todas las palabras CORRUPTO)

TRUCO PARA ESTE TALLER:
  1. Abre el archivo:  vi logs_sistema/acceso_servidor.log
  2. Ve al final:      G
  3. Lee la pista
  4. Limpia el log:    :%s/CORRUPTO//g
  5. Borra líneas ~:   dd (una por una)
  6. Guarda:           :wq
EOF

# Cheat sheet general
cat > "$BASE/COMANDOS_UTILES.txt" << 'EOF'
=============================================
  CHEAT SHEET - TALLER LA GRAN APAGADA
=============================================

RECONOCIMIENTO DE LA MÁQUINA:
  whoami              ¿Quién soy en este sistema?
  lsblk               Ver discos y particiones
  lshw -short         Ver hardware del sistema (puede requerir sudo)

EXPLORACIÓN:
  ls                  Listar archivos
  ls -la              Listar con detalles y ocultos
  ls -lh              Listar con tamaños legibles
  cat archivo         Ver contenido
  less archivo        Ver con paginación (q para salir)

CREAR ESTRUCTURA DEL EXPEDIENTE:
  mkdir nombre        Crear carpeta
  mkdir -p a/b/c      Crear carpetas anidadas
  touch archivo.txt   Crear archivo vacío

ESCRIBIR EN ARCHIVOS:
  echo "texto"                    Imprimir en pantalla
  echo "texto" > archivo.txt      Escribir en archivo (sobreescribe)
  echo "texto" >> archivo.txt     Agregar al final del archivo

EDITAR CON VI:
  vi archivo.txt      Abrir archivo (ver GUIA_VI.txt)

COMPRIMIR Y EMPACAR:
  tar -czf paquete.tar.gz carpeta/    Comprimir carpeta
  tar -xzf paquete.tar.gz             Descomprimir
  gzip archivo.txt                    Comprimir un archivo
  gzip -d archivo.gz                  Descomprimir un archivo
  unzip -P contraseña archivo.zip     Descomprimir con contraseña

FLUJO SUGERIDO:
  1. whoami && lsblk
  2. ls -la (explorar)
  3. cat LEEME.txt
  4. cat sala_servidores/reporte_incidente.txt
  5. Explorar personal/ y accesos/
  6. vi logs_sistema/acceso_servidor.log
  7. mkdir -p EVIDENCIAS/{logs,perfiles,reporte}
  8. echo y > para documentar hallazgos
  9. unzip backup con la contraseña descubierta
  10. tar + gzip para empacar expediente final
EOF

# Permisos
chmod -R u+rw "$BASE"

echo ""
echo "✅ Ambiente creado exitosamente en: $BASE"
echo ""
echo "Para comenzar el taller:"
echo "  cd $BASE && cat LEEME.txt"
echo ""
echo "Archivos creados:"
find "$BASE" -type f | sed "s|$BASE/||" | sort
echo ""