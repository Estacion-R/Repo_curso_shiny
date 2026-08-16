# =============================================================================
# Funciones Auxiliares - Galería de Apps Shiny Estación R
# =============================================================================

library(shiny)
library(htmltools)

# Cargar y procesar datos de aplicaciones ------------------------------------

#' Cargar datos de aplicaciones desde archivo ODS
#'
#' @param file_path Ruta al archivo .ods con la lista de apps
#' @return Data frame con los datos procesados
#' @export
load_apps_data <- function(file_path) {

  # Leer archivo ODS
  if (!file.exists(file_path)) {
    stop("No se encontró el archivo: ", file_path)
  }

  apps_raw <- readODS::read_ods(file_path)

  # Procesar y limpiar datos
  apps_data <- apps_raw

  # Renombrar columnas si están invertidas (autora en lugar de autor)
  if("autora" %in% names(apps_data)) {
    # Los datos están invertidos: nombre_app tiene el autor y autora tiene el nombre
    apps_data <- apps_data %>%
      rename(
        autor = nombre_app,
        nombre_app = autora
      )
  }

  apps_data <- apps_data %>%
    mutate(
      # Convertir fecha si es necesaria
      fecha = if("fecha" %in% names(.)) as.Date(fecha) else Sys.Date(),
      # Asegurar que las categorías sean factores
      categoria = if("categoria" %in% names(.)) as.factor(categoria) else factor("General")
    ) %>%
    # Filtrar filas vacías si las hay
    filter(!is.na(nombre_app) | !is.na(autor))

  return(apps_data)
}

# Funciones de visualización -------------------------------------------------

#' Crear gráfico de apps por categoría
#'
#' @param data Data frame con información de apps
#' @return Objeto plotly
#' @export
plot_apps_by_category <- function(data) {

  if(!"categoria" %in% names(data)) {
    return(NULL)
  }

  summary_data <- data %>%
    count(categoria, name = "n_apps") %>%
    arrange(desc(n_apps))

  p <- ggplot(summary_data, aes(x = reorder(categoria, n_apps), y = n_apps, fill = categoria)) +
    geom_col(show.legend = FALSE) +
    coord_flip() +
    labs(
      x = NULL,
      y = "Número de Apps",
      title = NULL
    ) +
    theme_minimal(base_size = 14) +
    scale_fill_brewer(palette = "Set2")

  ggplotly(p, tooltip = c("y")) %>%
    layout(hovermode = "closest")
}

#' Crear gráfico de línea temporal de apps
#'
#' @param data Data frame con información de apps
#' @return Objeto plotly
#' @export
plot_apps_timeline <- function(data) {

  if(!"fecha" %in% names(data)) {
    return(NULL)
  }

  summary_data <- data %>%
    mutate(mes = format(fecha, "%Y-%m")) %>%
    count(mes, name = "n_apps") %>%
    arrange(mes)

  p <- ggplot(summary_data, aes(x = mes, y = n_apps, group = 1)) +
    geom_line(color = "#447099", linewidth = 1.2) +
    geom_point(color = "#447099", size = 3) +
    labs(
      x = "Mes",
      y = "Número de Apps",
      title = NULL
    ) +
    theme_minimal(base_size = 14) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

  ggplotly(p, tooltip = c("x", "y")) %>%
    layout(hovermode = "closest")
}

#' Crear tabla interactiva de apps
#'
#' @param data Data frame con información de apps
#' @return Objeto DT
#' @export
create_apps_datatable <- function(data) {

  # Seleccionar columnas relevantes
  table_data <- data %>%
    select(any_of(c("nombre_app", "autor", "categoria", "fecha", "url")))

  # Crear enlaces clickeables si existe columna url
  if("url" %in% names(table_data)) {
    table_data <- table_data %>%
      mutate(
        url = ifelse(
          is.na(url) | url == "",
          "No disponible",
          sprintf('<a href="%s" target="_blank">Ver App</a>', url)
        )
      )
  }

  datatable(
    table_data,
    options = list(
      pageLength = 10,
      language = list(
        search = "Buscar:",
        lengthMenu = "Mostrar _MENU_ apps por página",
        info = "Mostrando _START_ a _END_ de _TOTAL_ apps",
        paginate = list(
          previous = "Anterior",
          `next` = "Siguiente"
        )
      )
    ),
    escape = FALSE,  # Para permitir HTML en la columna url
    rownames = FALSE,
    colnames = c(
      "Nombre" = "nombre_app",
      "Autor" = "autor",
      "Categoría" = "categoria",
      "Fecha" = "fecha",
      "Link" = "url"
    )
  )
}

# Funciones auxiliares de UI --------------------------------------------------

#' Crear tarjeta de app individual
#'
#' @param app_info Lista con información de una app (nombre, autor, url, etc.)
#' @return HTML de la tarjeta
#' @export
create_app_card <- function(app_info) {

  card(
    height = "100%",
    card_header(
      class = "fw-bold",
      app_info$nombre_app %||% "Sin nombre"
    ),
    card_body(
      p(
        icon("user"),
        strong("Autor: "),
        app_info$autor %||% "Desconocido"
      ),
      if(!is.null(app_info$descripcion) && !is.na(app_info$descripcion) && app_info$descripcion != "") {
        p(app_info$descripcion)
      },
      if(!is.null(app_info$categoria) && !is.na(app_info$categoria)) {
        p(
          tags$span(
            class = "badge bg-primary",
            app_info$categoria
          )
        )
      }
    ),
    card_footer(
      if(!is.null(app_info$url) && !is.na(app_info$url) && app_info$url != "") {
        tags$a(
          href = app_info$url,
          target = "_blank",
          class = "btn btn-sm btn-outline-primary",
          icon("external-link-alt"),
          "Ver App"
        )
      } else {
        tags$span(class = "text-muted", "URL no disponible")
      }
    )
  )
}

#' Calcular estadísticas generales
#'
#' @param data Data frame con información de apps
#' @return Lista con estadísticas
#' @export
calculate_stats <- function(data) {

  stats <- list(
    total_apps = nrow(data),
    total_autores = length(unique(data$autor)),
    categorias = if("categoria" %in% names(data)) length(unique(data$categoria)) else 0,
    apps_recientes = if("fecha" %in% names(data)) {
      sum(data$fecha >= Sys.Date() - 30, na.rm = TRUE)
    } else {
      0
    }
  )

  return(stats)
}

#' Operador %||% para valores por defecto
#'
#' @param a Primer valor
#' @param b Valor por defecto
#' @return a si no es NULL, b en caso contrario
`%||%` <- function(a, b) {
  if (!is.null(a)) a else b
}

# Helpers compartidos ---------------------------------------------------------

is_na_or_empty <- function(x) {
  is.null(x) || length(x) == 0 || (length(x) == 1 && (is.na(x) || x == ""))
}

# Versión Minimalista ---------------------------------------------------------

#' Crear tarjeta de app individual - Versión Minimalista
#'
#' @param app_info Lista con información de una app (nombre, autor, url, etc.)
#' @return HTML de la tarjeta minimalista
#' @export
create_app_card_minimal <- function(app_info) {

  div(
    class = "app-card-minimal",

    # Nombre de la app
    h3(
      class = "app-nombre",
      app_info$nombre_app %||% "Sin nombre"
    ),

    # Autor
    p(
      class = "app-autor",
      app_info$autor %||% "Autor desconocido"
    ),

    # Categoría
    if(!is.null(app_info$categoria) && !is.na(app_info$categoria)) {
      div(
        class = "app-categoria",
        tags$span(
          class = "categoria-badge",
          app_info$categoria
        )
      )
    },

    # Descripción
    if(!is.null(app_info$descripcion) && !is.na(app_info$descripcion) && app_info$descripcion != "") {
      p(
        class = "app-descripcion",
        app_info$descripcion
      )
    },

    # Link a la app
    if(!is.null(app_info$url) && !is.na(app_info$url) && app_info$url != "") {
      tags$a(
        href = app_info$url,
        target = "_blank",
        class = "app-link",
        "Ver aplicación →"
      )
    } else {
      tags$span(class = "app-link-disabled", "URL no disponible")
    }
  )
}

#' Crear tabla minimalista de aplicaciones con DataTables
#'
#' @param data Data frame con información de apps
#' @return Objeto DT con estilo minimalista
#' @export
create_apps_datatable_minimal <- function(data) {

  # Seleccionar columnas relevantes
  table_data <- data %>%
    select(any_of(c("nombre_app", "autor", "categoria", "url")))

  # Crear enlaces clickeables si existe columna url
  if("url" %in% names(table_data)) {
    table_data <- table_data %>%
      mutate(
        url = ifelse(
          is.na(url) | url == "",
          "—",
          sprintf('<a href="%s" target="_blank" class="table-link">Ver app →</a>', url)
        )
      )
  }

  datatable(
    table_data,
    options = list(
      pageLength = 10,
      lengthMenu = c(5, 10, 25, 50),
      language = list(
        search = "Buscar:",
        lengthMenu = "Mostrar _MENU_ apps",
        info = "Mostrando _START_ a _END_ de _TOTAL_ apps",
        infoEmpty = "No hay apps para mostrar",
        infoFiltered = "(filtrado de _MAX_ apps totales)",
        zeroRecords = "No se encontraron apps",
        paginate = list(
          previous = "←",
          `next` = "→"
        )
      ),
      dom = 'lrtip'  # Quitar el buscador por defecto (usamos filtros propios)
    ),
    escape = FALSE,
    rownames = FALSE,
    class = 'display table-minimal',
    colnames = c(
      "Nombre" = "nombre_app",
      "Autor" = "autor",
      "Categoría" = "categoria",
      "Link" = "url"
    )
  ) %>%
    formatStyle(
      columns = 1:ncol(table_data),
      fontFamily = 'Ubuntu'
    )
}

# Sección "Hecho en Shiny" ----------------------------------------------------

#' Parsear string de tags separados por coma a vector de caracteres
parse_tags <- function(tags_string) {
  if (is_na_or_empty(tags_string)) return(character(0))
  trimws(strsplit(as.character(tags_string), ",")[[1]])
}

#' Cargar datos de inspiración desde ODS
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
  data <- readODS::read_ods(file_path)
  data %>%
    filter(!is.na(nombre_app), nombre_app != "", !startsWith(nombre_app, "EJEMPLO"))
}

#' Crear tarjeta para sección "Hecho en Shiny"
#'
#' Muestra tipo (badge), nombre, autor, descripción, tags de features,
#' y dos links: app en producción + código en GitHub.
create_inspiracion_card <- function(app_info) {
  tag_items <- parse_tags(app_info$tags)

  div(
    class = "app-card-minimal inspiracion-card",

    # Tipo / categoría temática
    if (!is_na_or_empty(app_info$tipo)) {
      div(
        class = "app-categoria",
        tags$span(class = "categoria-badge", as.character(app_info$tipo))
      )
    },

    # Nombre de la app
    h3(class = "app-nombre", app_info$nombre_app %||% "Sin nombre"),

    # Autor
    if (!is_na_or_empty(app_info$autor)) {
      p(class = "app-autor", as.character(app_info$autor))
    },

    # Descripción
    if (!is_na_or_empty(app_info$descripcion)) {
      p(class = "app-descripcion", as.character(app_info$descripcion))
    },

    # Tags de features/paquetes
    if (length(tag_items) > 0) {
      div(
        class = "app-tags",
        lapply(tag_items, function(t) tags$span(class = "tag-badge", t))
      )
    },

    # Botones: Ver app + Código GitHub
    div(
      class = "app-links",
      if (!is_na_or_empty(app_info$url_app)) {
        tags$a(
          href = as.character(app_info$url_app),
          target = "_blank",
          class = "app-link",
          "Ver app →"
        )
      } else {
        tags$span(class = "app-link-disabled", "Sin URL")
      },
      if (!is_na_or_empty(app_info$url_github)) {
        tags$a(
          href = as.character(app_info$url_github),
          target = "_blank",
          class = "github-link",
          icon("github"),
          " Código"
        )
      }
    )
  )
}
