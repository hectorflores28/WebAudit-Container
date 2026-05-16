# WebAudit-Container
Contenedor Docker para auditoría web y pentesting local seguro. Descarga réplicas exactas de sitios con wget, las aísla en un entorno Nginx y permite ejecutar escaneos de vulnerabilidades

# 1. Descargar el sitio web

```bash
wget --mirror --page-requisites --adjust-extension --convert-links --no-parent -w 2 https://tusitio.com
```

## Descargar en carpeta especifica

```bash
wget --mirror -p --convert-links -P ./destination-path https://tusitio.com
```

# 2. Crear el Dockerfile

```bash
FROM nginx:alpine
COPY ./destination-path /usr/share/nginx/html
EXPOSE 80
```

# 3. Crear la imagen de Docker

```bash
docker build -t web-audit .
```

# 4. Ejecutar en un contenedor aislado

```bash
docker run -d -p 8080:80 --name sitio-auditoria web-audit
```

# 5. Escanear vulnerabilidades

Como Nikto ya está incluido en la imagen, puedes ejecutar los escaneos directamente desde el contenedor:

### Escaneo con Nikto (Interno)

```bash
docker exec -it sitio-auditoria nikto -h localhost
```

### Escaneo con Nikto (Salida a archivo)

```bash
docker exec -it sitio-auditoria nikto -h localhost -o /usr/share/nginx/html/scan-report.html -Format htm
```

### Otras herramientas (Externas)

Si prefieres usar otras herramientas desde fuera:

```bash
# Escaneo con ZAP (interactivo)
docker run -it --rm -p 8080:8080 -v /ruta/a/tu/web-audit:/zap/wrk owasp/zap2docker-stable zap-baseline.py -t http://localhost:8080
```

[http://localhost:8080](http://localhost:8080/)

```bash
# Escanea archivos peligrosos o configuraciones debiles
docker exec -it sitio-auditoria nikto -h localhost
```
