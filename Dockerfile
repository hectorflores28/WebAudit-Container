FROM nginx:alpine

# Actualizar el índice de paquetes e instalar Nikto y Perl
# Nikto requiere Perl para funcionar correctamente
RUN apk update && apk add --no-cache nikto perl

# Copiar el contenido del sitio web descargado al directorio raíz de Nginx
COPY ./destination-path /usr/share/nginx/html

# Exponer el puerto 80 para que Nginx sea accesible
EXPOSE 80

# Comando por defecto: iniciar el servidor Nginx
CMD ["nginx", "-g", "daemon off;"]