#!/bin/bash
# =========================================================
# SCRIPT DE COPIA DE SEGURIDAD (BACKUP) DE MYSQL
# DATABASE: ProductStore
# =========================================================

# --- 1. CONFIGURACIÓN ---
# Define el nombre de la base de datos a respaldar
DB_NAME="ProductStore"
# Define el directorio donde se guardarán los archivos de backup
# Asumase que este directorio existe.
BACKUP_DIR="/home/$(whoami)/Documents/SandBox/" 
# Define la fecha actual para el nombre del archivo (YYYYMMDD_HHMMSS)
DATE_TIME=$(date +%Y%m%d_%H%M%S)
# Define el nombre de usuario de MySQL 
MYSQL_USER="root" # Puede ser cualquier otro con privilegios.
# --- 2. VALIDACIÓN DEL DIRECTORIO ---
if [ ! -d "$BACKUP_DIR" ]; then
    echo "ERROR: Directorio de backup no encontrado: $BACKUP_DIR"
    exit 1
fi

echo "--- Iniciando copia de seguridad para la base de datos: $DB_NAME ---"
echo "Directorio de destino: $BACKUP_DIR"
# --- 3. COPIA DE SEGURIDAD COMPLETA (Estructura y Datos) ---
FULL_BACKUP_FILE="${BACKUP_DIR}${DB_NAME}_FULL_${DATE_TIME}.sql"
echo "-> 3.1. Creando backup completo: $FULL_BACKUP_FILE"
# Se usa 'sudo' si es necesario, pero generalmente 'mysqldump' solo pide la contraseña
mysqldump -u "$MYSQL_USER" -p "$DB_NAME" > "$FULL_BACKUP_FILE"
# Verifica si el comando fue exitoso
if [ $? -eq 0 ]; then
    echo "-> 3.2. Copia de seguridad completa exitosa."
else
    echo "ERROR: Falló la copia de seguridad completa. Verifique la contraseña o permisos."
    exit 1
fi

# --- 4. COPIA DE SEGURIDAD DEL ESQUEMA (Solo Estructura/Schema) ---
SCHEMA_BACKUP_FILE="${BACKUP_DIR}${DB_NAME}_SCHEMA_${DATE_TIME}.sql"
echo "-> 4.1. Creando backup solo de esquema: $SCHEMA_BACKUP_FILE"
mysqldump -u "$MYSQL_USER" -p --no-data "$DB_NAME" > "$SCHEMA_BACKUP_FILE"
if [ $? -eq 0 ]; then
    echo "-> 4.2. Copia de seguridad del esquema exitosa."
else
    echo "ERROR: Falló la copia de seguridad del esquema."
fi
# --- 5. VERIFICACIÓN Y TAMAÑO ---
echo "--- Verificación de archivos ---"
# Muestra el tamaño de los dos archivos creados
du -h "$FULL_BACKUP_FILE"
du -h "$SCHEMA_BACKUP_FILE"
echo "--- Tarea de Backup Completada ---"