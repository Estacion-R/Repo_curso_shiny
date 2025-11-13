# Cómo Ejecutar la Galería (Versión Minimalista)

## Método 1: Desde RStudio (Más Fácil)

1. Abre RStudio
2. Abre el archivo `app.R`
3. Verás un botón "Run App" en la esquina superior derecha
4. Haz clic en "Run App"
5. La aplicación se abrirá en una ventana o en tu navegador

## Método 2: Desde la Consola de R

```r
# Navega al directorio del proyecto
setwd("/home/pablote/Pablo/Estación R/Proyectos/Repo_curso_shiny")

# Ejecuta la app
shiny::runApp("app.R")
```

## Método 3: Script de Inicio Rápido

```r
source("run_app.R")
```

## Si Es la Primera Vez

Si es la primera vez que ejecutas la app, verifica que tengas los paquetes:

```r
# Verificar paquetes
paquetes <- c("shiny", "bslib", "readODS", "dplyr", "htmltools")
faltantes <- paquetes[!sapply(paquetes, requireNamespace, quietly = TRUE)]

if(length(faltantes) > 0) {
  install.packages(faltantes)
}
```

## Cerrar la Aplicación

- **En RStudio**: Haz clic en el botón "Stop" (cuadrado rojo)
- **En la consola**: Presiona `Ctrl + C` o `Esc`

## Vista Previa

Una vez ejecutada, verás:

```
Galería de Apps Shiny
Curso de Introducción a Shiny - Estación R

┌─────────┐  ┌─────────┐  ┌─────────┐
│  App 1  │  │  App 2  │  │  App 3  │
│ Autor   │  │ Autor   │  │ Autor   │
│ [Cat]   │  │ [Cat]   │  │ [Cat]   │
│ Desc... │  │ Desc... │  │ Desc... │
│ [Ver →] │  │ [Ver →] │  │ [Ver →] │
└─────────┘  └─────────┘  └─────────┘
```

## Solución de Problemas

### Error: "No se encuentra el archivo"
```r
# Verifica que estás en el directorio correcto
getwd()

# Debería mostrar: .../Repo_curso_shiny
# Si no, usa:
setwd("/ruta/correcta/a/Repo_curso_shiny")
```

### Error: "Package 'X' not found"
```r
# Instala el paquete faltante
install.packages("nombre_del_paquete")
```

### Error: "lista_shinyapps.ods not found"
Verifica que el archivo `lista_shinyapps.ods` esté en el directorio raíz del proyecto.

## Personalización Rápida

### Cambiar Título

En `app.R`, línea 44:
```r
h1("Tu Título Aquí", class = "titulo-principal")
```

### Cambiar Subtítulo

En `app.R`, línea 45:
```r
p("Tu subtítulo aquí", class = "subtitulo")
```

### Cambiar Colores

En `www/css/custom.css`, líneas 6-10:
```css
:root {
  --color-azul: #TuColorAqui;
  --color-amarillo: #TuColorAqui;
  --color-blanco: #FFFFFF;
  --color-negro: #000000;
}
```

---

**¡Listo para ejecutar! 🚀**
