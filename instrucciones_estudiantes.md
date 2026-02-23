# TALLER PRÁCTICO DE TERMINAL
## "La Gran Apagada" - Caso Forense #2024-119

---

## CONTEXTO DEL CASO

El 14 de marzo de 2024 a las 00:00 horas, el servidor principal de la universidad fue apagado de forma no autorizada. Los servicios estuvieron caídos por 6 horas, afectando a más de 3,000 estudiantes.

**Hay tres sospechosos:**
- Luis Cárdenas (Jefe de Sistemas)
- Valentina Torres (Técnica de turno nocturno)
- Andrés Morales (Administrador de red)

**Tu rol:** Eres un perito forense digital asignado para resolver el caso.

**Tu objetivo:** Identificar quién apagó el servidor, cuándo lo hizo y encontrar las pruebas que lo demuestren.

---

## CONFIGURACIÓN INICIAL

### 1. Ejecuta el script de configuración

En tu terminal, ejecuta:
```bash
./setup_taller.sh
```

Esto creará el ambiente del caso en tu máquina.

### 2. Navega al directorio del caso

```bash
cd ~/caso_apagada
```

### 3. Lee las instrucciones generales

```bash
cat LEEME.txt
```

---

## FASE 1: RECONOCIMIENTO DE LA MÁQUINA 

Como perito forense, lo primero es identificar la máquina donde trabajarás.

### Tareas:

**1.1** Verifica tu identidad en el sistema
- ¿Con qué usuario estás trabajando? (muestra con una captura de pantalla el comando usado para esto y su resultado)
- **Comando útil:** Hay uno que te dice "quién soy yo" en inglés

**1.2** Inspecciona los discos y particiones
- ¿Cuántos discos tiene la máquina?
- ¿Cuál es el disco principal?
- **Comando útil:** Piensa en "listar dispositivos de bloque"
recuerda evidenciar el uso de los comandos con capturas de pantalla que muestren el comando usado y sus resultados)

**1.3** Revisa el hardware del sistema (opcional)
- ¿Cuánta RAM tiene?
- ¿Qué procesador usa?
- **Comando útil:** Busca información de hardware (puede requerir sudo)

💡 **Tip:** Anota tus hallazgos en un archivo para no olvidarlos

---

## FASE 2: EXPLORACIÓN DE LA ESCENA 

Ahora explora los archivos del caso que ya están en el sistema.

### Tareas:

**2.1** Lista todos los archivos y carpetas del caso
- ¿Qué carpetas existen?
- ¿Hay archivos ocultos?
- **Comando útil:** Lista con opciones para ver detalles y archivos ocultos
muestra con evidencia gráfica (captura de pantalla de los comandos usados)

**2.2** Lee el reporte del incidente
- Está en la carpeta `sala_servidores/`
- ¿Qué archivos fueron comprometidos?
- ¿Quiénes tenían acceso esa noche?
Apoye sus respuestas con evidencia gráfica (captura de pantalla de los comandos usados)

**2.3** Revisa los perfiles del personal
- Están en la carpeta `personal/`
- Lee los tres archivos
- ¿Quién tiene permisos ROOT?
- ¿Qué dice cada uno en su declaración?
Apoye sus respuestas con evidencia gráfica (captura de pantalla de los comandos usados)

**2.4** Examina el registro de llaves físicas
- Está en la carpeta `accesos/`
- ¿A qué hora salió Valentina?
- ¿Hubo algún acceso anómalo?
- ¿Qué significa "tarjeta no reconocida"?
Apoye sus respuestas con evidencia gráfica (captura de pantalla de los comandos usados)

💡 **Pregunta clave:** ¿Quién tiene la capacidad técnica de apagar el servidor?

---

## FASE 3: EL ARCHIVO COMPROMETIDO 

⚠️ **ESTA ES LA FASE MÁS IMPORTANTE DEL TALLER**

El archivo `logs_sistema/acceso_servidor.log` fue manipulado por el culpable para ocultar sus huellas. Tu trabajo es limpiarlo y descubrir la verdad.

### Tareas:

**3.1** Abre el archivo con el editor `vi`


**3.2** Explora el archivo completo
- Presiona `G` (G mayúscula) para ir al FINAL del archivo
- Lee el mensaje oculto que dejó el investigador anterior
- **Pregunta:** ¿Qué formato tiene la contraseña que necesitas?

**3.3** Limpia el archivo de texto corrupto
- El archivo está lleno de la palabra "CORRUPTO"
- Necesitas eliminarla TODA de una sola vez

describe el proceso que usaste para eliminar el texto "CORRUPTO" del archivo, puede apoyer su descripción con evidencia gráfica.

**3.4** Observa las líneas que ahora son visibles
- ¿Qué usuario aparece en las líneas que estaban ocultas?
- ¿A qué hora hizo login?
- ¿Qué comando ejecutó?

**3.5** Limpia las líneas de pista antes de guardar
- Las líneas que empiezan con `~` son solo para ti
- Elimínalas para que no queden pistas de que recibiste ayudas.

**3.6** Guarda y sal de vi
- Describe brevemente el proceso realizado para guardar y salir de vi

💡 **Si te atoras en vi:**
- `ESC` → volver a modo normal
- `i` → entrar a modo inserción (editar)
- `:q!` → salir sin guardar
- Lee el archivo `GUIA_VI.txt` con `cat GUIA_VI.txt`

### Preguntas que ya puedes responder:

1. ¿Quién es el culpable? (usuario del sistema)
2. ¿A qué hora ejecutó el shutdown? (formato HHMM)
3. ¿En qué año ocurrió? 

---

## FASE 4: CONSTRUCCIÓN DEL EXPEDIENTE (20 minutos)

Como perito forense, debes documentar TODO de forma organizada.

### Tareas:

**4.1** Crea la estructura de carpetas del expediente, debe coincidir con el siguiente árbol

 EVIDENCIAS
    ├── logs
    ├── perfiles
    └── reporte

Muestre con evidencia gráfica los comandos usados para crear esta estructura

**4.2** Crea archivos iniciales en tu reporte debe quedar algo como:
EVIDENCIAS
    ├── logs
    ├── perfiles
    └── reporte
        ├── conclusiones.txt
        └── linea_tiempo.txt

Muestre con evidencia gráfica los comandos usados para crear esta estructura

**4.3** Documenta tus hallazgos principales
Usa los operadores `>`  `>>` para agregar las siguientes líneas al archivo `EVIDENCIAS/reporte/conclusiones.txt`:

```bash
"CONCLUSIÓN DEL CASO"  
"===================" 
"Culpable identificado: [escribe aquí el nombre y usuario]"
```

Continúa agregando:
- La hora exacta del incidente
- Los comandos ejecutados por el culpable
- Cómo intentó borrar sus huellas

**4.4** Documenta la línea de tiempo
En el archivo `linea_tiempo.txt`, escribe los eventos importantes en orden cronológico usando `echo` y `>>`.

💡 **Recuerda:** `>` sobrescribe el archivo, `>>` agrega al final

---

## FASE 5: RECUPERACIÓN DEL LOG ORIGINAL (10 minutos)

El archivo `sala_servidores/backup_logs.zip` contiene el log original sin modificar, pero está protegido con contraseña.

### Tareas:

**5.1** Construye la contraseña
Según la pista del archivo de vi, la contraseña es:
```
[usuario_del_culpable][hora_del_shutdown][año]
```

Por ejemplo, si el culpable fuera `jdoe`, apagó a las 23:45 en 2024:
```
jdoe23452024
```

**5.2** Descomprime el archivo protegido
```bash
unzip -P TU_CONTRASEÑA_AQUI sala_servidores/backup_logs.zip -d EVIDENCIAS/logs/
```

Reemplaza `TU_CONTRASEÑA_AQUI` con la contraseña que construiste.

**5.3** Verifica el contenido del log original
```bash
cat EVIDENCIAS/logs/log_original_sin_modificar.txt
```

Esto confirma tu investigación con el registro oficial sin alterar.

---

## FASE 6: EMPAQUETADO DEL EXPEDIENTE

El paso final es empaquetar todo tu trabajo para entregarlo.

### Tareas:

**6.1** Comprime tu expediente completo
```bash
tar -czf expediente_caso_2024.tar.gz EVIDENCIAS/
```

Esto crea un archivo comprimido con extensión `.tar.gz`

**6.2** Verifica el contenido sin descomprimir
```bash
tar -tzf expediente_caso_2024.tar.gz
```

Deberías ver:
- EVIDENCIAS/logs/
- EVIDENCIAS/perfiles/
- EVIDENCIAS/reporte/

**6.3** Verifica el tamaño del archivo
```bash
ls -lh expediente_caso_2024.tar.gz
```

---

## VALIDACIÓN Y ENTREGA

### Para validar tu trabajo:

```bash
./validacion_taller.sh
```

Este script verificará:
- ✅ Que limpiaste correctamente el log comprometido
- ✅ Que recuperaste el log original en EVIDENCIAS
- ✅ Que usaste los comandos correctos (revisa tu historial automáticamente)

**Puntaje mínimo para aprobar:** 70/100

### Entrega final:

Comparte con el instructor:
1. El archivo `expediente_caso_2024.tar.gz`
2. El reporte de validación generado en `EVIDENCIAS/reporte/validacion_*.txt`

---

## COMANDOS DE REFERENCIA RÁPIDA

Puedes consultar en cualquier momento:
```bash
cat COMANDOS_UTILES.txt    # Lista completa de comandos
cat GUIA_VI.txt            # Ayuda específica para vi
```

---

## PREGUNTAS FRECUENTES

**P: ¿Cómo salgo de vi?**
R: Presiona ESC y luego escribe `:q!` para salir sin guardar o `:wq` para guardar y salir.

**P: ¿Cómo sé si mi contraseña del zip es correcta?**
R: Si la contraseña es incorrecta, verás un error. Si es correcta, el archivo se extraerá sin problemas.

**P: ¿Puedo usar nano en lugar de vi?**
R: Para este taller específico, debes usar vi porque es parte del aprendizaje. En la vida real, puedes usar el editor que prefieras.

**P: Borré algo importante por error, ¿qué hago?**
R: Puedes volver a ejecutar `./setup_taller.sh` para regenerar todos los archivos. Perderás tu progreso, pero tendrás los archivos originales de nuevo.

**P: ¿Cuántas veces puedo ejecutar el validador?**
R: Las que quieras. Úsalo para verificar tu progreso durante el taller.

---

## CRITERIOS DE EVALUACIÓN

| Criterio | Puntos |
|----------|--------|
| Log de acceso limpiado correctamente | 40 |
| Log original recuperado y guardado | 30 |
| Historial de comandos completo | 30 |
| **TOTAL** | **100** |

## ¿NECESITAS AYUDA?

1. Lee los archivos de ayuda: `COMANDOS_UTILES.txt` y `GUIA_VI.txt`
2. Consulta con tus compañeros
3. Levanta la mano para pedir ayuda al profesor

**¡Buena suerte, detective!** 