# =============================================================================
# Script de Inicio Rápido - Galería de Apps Shiny Estación R
# =============================================================================
# Este script ejecuta la aplicación Shiny con opciones predeterminadas
# =============================================================================

# Limpiar consola
cat("\014")

# Banner
cat("\n")
cat("╔════════════════════════════════════════════════════════╗\n")
cat("║                                                        ║\n")
cat("║   GALERÍA DE APPS SHINY - ESTACIÓN R                   ║\n")
cat("║                                                        ║\n")
cat("╚════════════════════════════════════════════════════════╝\n")
cat("\n")

# Verificar paquetes necesarios
cat("Verificando dependencias...\n")

paquetes_requeridos <- c(
  "shiny", "bslib", "readODS", "dplyr",
  "htmltools", "shinyWidgets", "DT", "ggplot2", "plotly"
)

faltantes <- paquetes_requeridos[!sapply(paquetes_requeridos, requireNamespace, quietly = TRUE)]

if (length(faltantes) > 0) {
  cat("\n⚠️  Faltan paquetes necesarios:", paste(faltantes, collapse = ", "), "\n")
  cat("\nEjecuta primero:\n")
  cat("  source('install_dependencies.R')\n\n")
  stop("Instalación incompleta")
}

cat("✓ Todas las dependencias están instaladas\n\n")

# Verificar archivo de datos
if (!file.exists("lista_shinyapps.ods")) {
  stop("✗ No se encuentra el archivo 'lista_shinyapps.ods'")
}
cat("✓ Archivo de datos encontrado\n\n")

# Ejecutar la aplicación
cat("Iniciando aplicación Shiny...\n")
cat("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n")

# Opciones de la app
options(shiny.launch.browser = TRUE)  # Abrir en navegador automáticamente

# Ejecutar
shiny::runApp(
  appDir = "app.R",
  launch.browser = TRUE,
  host = "127.0.0.1",
  port = NULL  # Puerto automático
)
