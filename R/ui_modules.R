# =============================================================================
# Módulos de UI - Galería de Apps Shiny Estación R
# =============================================================================

# Módulo: Tarjetas de estadísticas --------------------------------------------

#' UI para tarjetas de estadísticas
#'
#' @param id Namespace ID del módulo
#' @return UI del módulo
#' @export
statsCardsUI <- function(id) {
  ns <- NS(id)

  div(
    class = "row",
    div(
      class = "col-md-3",
      value_box(
        title = "Total de Apps",
        value = textOutput(ns("total_apps")),
        showcase = icon("rocket"),
        theme = "primary",
        full_screen = FALSE
      )
    ),
    div(
      class = "col-md-3",
      value_box(
        title = "Estudiantes",
        value = textOutput(ns("total_autores")),
        showcase = icon("users"),
        theme = "info",
        full_screen = FALSE
      )
    ),
    div(
      class = "col-md-3",
      value_box(
        title = "Categorías",
        value = textOutput(ns("total_categorias")),
        showcase = icon("tags"),
        theme = "success",
        full_screen = FALSE
      )
    ),
    div(
      class = "col-md-3",
      value_box(
        title = "Apps Recientes",
        value = textOutput(ns("apps_recientes")),
        showcase = icon("calendar-check"),
        theme = "warning",
        full_screen = FALSE
      )
    )
  )
}

# Módulo: Apps destacadas -----------------------------------------------------

#' UI para apps destacadas
#'
#' @param id Namespace ID del módulo
#' @return UI del módulo
#' @export
featuredAppsUI <- function(id) {
  ns <- NS(id)

  div(
    class = "row",
    uiOutput(ns("featured_cards"))
  )
}

# Módulo: Panel de filtros ----------------------------------------------------

#' UI para panel de filtros de galería
#'
#' @param id Namespace ID del módulo
#' @return UI del módulo
#' @export
filterPanelUI <- function(id) {
  ns <- NS(id)

  div(
    class = "row",
    div(
      class = "col-md-4",
      textInput(
        ns("search_text"),
        "Buscar por nombre o autor:",
        placeholder = "Escribe para buscar..."
      )
    ),
    div(
      class = "col-md-4",
      selectInput(
        ns("filter_categoria"),
        "Filtrar por categoría:",
        choices = NULL,  # Se actualiza en el servidor
        multiple = TRUE
      )
    ),
    div(
      class = "col-md-4",
      selectInput(
        ns("filter_autor"),
        "Filtrar por autor:",
        choices = NULL,  # Se actualiza en el servidor
        multiple = TRUE
      )
    )
  )
}

# Módulo: Grid de apps --------------------------------------------------------

#' UI para grid de aplicaciones
#'
#' @param id Namespace ID del módulo
#' @return UI del módulo
#' @export
appsGridUI <- function(id) {
  ns <- NS(id)

  div(
    # Contador de resultados
    div(
      class = "mb-3",
      uiOutput(ns("results_count"))
    ),
    # Grid de tarjetas
    uiOutput(ns("apps_grid"))
  )
}

# Módulo: Vista detallada de app ----------------------------------------------

#' UI para vista detallada de una app
#'
#' @param id Namespace ID del módulo
#' @return UI del módulo
#' @export
appDetailUI <- function(id) {
  ns <- NS(id)

  div(
    class = "container",
    div(
      class = "row",
      div(
        class = "col-md-8",
        card(
          card_header(
            h3(textOutput(ns("app_nombre")))
          ),
          card_body(
            # Iframe o screenshot de la app
            div(
              class = "app-preview mb-3",
              uiOutput(ns("app_preview"))
            ),
            # Descripción
            div(
              class = "app-description",
              h4("Descripción"),
              uiOutput(ns("app_descripcion"))
            )
          )
        )
      ),
      div(
        class = "col-md-4",
        card(
          card_header("Información"),
          card_body(
            tags$dl(
              tags$dt(icon("user"), " Autor"),
              tags$dd(textOutput(ns("app_autor"))),

              tags$dt(icon("tag"), " Categoría"),
              tags$dd(textOutput(ns("app_categoria"))),

              tags$dt(icon("calendar"), " Fecha"),
              tags$dd(textOutput(ns("app_fecha"))),

              tags$dt(icon("link"), " Enlace"),
              tags$dd(uiOutput(ns("app_link")))
            )
          )
        )
      )
    )
  )
}
