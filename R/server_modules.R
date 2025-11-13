# =============================================================================
# Módulos de Servidor - Galería de Apps Shiny Estación R
# =============================================================================

# Módulo: Tarjetas de estadísticas --------------------------------------------

#' Servidor para tarjetas de estadísticas
#'
#' @param id Namespace ID del módulo
#' @param data Reactive o data frame con información de apps
#' @export
statsCardsServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {

    stats <- reactive({
      df <- if(is.reactive(data)) data() else data
      calculate_stats(df)
    })

    output$total_apps <- renderText({
      format(stats()$total_apps, big.mark = ",")
    })

    output$total_autores <- renderText({
      format(stats()$total_autores, big.mark = ",")
    })

    output$total_categorias <- renderText({
      format(stats()$categorias, big.mark = ",")
    })

    output$apps_recientes <- renderText({
      paste(format(stats()$apps_recientes, big.mark = ","), "último mes")
    })
  })
}

# Módulo: Apps destacadas -----------------------------------------------------

#' Servidor para apps destacadas
#'
#' @param id Namespace ID del módulo
#' @param data Reactive o data frame con información de apps
#' @export
featuredAppsServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {

    output$featured_cards <- renderUI({

      df <- if(is.reactive(data)) data() else data

      # Seleccionar hasta 3 apps aleatorias o las más recientes
      featured <- df
      if(nrow(df) > 3) {
        if("fecha" %in% names(df)) {
          featured <- df %>%
            arrange(desc(fecha)) %>%
            head(3)
        } else {
          featured <- df %>%
            sample_n(min(3, nrow(df)))
        }
      }

      # Crear tarjetas
      cards <- lapply(1:nrow(featured), function(i) {
        app_info <- as.list(featured[i, ])

        div(
          class = "col-md-4 mb-3",
          create_app_card(app_info)
        )
      })

      tagList(cards)
    })
  })
}

# Módulo: Panel de filtros ----------------------------------------------------

#' Servidor para panel de filtros
#'
#' @param id Namespace ID del módulo
#' @param data Reactive o data frame con información de apps
#' @return Reactive con datos filtrados
#' @export
filterPanelServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {

    # Actualizar opciones de filtros cuando cambien los datos
    observe({
      df <- if(is.reactive(data)) data() else data

      # Actualizar categorías
      if("categoria" %in% names(df)) {
        categorias <- sort(unique(as.character(df$categoria)))
        updateSelectInput(
          session,
          "filter_categoria",
          choices = c("Todas" = "", categorias),
          selected = ""
        )
      }

      # Actualizar autores
      if("autor" %in% names(df)) {
        autores <- sort(unique(as.character(df$autor)))
        updateSelectInput(
          session,
          "filter_autor",
          choices = c("Todos" = "", autores),
          selected = ""
        )
      }
    })

    # Datos filtrados (reactive)
    filtered_data <- reactive({
      df <- if(is.reactive(data)) data() else data

      # Filtro por texto de búsqueda
      if(!is.null(input$search_text) && input$search_text != "") {
        search_term <- tolower(input$search_text)
        df <- df %>%
          filter(
            grepl(search_term, tolower(nombre_app), fixed = TRUE) |
              grepl(search_term, tolower(autor), fixed = TRUE)
          )
      }

      # Filtro por categoría
      if(!is.null(input$filter_categoria) && length(input$filter_categoria) > 0) {
        if(!"" %in% input$filter_categoria) {
          df <- df %>%
            filter(categoria %in% input$filter_categoria)
        }
      }

      # Filtro por autor
      if(!is.null(input$filter_autor) && length(input$filter_autor) > 0) {
        if(!"" %in% input$filter_autor) {
          df <- df %>%
            filter(autor %in% input$filter_autor)
        }
      }

      return(df)
    })

    return(filtered_data)
  })
}

# Módulo: Grid de apps --------------------------------------------------------

#' Servidor para grid de aplicaciones
#'
#' @param id Namespace ID del módulo
#' @param data Reactive con datos (posiblemente filtrados)
#' @export
appsGridServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {

    # Contador de resultados
    output$results_count <- renderUI({
      df <- if(is.reactive(data)) data() else data
      n_apps <- nrow(df)

      tags$p(
        class = "text-muted",
        sprintf("Mostrando %d aplicación%s", n_apps, if(n_apps != 1) "es" else "")
      )
    })

    # Grid de tarjetas
    output$apps_grid <- renderUI({

      df <- if(is.reactive(data)) data() else data

      if(nrow(df) == 0) {
        return(
          div(
            class = "alert alert-info",
            icon("info-circle"),
            " No se encontraron aplicaciones con los filtros seleccionados."
          )
        )
      }

      # Crear tarjetas en grid
      cards <- lapply(1:nrow(df), function(i) {
        app_info <- as.list(df[i, ])

        div(
          class = "col-md-4 col-lg-3 mb-4",
          create_app_card(app_info)
        )
      })

      div(
        class = "row",
        cards
      )
    })
  })
}

# Módulo: Vista detallada de app ----------------------------------------------

#' Servidor para vista detallada de una app
#'
#' @param id Namespace ID del módulo
#' @param app_data Reactive con información de una app específica
#' @export
appDetailServer <- function(id, app_data) {
  moduleServer(id, function(input, output, session) {

    output$app_nombre <- renderText({
      app <- if(is.reactive(app_data)) app_data() else app_data
      app$nombre_app %||% "Sin nombre"
    })

    output$app_autor <- renderText({
      app <- if(is.reactive(app_data)) app_data() else app_data
      app$autor %||% "Desconocido"
    })

    output$app_categoria <- renderText({
      app <- if(is.reactive(app_data)) app_data() else app_data
      app$categoria %||% "Sin categoría"
    })

    output$app_fecha <- renderText({
      app <- if(is.reactive(app_data)) app_data() else app_data
      if(!is.null(app$fecha)) {
        format(app$fecha, "%d/%m/%Y")
      } else {
        "No disponible"
      }
    })

    output$app_descripcion <- renderUI({
      app <- if(is.reactive(app_data)) app_data() else app_data
      p(app$descripcion %||% "Sin descripción disponible.")
    })

    output$app_link <- renderUI({
      app <- if(is.reactive(app_data)) app_data() else app_data
      if(!is.null(app$url) && app$url != "") {
        tags$a(
          href = app$url,
          target = "_blank",
          "Abrir aplicación",
          icon("external-link-alt")
        )
      } else {
        "No disponible"
      }
    })

    output$app_preview <- renderUI({
      app <- if(is.reactive(app_data)) app_data() else app_data

      if(!is.null(app$url) && app$url != "") {
        # Mostrar iframe de la app (opcional, puede causar problemas de CORS)
        tags$iframe(
          src = app$url,
          width = "100%",
          height = "500px",
          frameborder = "0",
          class = "app-iframe"
        )
      } else {
        div(
          class = "alert alert-warning",
          "Vista previa no disponible"
        )
      }
    })
  })
}
