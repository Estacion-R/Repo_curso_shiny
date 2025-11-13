# =============================================================================
# Script de Instalación de Dependencias
# Galería de Aplicaciones Shiny - Estación R
# =============================================================================

cat("Iniciando instalación de paquetes necesarios...\n\n")

# Lista de paquetes requeridos
paquetes_requeridos <- c(
  "shiny",          # Framework principal
  "bslib",          # Bootstrap 5 theming
  "readODS",        # Lectura de archivos .ods
  "dplyr",          # Manipulación de datos
  "htmltools",      # Herramientas HTML
  "shinyWidgets",   # Widgets adicionales
  "DT",             # Tablas interactivas
  "ggplot2",        # Gráficos
  "plotly"          # Gráficos interactivos
)

# Función para instalar paquetes faltantes
instalar_si_falta <- function(paquete) {
  if (!require(paquete, character.only = TRUE)) {
    cat(sprintf("Instalando %s...\n", paquete))
    install.packages(paquete, dependencies = TRUE)
    library(paquete, character.only = TRUE)
    cat(sprintf("✓ %s instalado correctamente\n\n", paquete))
  } else {
    cat(sprintf("✓ %s ya está instalado\n", paquete))
  }
}

# Instalar todos los paquetes
cat("======================================\n")
cat("Verificando paquetes necesarios...\n")
cat("======================================\n\n")

for (paquete in paquetes_requeridos) {
  instalar_si_falta(paquete)
}

cat("\n======================================\n")
cat("✓ Instalación completada!\n")
cat("======================================\n\n")

# Verificar que todo esté correcto
cat("Verificando versiones instaladas:\n\n")

for (paquete in paquetes_requeridos) {
  version <- packageVersion(paquete)
  cat(sprintf("  %s: %s\n", paquete, version))
}

cat("\n¡Listo! Ahora puedes ejecutar la aplicación con:\n")
cat("  shiny::runApp('app.R')\n\n")
