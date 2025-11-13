# Galería de Aplicaciones Shiny - Estación R

Aplicación web interactiva para mostrar las apps desarrolladas por los estudiantes del curso **"Introducción a Shiny: construí tus primeros dashboards con R"** de Estación R.

## Características

- **Página de inicio** con hero section y branding de Estación R
- **Galería interactiva** de aplicaciones con sistema de filtrado
- **Tarjetas visuales** para cada aplicación con información del autor
- **Estadísticas del curso** con métricas y visualizaciones
- **Diseño responsive** compatible con móviles, tablets y desktop
- **Tema personalizado** basado en los colores corporativos de Estación R

## Estructura del Proyecto

```
Repo_curso_shiny/
├── app.R                          # Archivo principal de la aplicación
├── R/
│   ├── ui_modules.R              # Módulos de interfaz de usuario
│   ├── server_modules.R          # Módulos de servidor
│   └── utils.R                   # Funciones auxiliares
├── www/
│   ├── css/
│   │   └── custom.css            # Estilos personalizados
│   ├── js/
│   │   └── custom.js             # JavaScript personalizado
│   └── img/
│       ├── logo_estacion_r_ancho.png
│       ├── logo_estacion_r_largo.png
│       └── portada_curso.png
├── imagen_de_marca_estacion_r/
│   ├── _brand.yml                # Guía de marca
│   └── [archivos de imagen]
├── lista_shinyapps.ods           # Datos de las aplicaciones
└── README.md                     # Este archivo
```

## Instalación

### Requisitos Previos

Asegúrate de tener instalado:
- R (versión 4.0 o superior)
- RStudio (recomendado)

### Instalar Paquetes Necesarios

```r
# Paquetes principales
install.packages(c(
  "shiny",
  "bslib",
  "readODS",
  "dplyr",
  "htmltools",
  "shinyWidgets",
  "DT",
  "ggplot2",
  "plotly"
))
```

## Uso

### Ejecutar la Aplicación Localmente

1. Abre RStudio
2. Abre el archivo `app.R`
3. Haz clic en el botón "Run App" o ejecuta:

```r
shiny::runApp()
```

### Ejecutar desde la Consola

```r
# Navega al directorio del proyecto
setwd("/ruta/a/Repo_curso_shiny")

# Ejecuta la app
shiny::runApp("app.R")
```

## Configuración de Datos

La aplicación lee los datos de las apps desde el archivo `lista_shinyapps.ods`.

### Estructura Esperada del Archivo ODS

El archivo debe contener las siguientes columnas:

- `nombre_app`: Nombre de la aplicación
- `autor`: Nombre del autor/estudiante
- `url`: URL donde está desplegada la app
- `descripcion`: Descripción breve del proyecto
- `categoria`: Categoría temática de la app
- `fecha`: Fecha de creación (formato: YYYY-MM-DD)

### Ejemplo de Datos

| nombre_app | autor | url | descripcion | categoria | fecha |
|------------|-------|-----|-------------|-----------|--------|
| Mi Primera App | Juan Pérez | https://ejemplo.com | Dashboard de ventas | Negocios | 2024-01-15 |
| Visualizador de Datos | María García | https://ejemplo2.com | Explorador de datasets | Educación | 2024-01-20 |

## Personalización

### Colores y Tema

Los colores de la marca están definidos en:
- `imagen_de_marca_estacion_r/_brand.yml` (colores corporativos)
- `www/css/custom.css` (variables CSS)
- `app.R` (tema bslib)

Paleta de colores de Estación R:
- Azul primario: `#447099`
- Naranja: `#EE6331`
- Verde: `#72994E`
- Teal: `#419599`
- Burgundy: `#9A4665`

### Modificar el Logo

Reemplaza los archivos en `www/img/` con tu propio logo:
- `logo_estacion_r_ancho.png` (logo para el navbar)
- `logo_estacion_r_largo.png` (logo alternativo)
- `portada_curso.png` (imagen del hero section)

## Deployment

### Opción 1: shinyapps.io

```r
# Instalar rsconnect si no lo tienes
install.packages("rsconnect")

# Configurar tu cuenta
rsconnect::setAccountInfo(
  name = "tu-usuario",
  token = "tu-token",
  secret = "tu-secret"
)

# Desplegar
rsconnect::deployApp()
```

### Opción 2: Shiny Server

1. Instala Shiny Server en tu servidor
2. Copia el proyecto a `/srv/shiny-server/galeria-apps/`
3. La app estará disponible en `http://tu-servidor:3838/galeria-apps/`

### Opción 3: Docker

```dockerfile
FROM rocker/shiny:latest

# Instalar paquetes
RUN R -e "install.packages(c('shiny', 'bslib', 'readODS', 'dplyr', 'htmltools', 'shinyWidgets', 'DT', 'ggplot2', 'plotly'))"

# Copiar aplicación
COPY . /srv/shiny-server/galeria-apps/

EXPOSE 3838

CMD ["/usr/bin/shiny-server"]
```

## Funcionalidades Implementadas

- [x] Página de inicio con hero section
- [x] Tarjetas de estadísticas generales
- [x] Galería de apps con tarjetas visuales
- [x] Sistema de filtrado por categoría y autor
- [x] Búsqueda por texto
- [x] Visualizaciones con plotly
- [x] Tabla interactiva con DataTables
- [x] Diseño responsive
- [x] Tema personalizado con colores de Estación R

## Funcionalidades Futuras

- [ ] Sistema de votación/favoritos
- [ ] Comentarios en cada app
- [ ] Analytics de visitas
- [ ] Exportación a PDF
- [ ] Integración con redes sociales
- [ ] Vista detallada con iframe embebido

## Contribuir

Para contribuir al proyecto:

1. Haz un fork del repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agrega nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## Soporte

Para preguntas o problemas:
- Visita [Estación R](https://estacion-r.com/)
- Contacta al equipo de Estación R

## Licencia

Este proyecto está desarrollado para Estación R.

---

**Desarrollado con ❤️ usando R + Shiny**

*Estación R - Tu plataforma de aprendizaje de R y ciencia de datos*
