# =============================================================================
# Funciones Auxiliares - Galería de Apps Shiny Estación R
# =============================================================================

library(shiny)
library(htmltools)

# Cargar y procesar datos de aplicaciones ------------------------------------

load_apps_data <- function(file_path) {
  if (!file.exists(file_path)) {
    stop("No se encontró el archivo: ", file_path)
  }

  readODS::read_ods(file_path) %>%
    mutate(
      categoria = if ("categoria" %in% names(.)) as.factor(categoria) else factor("General")
    ) %>%
    filter(!is.na(nombre_app) | !is.na(autor))
}

# Helpers compartidos ---------------------------------------------------------

is_na_or_empty <- function(x) {
  is.null(x) || length(x) == 0 || (length(x) == 1 && (is.na(x) || x == ""))
}

`%||%` <- function(a, b) if (!is.null(a)) a else b

# Tarjeta de app (panel "Apps del Curso") -------------------------------------

create_app_card_minimal <- function(app_info) {

  img_filename <- paste0("img/screenshot_", gsub("[^a-zA-Z0-9]", "_", tolower(app_info$autor %||% "")), ".png")
  img_exists   <- file.exists(file.path("www", img_filename))

  div(
    class = "app-card-minimal",

    if (img_exists) {
      tags$a(
        href   = app_info$url %||% "#",
        target = "_blank",
        tags$img(
          src   = img_filename,
          class = "app-screenshot",
          alt   = paste("Screenshot de", app_info$nombre_app %||% "la app")
        )
      )
    },

    h3(class = "app-nombre", app_info$nombre_app %||% "Sin nombre"),

    p(class = "app-autor", app_info$autor %||% "Autor desconocido"),

    if (!is.null(app_info$categoria) && !is.na(app_info$categoria)) {
      div(class = "app-categoria",
        tags$span(class = "categoria-badge", app_info$categoria)
      )
    },

    if (!is.null(app_info$descripcion) && !is.na(app_info$descripcion) && app_info$descripcion != "") {
      p(class = "app-descripcion", app_info$descripcion)
    },

    if (!is.null(app_info$url) && !is.na(app_info$url) && app_info$url != "") {
      tags$a(href = app_info$url, target = "_blank", class = "app-link", "Ver aplicación →")
    } else {
      tags$span(class = "app-link-disabled", "URL no disponible")
    }
  )
}

# Tabla de apps (panel "Tabla") -----------------------------------------------

create_apps_datatable_minimal <- function(data) {

  table_data <- data %>%
    select(any_of(c("nombre_app", "autor", "categoria", "url"))) %>%
    mutate(
      url = ifelse(
        is.na(url) | url == "",
        "—",
        sprintf('<a href="%s" target="_blank" class="table-link">Ver app →</a>', url)
      )
    )

  DT::datatable(
    table_data,
    options = list(
      pageLength = 10,
      lengthMenu = c(5, 10, 25, 50),
      language = list(
        search      = "Buscar:",
        lengthMenu  = "Mostrar _MENU_ apps",
        info        = "Mostrando _START_ a _END_ de _TOTAL_ apps",
        infoEmpty   = "No hay apps para mostrar",
        infoFiltered = "(filtrado de _MAX_ apps totales)",
        zeroRecords = "No se encontraron apps",
        paginate    = list(previous = "←", `next` = "→")
      ),
      dom = 'lrtip'
    ),
    escape   = FALSE,
    rownames = FALSE,
    class    = 'display table-minimal',
    colnames = c("Nombre" = "nombre_app", "Autor" = "autor", "Categoría" = "categoria", "Link" = "url")
  ) %>%
    DT::formatStyle(columns = 1:ncol(table_data), fontFamily = 'Ubuntu')
}

# Sección "Hecho en Shiny" ----------------------------------------------------

parse_tags <- function(tags_string) {
  if (is_na_or_empty(tags_string)) return(character(0))
  trimws(strsplit(as.character(tags_string), ",")[[1]])
}

load_inspiracion_data <- function(file_path = "lista_inspiracion.ods") {
  if (!file.exists(file_path)) {
    return(data.frame(
      nombre_app  = character(),
      autor       = character(),
      descripcion = character(),
      tipo        = character(),
      url_app     = character(),
      url_github  = character(),
      tags        = character(),
      stringsAsFactors = FALSE
    ))
  }
  readODS::read_ods(file_path) %>%
    filter(!is.na(nombre_app), nombre_app != "", !startsWith(nombre_app, "EJEMPLO"))
}

create_inspiracion_card <- function(app_info) {
  tag_items <- parse_tags(app_info$tags)

  div(
    class = "app-card-minimal inspiracion-card",

    if (!is_na_or_empty(app_info$tipo)) {
      div(class = "app-categoria",
        tags$span(class = "categoria-badge", as.character(app_info$tipo))
      )
    },

    h3(class = "app-nombre", app_info$nombre_app %||% "Sin nombre"),

    if (!is_na_or_empty(app_info$autor)) {
      p(class = "app-autor", as.character(app_info$autor))
    },

    if (!is_na_or_empty(app_info$descripcion)) {
      p(class = "app-descripcion", as.character(app_info$descripcion))
    },

    if (length(tag_items) > 0) {
      div(class = "app-tags",
        lapply(tag_items, function(t) tags$span(class = "tag-badge", t))
      )
    },

    div(
      class = "app-links",
      if (!is_na_or_empty(app_info$url_app)) {
        tags$a(href = as.character(app_info$url_app), target = "_blank", class = "app-link", "Ver app →")
      } else {
        tags$span(class = "app-link-disabled", "Sin URL")
      },
      if (!is_na_or_empty(app_info$url_github)) {
        tags$a(href = as.character(app_info$url_github), target = "_blank", class = "github-link",
          icon("github"), " Código")
      }
    )
  )
}
