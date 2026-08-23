# scripts/update_screenshots.R
# Genera screenshots automáticos de las apps de alumnos usando webshot2.
# Convención de nombre: screenshot_{autor_normalizado}.png (misma que utils.R)
#
# Uso:
#   Rscript scripts/update_screenshots.R          # solo apps sin screenshot
#   Rscript scripts/update_screenshots.R --force  # regenera todas

library(webshot2)
library(readODS)
library(dplyr)

# -------------------------------------------------------------------
# Config
# -------------------------------------------------------------------

REPO_DIR   <- here::here()
IMG_DIR    <- file.path(REPO_DIR, "www", "img")
ODS_PATH   <- file.path(REPO_DIR, "lista_shinyapps.ods")
FORCE      <- "--force" %in% commandArgs(trailingOnly = TRUE)
DELAY_SEG  <- 4   # segundos de espera para que cargue la app
WIDTH      <- 1280
HEIGHT     <- 800

# -------------------------------------------------------------------
# Normalización de nombre (igual que utils.R)
# -------------------------------------------------------------------

normalizar_autor <- function(autor) {
  gsub("[^a-zA-Z0-9]", "_", tolower(autor))
}

# -------------------------------------------------------------------
# Leer datos
# -------------------------------------------------------------------

apps <- read_ods(ODS_PATH) %>%
  filter(!is.na(autor), !is.na(url), url != "") %>%
  mutate(
    filename = paste0("screenshot_", normalizar_autor(autor), ".png"),
    filepath = file.path(IMG_DIR, filename)
  )

cat(sprintf("Apps con URL: %d\n", nrow(apps)))

# -------------------------------------------------------------------
# Tomar screenshots
# -------------------------------------------------------------------

for (i in seq_len(nrow(apps))) {
  app <- apps[i, ]

  if (!FORCE && file.exists(app$filepath)) {
    cat(sprintf("  [skip] %s — ya existe\n", app$filename))
    next
  }

  cat(sprintf("  [screenshot] %s → %s\n", app$autor, app$url))

  tryCatch({
    webshot(
      url      = app$url,
      file     = app$filepath,
      delay    = DELAY_SEG,
      vwidth   = WIDTH,
      vheight  = HEIGHT,
      cliprect = c(0, 0, WIDTH, HEIGHT)
    )
    cat(sprintf("    ✓ guardado en %s\n", app$filename))
  }, error = function(e) {
    cat(sprintf("    ✗ error: %s\n", conditionMessage(e)))
  })
}

cat("\nListo.\n")
