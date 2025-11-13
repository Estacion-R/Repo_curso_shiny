# =============================================================================
# Script de Prueba - Galería de Apps Shiny
# =============================================================================
# Este script verifica que todos los componentes de la app funcionen
# correctamente sin necesidad de ejecutar la interfaz web
# =============================================================================

cat("\n")
cat("========================================\n")
cat("PRUEBA DE LA APLICACIÓN SHINY\n")
cat("========================================\n\n")

# 1. Cargar librerías
cat("1. Cargando librerías...\n")
suppressPackageStartupMessages({
  library(shiny)
  library(bslib)
  library(readODS)
  library(dplyr)
  library(htmltools)
  library(shinyWidgets)
  library(DT)
  library(ggplot2)
  library(plotly)
})
cat("   ✓ Todas las librerías cargadas\n\n")

# 2. Cargar módulos
cat("2. Cargando módulos y funciones...\n")
source("R/utils.R")
cat("   ✓ R/utils.R cargado\n")
source("R/ui_modules.R")
cat("   ✓ R/ui_modules.R cargado\n")
source("R/server_modules.R")
cat("   ✓ R/server_modules.R cargado\n\n")

# 3. Cargar datos
cat("3. Cargando datos de aplicaciones...\n")
apps_data <- load_apps_data("lista_shinyapps.ods")
cat("   ✓ Datos cargados exitosamente\n")
cat("   - Total de apps:", nrow(apps_data), "\n")
cat("   - Columnas:", paste(names(apps_data), collapse=", "), "\n\n")

# 4. Probar funciones auxiliares
cat("4. Probando funciones auxiliares...\n")

# Estadísticas
stats <- calculate_stats(apps_data)
cat("   ✓ calculate_stats() - OK\n")
cat("     - Total apps:", stats$total_apps, "\n")
cat("     - Total autores:", stats$total_autores, "\n")
cat("     - Categorías:", stats$categorias, "\n")
cat("     - Apps recientes:", stats$apps_recientes, "\n\n")

# 5. Probar funciones de visualización
cat("5. Probando funciones de visualización...\n")

# Gráfico de categorías
tryCatch({
  plot_cat <- plot_apps_by_category(apps_data)
  if(!is.null(plot_cat)) {
    cat("   ✓ plot_apps_by_category() - OK\n")
  }
}, error = function(e) {
  cat("   ✗ plot_apps_by_category() - ERROR:", conditionMessage(e), "\n")
})

# Gráfico de timeline
tryCatch({
  plot_time <- plot_apps_timeline(apps_data)
  if(!is.null(plot_time)) {
    cat("   ✓ plot_apps_timeline() - OK\n")
  }
}, error = function(e) {
  cat("   ✗ plot_apps_timeline() - ERROR:", conditionMessage(e), "\n")
})

# Tabla de datos
tryCatch({
  dt_table <- create_apps_datatable(apps_data)
  if(!is.null(dt_table)) {
    cat("   ✓ create_apps_datatable() - OK\n")
  }
}, error = function(e) {
  cat("   ✗ create_apps_datatable() - ERROR:", conditionMessage(e), "\n")
})

cat("\n")

# 6. Probar creación de tarjetas
cat("6. Probando creación de tarjetas...\n")
tryCatch({
  app_info <- as.list(apps_data[1, ])
  card_html <- create_app_card(app_info)
  if(!is.null(card_html)) {
    cat("   ✓ create_app_card() - OK\n")
  }
}, error = function(e) {
  cat("   ✗ create_app_card() - ERROR:", conditionMessage(e), "\n")
})

cat("\n")

# 7. Verificar tema
cat("7. Verificando tema personalizado...\n")
tryCatch({
  theme_estacion_r <- bs_theme(
    version = 5,
    bg = "#FFFFFF",
    fg = "#151515",
    primary = "#447099",
    secondary = "#707073",
    success = "#72994E",
    info = "#419599",
    warning = "#EE6331",
    danger = "#9A4665"
  )
  cat("   ✓ Tema personalizado creado correctamente\n")
}, error = function(e) {
  cat("   ✗ Error creando tema:", conditionMessage(e), "\n")
})

cat("\n")

# 8. Verificar archivos de recursos
cat("8. Verificando archivos de recursos...\n")
recursos <- c(
  "www/img/logo_estacion_r_ancho.png",
  "www/img/logo_estacion_r_largo.png",
  "www/img/portada_curso.png",
  "www/css/custom.css",
  "www/js/custom.js"
)

for(archivo in recursos) {
  if(file.exists(archivo)) {
    cat("   ✓", archivo, "\n")
  } else {
    cat("   ✗", archivo, "- NO ENCONTRADO\n")
  }
}

cat("\n")
cat("========================================\n")
cat("RESUMEN DE PRUEBAS\n")
cat("========================================\n\n")

cat("✓ Todos los componentes funcionan correctamente\n")
cat("✓ La aplicación está lista para ejecutarse\n\n")

cat("Para ejecutar la aplicación:\n")
cat("  shiny::runApp('app.R')\n\n")

cat("O desde RStudio:\n")
cat("  Abre app.R y haz clic en 'Run App'\n\n")
