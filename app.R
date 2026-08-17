# =============================================================================
# Galería de Aplicaciones Shiny - Estación R (Versión Minimalista)
# =============================================================================

# Cargar librerías necesarias ------------------------------------------------
library(shiny)
library(bslib)
library(readODS)
library(dplyr)
library(htmltools)
library(DT)

# Cargar funciones auxiliares ------------------------------------------------
source("R/utils.R")

# Cargar y procesar datos -----------------------------------------------------
apps_data        <- load_apps_data("lista_shinyapps.ods")
inspiracion_data <- load_inspiracion_data("lista_inspiracion.ods")

# Definir tema minimalista ----------------------------------------------------
theme_minimal <- bs_theme(
  version = 5,
  bg = "#FFFFFF",
  fg = "#000000",
  primary = "#405BFF",
  secondary = "#000000",
  base_font = font_google("Ubuntu"),
  heading_font = font_google("Ubuntu", wght = c(400, 500, 700)),
  font_scale = 1
)

# UI --------------------------------------------------------------------------
ui <- page_navbar(
  title = "Estación Shiny + R",
  theme = theme_minimal,
  fillable = FALSE,
  header = tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/custom.css")
  ),

  # Panel 1: Galería (Principal) --------------------------------------------
  nav_panel(
    title = "Galería",
    value = "galeria",
    icon = icon("th"),

    # Header con imagen
    div(
      class = "header-minimal",
      div(
        class = "container",
        div(
          class = "row align-items-center",
          div(
            class = "col-md-8",
            h1("Estación Shiny + R", class = "titulo-principal"),
            p(
              class = "subtitulo",
              "Aplicaciones desarrolladas en el curso de ",
              tags$a(
                href = "https://estacion-r.com/",
                target = "_blank",
                "Estación R",
                class = "link-estacion"
              ),
              " ",
              tags$a(
                href = "https://estacion-r.com/courses",
                target = "_blank",
                "\"🖥️ Introducción a Shiny: construí tus primeros dashboards con R\"",
                class = "link-curso"
              )
            )
          ),
          div(
            class = "col-md-4 text-end",
            img(
              src = "img/portada_curso.png",
              class = "img-portada",
              alt = "Curso Shiny"
            )
          )
        )
      )
    ),

    # Grid de aplicaciones
    div(
      class = "container mt-5",
      div(
        class = "row",
        id = "apps-grid",
        uiOutput("apps_cards")
      )
    ),

    # Footer minimalista
    div(
      class = "footer-minimal",
      p(
        "Estación R ",
        tags$a(href = "https://estacion-r.com/", target = "_blank", "estacion-r.com")
      )
    )
  ),

  # Panel 2: Hecho en Shiny -------------------------------------------------
  nav_panel(
    title = "Hecho en Shiny",
    value = "inspiracion",
    icon = icon("star"),

    # Header
    div(
      class = "header-minimal",
      div(
        class = "container",
        div(
          class = "row align-items-center",
          div(
            class = "col-md-8",
            h1(
              class = "titulo-principal",
              tags$span(class = "titulo-hashtag", "#"),
              "HechoEnShiny"
            ),
            p(
              class = "subtitulo",
              "Apps construidas con R + Shiny: referencia técnica y fuente de inspiración"
            )
          ),
          div(
            class = "col-md-4",
            div(
              class = "mt-3",
              selectInput(
                "filter_tipo",
                label = NULL,
                choices = NULL,
                width = "100%"
              )
            )
          )
        )
      )
    ),

    # Grid de tarjetas de inspiración
    div(
      class = "container mt-5",
      div(
        class = "row",
        id = "inspiracion-grid",
        uiOutput("inspiracion_cards")
      )
    ),

    # Footer
    div(
      class = "footer-minimal",
      p(
        "Estación R ",
        tags$a(href = "https://estacion-r.com/", target = "_blank", "estacion-r.com")
      )
    )
  ),

  # Panel 3: Tabla -----------------------------------------------------------
  nav_panel(
    title = "Tabla",
    value = "tabla",
    icon = icon("table"),

    # Header tabla
    div(
      class = "header-minimal",
      div(
        class = "container",
        h1("Listado de Aplicaciones", class = "titulo-principal"),
        p("Busca y filtra las aplicaciones", class = "subtitulo")
      )
    ),

    # Contenido de la tabla
    div(
      class = "container mt-5",

      # Filtros
      div(
        class = "row mb-4",
        div(
          class = "col-md-4",
          textInput(
            "search_text",
            "Buscar:",
            placeholder = "Nombre o autor...",
            width = "100%"
          )
        ),
        div(
          class = "col-md-4",
          selectInput(
            "filter_categoria",
            "Categoría:",
            choices = NULL,
            width = "100%"
          )
        ),
        div(
          class = "col-md-4",
          selectInput(
            "filter_autor",
            "Autor:",
            choices = NULL,
            width = "100%"
          )
        )
      ),

      # Tabla
      div(
        class = "row",
        div(
          class = "col-12",
          DTOutput("apps_table")
        )
      )
    ),

    # Footer
    div(
      class = "footer-minimal",
      p(
        "Estación R ",
        tags$a(href = "https://estacion-r.com/", target = "_blank", "estacion-r.com")
      )
    )
  )
)

# SERVER ----------------------------------------------------------------------
server <- function(input, output, session) {
  # Actualizar opciones de filtros (Tabla)
  observe({
    categorias <- sort(unique(as.character(apps_data$categoria)))
    updateSelectInput(session, "filter_categoria", choices = c("Todas" = "", categorias))

    autores <- sort(unique(as.character(apps_data$autor)))
    updateSelectInput(session, "filter_autor", choices = c("Todos" = "", autores))
  })

  # Actualizar filtro de tipo (Hecho en Shiny)
  observe({
    tipos <- sort(unique(as.character(inspiracion_data$tipo)))
    updateSelectInput(session, "filter_tipo", choices = c("Todos los tipos" = "", tipos))
  })

  # Datos filtrados
  filtered_data <- reactive({
    data <- apps_data

    # Filtro por texto
    if (!is.null(input$search_text) && input$search_text != "") {
      search_term <- tolower(input$search_text)
      data <- data %>%
        filter(
          grepl(search_term, tolower(nombre_app), fixed = TRUE) |
            grepl(search_term, tolower(autor), fixed = TRUE)
        )
    }

    # Filtro por categoría
    if (!is.null(input$filter_categoria) && input$filter_categoria != "") {
      data <- data %>%
        filter(categoria == input$filter_categoria)
    }

    # Filtro por autor
    if (!is.null(input$filter_autor) && input$filter_autor != "") {
      data <- data %>%
        filter(autor == input$filter_autor)
    }

    return(data)
  })

  # PANEL HECHO EN SHINY: Tarjetas de inspiración
  output$inspiracion_cards <- renderUI({
    data <- inspiracion_data

    if (!is.null(input$filter_tipo) && input$filter_tipo != "") {
      data <- data %>% filter(tipo == input$filter_tipo)
    }

    if (nrow(data) == 0) {
      return(div(
        class = "col-12 text-center py-5",
        p(
          class = "text-muted",
          "Todavía no hay apps cargadas. Agregá filas en ",
          tags$code("lista_inspiracion.ods"),
          " para poblar esta sección."
        )
      ))
    }

    cards <- lapply(1:nrow(data), function(i) {
      div(
        class = "col-md-6 col-lg-4 mb-4",
        create_inspiracion_card(as.list(data[i, ]))
      )
    })

    tagList(cards)
  })

  # PANEL GALERÍA: Tarjetas de apps
  output$apps_cards <- renderUI({
    if (nrow(apps_data) == 0) {
      return(
        div(
          class = "col-12 text-center",
          p("No hay aplicaciones para mostrar")
        )
      )
    }

    # Crear tarjetas
    cards <- lapply(1:nrow(apps_data), function(i) {
      app_info <- as.list(apps_data[i, ])

      div(
        class = "col-md-6 col-lg-4 mb-4",
        create_app_card_minimal(app_info)
      )
    })

    tagList(cards)
  })

  # PANEL TABLA: Tabla de apps con filtros
  output$apps_table <- renderDT({
    create_apps_datatable_minimal(filtered_data())
  })
}

# Ejecutar la aplicación ------------------------------------------------------
shinyApp(ui = ui, server = server)
