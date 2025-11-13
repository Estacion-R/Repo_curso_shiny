# Historial de Desarrollo - Galería Apps Shiny Estación R

## Resumen de la Sesión

Este documento contiene el historial completo del desarrollo de la aplicación Shiny para mostrar las apps del curso de Estación R.

---

## VERSIÓN 1: Estructura Inicial (Completa)

### Archivos Creados
- `app.R` - Aplicación completa con 4 paneles (Inicio, Galería, Estadísticas, Acerca de)
- `R/utils.R` - Funciones auxiliares
- `R/ui_modules.R` - Módulos de UI
- `R/server_modules.R` - Módulos de servidor
- `www/css/custom.css` - Estilos con colores de Estación R
- `www/js/custom.js` - JavaScript personalizado
- `README.md` - Documentación completa
- `install_dependencies.R` - Script de instalación
- `test_app.R` - Script de pruebas

### Características
- 4 páginas completas
- Estadísticas con gráficos
- Filtros de búsqueda
- Tema personalizado con colores de Estación R
- 9 paquetes de dependencias

### Estado
✅ Completada y funcionando

---

## VERSIÓN 2: Minimalista (Completa)

### Cambios Realizados

#### 1. Simplificación Total
- De 4 páginas → 1 página
- Eliminadas estadísticas y gráficos
- Solo grid de tarjetas de apps
- De 307 líneas → 100 líneas en app.R

#### 2. Nueva Paleta de Colores (4 colores)
```
Azul:     #405BFF  (botones, links, hover)
Amarillo: #EAFF38  (sombras, badges)
Blanco:   #FFFFFF  (fondo)
Negro:    #000000  (texto, bordes)
```

#### 3. Tipografía
- Fuente única: **Ubuntu** (Google Fonts)
- Pesos: 400 (regular), 500 (medium), 700 (bold)

#### 4. Estilo Visual
- Diseño "brutalista" minimalista
- Bordes negros sólidos de 2-3px
- Sombras amarillas al hover (sin blur)
- Sin gradientes, colores planos

#### 5. Dependencias Reducidas
- De 9 paquetes → 5 paquetes
- Eliminados: `shinyWidgets`, `DT`, `ggplot2`, `plotly`
- Mantenidos: `shiny`, `bslib`, `readODS`, `dplyr`, `htmltools`

### Archivos Principales
- `app.R` - Simplificado (100 líneas)
- `R/utils.R` - Nueva función `create_app_card_minimal()`
- `www/css/custom.css` - Reescrito completamente (233 líneas)
- `VERSION_MINIMALISTA.md` - Documentación de cambios

### Estado
✅ Completada y funcionando

---

## VERSIÓN 3: Dos Páginas + Mejoras (Completa - ACTUAL)

### Cambios Realizados

#### 1. Segunda Página: Tabla de Búsqueda
- Nueva pestaña "Tabla" en navbar
- Tabla interactiva con DataTables
- **3 Filtros de búsqueda**:
  - Búsqueda por texto (nombre o autor)
  - Filtro por categoría
  - Filtro por autor
- Paginación personalizada
- Estilo minimalista coherente

#### 2. Header Mejorado en Página Principal

##### Imagen de Portada
- Ubicada a la derecha del título
- Borde negro de 3px
- Sombra amarilla (6px x 6px)
- Efecto hover: se eleva y aumenta sombra a 8px

##### Nuevo Título y Subtítulo
- **Título**: "Estación Shiny + R" (en lugar de "Galería de Apps Shiny")
- **Subtítulo**: "Aplicaciones desarrolladas en el curso de [Estación R](https://estacion-r.com/) ["🖥️ Introducción a Shiny: construí tus primeros dashboards con R"](https://estacion-r.com/courses)"

##### Hipervínculos
- "Estación R" → https://estacion-r.com/ (abre en nueva pestaña)
- Nombre del curso → https://estacion-r.com/courses (abre en nueva pestaña)
- Estilo: subrayado amarillo al hover

#### 3. Navegación
- Cambió de `page_fluid` a `page_navbar`
- 2 pestañas: **Galería** (🗂️) y **Tabla** (📊)
- Tabs con estilo minimalista
- Color azul para tab activo

#### 4. Nueva Función en R/utils.R
```r
create_apps_datatable_minimal(data)
```
- Crea tabla con estilo minimalista
- Maneja URLs que pueden ser NA
- Traducciones al español
- Fuente Ubuntu
- Personalización de columnas

#### 5. Nuevos Estilos CSS
- `.link-estacion`, `.link-curso` - Links con hover amarillo
- `.img-portada` - Imagen con borde y sombra
- `.table-minimal` - Tabla con bordes negros
- `.form-control`, `.form-select` - Filtros estilizados
- `.nav-link` - Tabs del navbar
- DataTables personalizado

### Archivos Actualizados
- `app.R` - 262 líneas (de 100)
- `R/utils.R` - +función `create_apps_datatable_minimal()`
- `www/css/custom.css` - +160 líneas de estilos
- `CAMBIOS_V2.md` - Documentación completa

### Dependencias Actuales
6 paquetes:
- `shiny`
- `bslib`
- `readODS`
- `dplyr`
- `htmltools`
- `DT` (agregado de vuelta para DataTables)

### Estado
✅ Completada y funcionando

---

## PRÓXIMO PASO: Screenshots Automáticos (Pendiente)

### Plan: Opción 1 - Automática con webshot2

El usuario eligió implementar captura automática de screenshots de las apps usando el paquete `webshot2`.

#### Implementación Planificada

1. **Instalar webshot2**
```r
install.packages("webshot2")
```

2. **Crear función en R/utils.R**
```r
capture_app_screenshot <- function(url, filename) {
  # Capturar screenshot si no existe
  # Guardar en www/img/screenshots/
  # Retornar path a la imagen
}
```

3. **Modificar create_app_card_minimal()**
- Agregar imagen encima del nombre
- Usar placeholder si falla la captura
- Lazy loading de imágenes

4. **Actualizar CSS**
- Estilos para las imágenes en tarjetas
- Borde negro + efecto hover
- Aspect ratio consistente

#### Consideraciones Técnicas

**Ventajas:**
- Totalmente automático
- Se actualiza si cambia la URL
- No requiere trabajo manual

**Desafíos:**
- Requiere Chrome/Chromium instalado
- Toma tiempo al cargar primera vez
- Algunas apps pueden requerir autenticación
- Necesita manejar errores (apps caídas, sin URL, etc.)

#### Estructura de Carpetas Sugerida
```
www/
├── img/
│   ├── screenshots/
│   │   ├── app1.png
│   │   ├── app2.png
│   │   └── placeholder.png
│   ├── logo_estacion_r_ancho.png
│   └── portada_curso.png
```

#### Código Inicial Propuesto

```r
# En R/utils.R

#' Capturar screenshot de una app Shiny
#' @param url URL de la app
#' @param filename Nombre del archivo (sin extensión)
#' @export
capture_app_screenshot <- function(url, filename) {

  if(is.na(url) || url == "") {
    return("img/screenshots/placeholder.png")
  }

  screenshot_path <- file.path("www/img/screenshots", paste0(filename, ".png"))

  # Si ya existe, no volver a capturar
  if(file.exists(screenshot_path)) {
    return(gsub("www/", "", screenshot_path))
  }

  # Crear directorio si no existe
  dir.create("www/img/screenshots", showWarnings = FALSE, recursive = TRUE)

  tryCatch({
    webshot2::webshot(
      url = url,
      file = screenshot_path,
      vwidth = 1200,
      vheight = 800,
      cliprect = "viewport",
      delay = 2  # Esperar 2 segundos para que cargue
    )
    return(gsub("www/", "", screenshot_path))
  }, error = function(e) {
    message("Error capturando screenshot de ", url, ": ", e$message)
    return("img/screenshots/placeholder.png")
  })
}

#' Generar screenshots de todas las apps al inicio
#' @export
generate_all_screenshots <- function(apps_data) {

  message("Generando screenshots...")

  for(i in 1:nrow(apps_data)) {
    if(!is.na(apps_data$url[i]) && apps_data$url[i] != "") {
      filename <- gsub("[^[:alnum:]]", "_", apps_data$nombre_app[i])
      capture_app_screenshot(apps_data$url[i], filename)
      message(sprintf("  %d/%d: %s", i, nrow(apps_data), apps_data$nombre_app[i]))
    }
  }

  message("Screenshots generados!")
}
```

#### Modificación de create_app_card_minimal()

```r
create_app_card_minimal <- function(app_info) {

  # Generar nombre de archivo
  filename <- gsub("[^[:alnum:]]", "_", app_info$nombre_app %||% "sin_nombre")
  screenshot_path <- sprintf("img/screenshots/%s.png", filename)

  div(
    class = "app-card-minimal",

    # Screenshot de la app
    div(
      class = "app-screenshot",
      img(
        src = screenshot_path,
        alt = app_info$nombre_app,
        onerror = "this.src='img/screenshots/placeholder.png'"
      )
    ),

    # Nombre de la app
    h3(
      class = "app-nombre",
      app_info$nombre_app %||% "Sin nombre"
    ),

    # ... resto del código igual
  )
}
```

#### CSS para Screenshots

```css
/* Screenshot en tarjeta */
.app-screenshot {
  width: 100%;
  height: 200px;
  overflow: hidden;
  border-bottom: 2px solid var(--color-negro);
  margin-bottom: 1rem;
  background-color: #f5f5f5;
}

.app-screenshot img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.app-card-minimal:hover .app-screenshot img {
  transform: scale(1.05);
}
```

---

## Estructura Actual del Proyecto

```
Repo_curso_shiny/
├── app.R                          # App con 2 páginas (Galería + Tabla)
├── R/
│   ├── utils.R                    # Funciones auxiliares
│   ├── ui_modules.R              # Módulos UI (no usados en v3)
│   └── server_modules.R          # Módulos servidor (no usados en v3)
├── www/
│   ├── css/
│   │   └── custom.css            # Estilos minimalistas (422 líneas)
│   ├── js/
│   │   └── custom.js             # JS básico
│   └── img/
│       ├── logo_estacion_r_ancho.png
│       ├── logo_estacion_r_largo.png
│       └── portada_curso.png
├── data/                          # (vacío)
├── imagen_de_marca_estacion_r/
│   ├── _brand.yml                # Colores originales Estación R
│   └── [imágenes de marca]
├── lista_shinyapps.ods           # 6 apps
├── README.md                      # Documentación general
├── VERSION_MINIMALISTA.md         # Docs versión 2
├── CAMBIOS_V2.md                 # Docs versión 3
├── EJECUTAR.md                   # Instrucciones de ejecución
├── install_dependencies.R         # Instalador de paquetes
├── test_app.R                    # Tests
└── run_app.R                     # Inicio rápido
```

---

## Datos Actuales

### Archivo: lista_shinyapps.ods

**Estructura de columnas:**
- `nombre_app` (realmente tiene el autor)
- `autora` (realmente tiene el nombre)
- `descripcion`
- `url`
- `categoria`

**Nota:** Las columnas están invertidas, pero `utils.R` las renombra automáticamente.

**Contenido:** 6 aplicaciones

---

## Paleta de Colores Final

```css
:root {
  --color-azul: #405BFF;      /* Links, botones, hover */
  --color-amarillo: #EAFF38;  /* Sombras, highlights */
  --color-blanco: #FFFFFF;    /* Fondo */
  --color-negro: #000000;     /* Texto, bordes */
}
```

---

## Comandos Útiles

### Ejecutar la app
```r
shiny::runApp("app.R")
```

### Verificar sintaxis
```r
source("test_app.R")
```

### Instalar dependencias
```r
source("install_dependencies.R")
```

---

## Estado Actual

**Versión:** 3 (Dos páginas + Mejoras)
**Estado:** ✅ Funcionando completamente
**Próximo paso:** Implementar screenshots automáticos con webshot2

---

## Notas Importantes

1. **Bug conocido:** Las columnas del archivo ODS están invertidas, pero se manejan automáticamente en `load_apps_data()`

2. **URLs con NA:** Algunas apps no tienen URL, se muestra "URL no disponible"

3. **Responsive:** La app funciona en desktop, tablet y mobile

4. **Paquete DT:** Se volvió a agregar en v3 para la tabla interactiva

5. **ChromeDriver:** Para implementar screenshots con webshot2, se necesitará Chrome/Chromium instalado en el sistema

---

## Para Continuar en el Futuro

### Implementar Screenshots Automáticos:

1. Instalar webshot2:
```r
install.packages("webshot2")
```

2. Crear carpeta para screenshots:
```bash
mkdir -p www/img/screenshots
```

3. Crear placeholder:
- Crear imagen `www/img/screenshots/placeholder.png` (500x300px)
- Fondo blanco con borde negro
- Texto "Sin preview"

4. Agregar funciones de captura a `R/utils.R`

5. Modificar `create_app_card_minimal()` para incluir imágenes

6. Actualizar CSS con estilos para screenshots

7. Opcional: Agregar botón "Actualizar screenshots" en la app

---

**Última actualización:** 2025-10-23
**Desarrollado con:** Claude Code
**Contacto:** Estación R - https://estacion-r.com/
