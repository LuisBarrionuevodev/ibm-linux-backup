#!/bin/bash

# [TAREA 1] Asignar los argumentos a variables
targetDirectory=$1
destinationDirectory=$2

# [TAREA 2] Mostrar los argumentos
echo "Directorio de origen: $targetDirectory"
echo "Directorio de destino: $destinationDirectory"
# [TAREA 3]
currentTS=$(date +%s)
echo "Timestamp actual: $currentTS"
# [TAREA 4]
backupFileName="backup-${currentTS}.tar.gz"

# Comprobaciones
echo "Timestamp actual: $currentTS"
echo "Nombre del archivo: $backupFileName"
# [TAREA 5]
origAbsPath=$(pwd)

# [TAREA 6]
cd "$destinationDirectory" || exit 1
destAbsPath=$(pwd)

# Comprobaciones
echo "Ruta original: $origAbsPath"
echo "Ruta absoluta del destino: $destAbsPath"
echo $(pwd)
cd "$origAbsPath" || exit 1
echo $(pwd)
cd "$targetDirectory" || exit 1
echo $(pwd)
# [TAREA 8]
yesterdayTS=$((currentTS - 24 * 60 * 60))
echo "Timestamp actual: $currentTS"
# Comprobaciones temporales
echo "Directorio actual: $(pwd)"
echo "Timestamp actual: $currentTS"
echo "Timestamp de ayer: $yesterdayTS"

# [TAREA 9]
toBackup=()

for file in *
do
    # Ignorar coincidencias inexistentes
    [[ -e "$file" ]] || continue

    # [TAREA 10]
    if [[ $(date -r "$file" +%s) -gt $yesterdayTS ]]
    then
        # [TAREA 11]
        toBackup+=("$file")
    fi
done

# Comprobación temporal
echo "Archivos seleccionados para el backup:"
printf '%s\n' "${toBackup[@]}"

# [TAREA 12]

# Comprobar que existan archivos para respaldar
if (( ${#toBackup[@]} == 0 )); then
    echo "No hay archivos modificados en las ultimas 24 horas."
    exit 0
fi

# Crear el archivo comprimido
tar -czf "$backupFileName" "${toBackup[@]}" || exit 1

# [TAREA 13]

# Mover el backup al directorio de destino
mv "$backupFileName" "$destAbsPath/" || exit 1

echo "Backup creado correctamente."
echo "Ubicacion: $destAbsPath/$backupFileName"
