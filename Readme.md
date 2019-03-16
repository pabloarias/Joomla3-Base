# Joomla3-Base

Este es un paquete que incluye Joomla 3 y diversas extensiones para hacer más breve la inicialización de un nuevo proyecto web.

## Notas

- Se puede descargar un archivo jpa, copia del sitio completo, desde la carpeta administrator/components/com_akeeba/backup.
- El archivo de la base de datos es joomla3base.sql.
- El usuario y la contraseña son "admin". Cámbialos.
- Joomla configurado inicialmente para URLs amigables con Apache.

Archivos a eliminar antes del despliegue en producción:

- joomla3base.sql
- readme.md

## Paquetes incluidos

- Joomla 3.9.4
- Idioma español 3.9.1.1
- Akeeba Backup 6.4.2 con traducción al español

## Contenidos incluidos

- Nota legal.
- Política de privacidad.
- Mapa web (OSmap). Recuerda indicar en el archivo robots.txt la URL y, preferiblemente que sea algo como "sitemap.xml" a través de una redirección en el archivo .htaccess.
- Menú con estos 3 elementos anteriores (Menú footer).
- Módulo para mostrar este menú en el pie de página.

## Cambios en la configuración global

- URLs amigables y reescritura de URLs activados. Incluido fichero .htaccess para servidor Apache.
- Activada compresión Gzip.
- Desactivado el informe de errores.
- Establecida la zona horaria de Madrid.
- Desactivada la opción de mostrar la etiqueta meta del autor.
- Duración de la sesión establecida a 480 minutos.

## Otras configuraciones iniciales realizadas

### Idiomas

- Establecido el idioma español por defecto en la parte pública y privada.
- El español es el idioma por defecto para los contenidos.

### Configuración inicial del componente de contenidos

- Renombrada categoría "Uncategorised" a "General".
- Cambiada en la configuración de vista de un artículo que no se muestren la categoría, la fecha, los iconos (imprimir, PDF...) y la navegación entre artículos.
