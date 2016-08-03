Joomla3-Base
============

Este es un pack que incluye Joomla 3 y diversas extensiones para hacer más breve la inicialización de un nuevo proyecto web.

Notas:
- Se puede descargar un archivo jpa, copia del sitio completo, desde la carpeta administrator/components/com_akeeba/backup.
- El archivo de la base de datos es joomla3base.sql.
- El usuario y la contraseña son "admin". Cámbialos.
- Joomla configurado inicialmente para URLs amigables con Apache.

Archivos a eliminar antes del despliegue en producción:
- joomla3base.sql
- readme.md

Paquetes incluidos:
- Joomla 3.6
- Idioma español 3.6.0.1
- Editor JCE 2.5.19 + traducción al español
- OSmap 4.1.3.
- Akeeba Backup 5.1.2 + traducción al español

Contenidos incluidos:
- Nota legal
- Política de privacidad
- Mapa web (OSmap). Recuerda indicar en el archivo robots.txt la URL y, preferiblemente que sea algo como "sitemap.xml" a través de una redirección en el archivo .htaccess.
- Menú en el pie de página con estos 3 elementos anteriores.

Configuraciones iniciales realizadas:
- Establecido el idioma español por defecto en la parte pública y privada.
- Creado idioma español para los contenidos.

Cambios en la configuración global:
- URLs amigables y reescritura de URLs activados. Incluido fichero .htaccess para servidor Apache.
- Activada compresión Gzip.
- Desactivado el informe de errores.
- Establecida la zona horaria de Madrid.
- Establecido JCE como editor predeterminado.
- Mostrar la metaetiqueta del autor desactivado.
- Duración de la sesión establecida a 120 minutos.