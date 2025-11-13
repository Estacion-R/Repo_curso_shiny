# Contexto del Proyecto: Galería de Aplicaciones Shiny - Estación R

## 🎯 Objetivo Principal
Desarrollar una aplicación web con Shiny y R que sirva como galería interactiva para mostrar de forma simple e intuitiva todas las aplicaciones creadas por los estudiantes del curso "🖥️ Introducción a Shiny: construí tus primeros dashboards con R" de Estación R. Esta aplicación será utilizada para mostrar en redes sociales los resultados del curso.

## 📋 Requisitos Funcionales

### Características Principales
1. **Página de inicio atractiva** con branding de Estación R
2. **Galería de aplicaciones** con:
   - Vista de tarjetas (cards) con preview de cada app
   - Información del autor/estudiante
   - Descripción breve del proyecto
   - Link directo a la aplicación
   - Tags o categorías temáticas
3. **Sistema de filtrado y búsqueda**:
   - Por autor
   - Por temática
   - Por fecha de creación
4. **Vista detallada** de cada aplicación con:
   - Iframe embebido o screenshot
   - Descripción completa
   - Tecnologías utilizadas
   - Link al código fuente (si está disponible)
5. **Sección de estadísticas** del curso:
   - Número total de proyectos
   - Estudiantes participantes
   - Visualizaciones interactivas de métricas

## 🎨 Identidad Visual y Branding

### Archivos de Referencia
- **Guía de marca**: `@imagen_de_marca_estacion_r/_brand.yml`
- **Logo**: Disponible en carpeta `imagen_de_marca_estacion_r/`
- **Portada del curso**: En carpeta `imagen_de_marca_estacion_r/`
- **Sitio web de referencia**: https://estacion-r.com/

### Elementos a Mantener
- Paleta de colores corporativa
- Tipografías definidas en _brand.yml
- Estilo visual consistente con el sitio web
- Logo en el header de la aplicación

## 📊 Fuente de Datos
- **Lista de aplicaciones**: `@lista_shinyapps.ods`
  - Este archivo contiene toda la información de las apps desarrolladas
  - Estructura esperada: [nombre_app, autor, url, descripción, categoría, fecha]

## 🛠️ Stack Tecnológico

### Paquetes Principales de R
```r
# Core
library(shiny)
library(bslib)  # Para theming Bootstrap 5

# UI/UX
library(shinydashboard) # Si prefieres dashboard layout
library(shinyWidgets)   # Widgets adicionales
library(htmltools)      # Manipulación HTML

# Datos
library(readODS)        # Para leer archivo .ods
library(dplyr)          # Manipulación de datos
library(DT)             # Tablas interactivas

# Visualización
library(ggplot2)        # Gráficos
library(plotly)         # Gráficos interactivos
```

## 📁 Estructura del Proyecto Sugerida
```
shiny-galeria-estacion-r/
├── app.R                 # Archivo principal Shiny
├── R/
│   ├── ui_modules.R     # Módulos de UI
│   ├── server_modules.R # Módulos de servidor
│   └── utils.R          # Funciones auxiliares
├── data/
│   └── apps_data.rds    # Datos procesados del .ods
├── www/
│   ├── css/
│   │   └── custom.css   # Estilos personalizados
│   ├── js/
│   │   └── custom.js    # JavaScript personalizado
│   └── img/
│       └── [logos e imágenes]
├── imagen_de_marca_estacion_r/
│   ├── _brand.yml
│   ├── logo.png
│   └── portada_curso.png
└── lista_shinyapps.ods
```

## 🎯 Criterios de Éxito
1. La aplicación debe cargar en menos de 3 segundos
2. Debe ser completamente responsive (móvil, tablet, desktop)
3. Navegación intuitiva sin necesidad de instrucciones
4. Todos los links a las apps deben funcionar correctamente
5. El diseño debe reflejar profesionalmente la marca Estación R

## 🚀 Funcionalidades para Versión Futura
- Sistema de votación/favoritos
- Comentarios en cada app
- Analytics de visitas
- Exportación de la galería a PDF
- Integración con redes sociales para compartir

## 📝 Notas Importantes para el Desarrollo

### Al comenzar:
1. Primero, leer y procesar el archivo `lista_shinyapps.ods`
2. Analizar la estructura de `_brand.yml` para extraer colores y tipografías
3. Revisar el sitio web de Estación R para captar el estilo visual

### Durante el desarrollo:
- Usar módulos de Shiny para mantener el código organizado
- Implementar reactive programming eficientemente
- Comentar el código en español para consistencia
- Hacer commits frecuentes con mensajes descriptivos

### Para testing:
- Probar con diferentes tamaños de pantalla
- Verificar todos los enlaces externos
- Testear filtros con diferentes combinaciones
- Validar rendimiento con todas las apps cargadas

## 🎨 Inspiración y Referencias
- Galería oficial de Shiny: https://shiny.rstudio.com/gallery/
- Shiny Contest submissions
- Material Design principles para cards y layouts

## 🔧 Configuración de Deployment
La app debe ser deployable en:
- shinyapps.io (preferido)
- Servidor propio con Shiny Server
- Docker container (opcional)

## 🤝 Colaboración con Claude Code
Cuando trabajes conmigo, por favor:
1. Comparte el contenido de los archivos mencionados cuando sea necesario
2. Especifica si prefieres algún estilo de código particular
3. Indica si hay limitaciones de hosting o recursos
4. Menciona si hay alguna app específica que debe destacarse

---
*Este documento sirve como guía principal para el desarrollo. Actualízalo conforme avance el proyecto.*