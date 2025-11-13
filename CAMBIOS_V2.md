# Cambios Versión 2 - Dos Páginas

## Nuevas Características Implementadas

### 1. Segunda Página: Tabla de Búsqueda

Se agregó una nueva página "Tabla" con:

- **Tabla interactiva** usando DataTables
- **3 filtros de búsqueda**:
  - Búsqueda por texto (nombre o autor)
  - Filtro por categoría
  - Filtro por autor
- **Paginación** con controles minimalistas
- **Estilo coherente** con la paleta de 4 colores

#### Estructura de la Tabla

```
┌────────────────────────────────────────────┐
│ Buscar: [____] Categoría: [▼] Autor: [▼]  │
├────────────────────────────────────────────┤
│ Nombre    │ Autor      │ Categoría │ Link │
├───────────┼────────────┼───────────┼──────┤
│ App 1     │ Juan       │ Educación │ →    │
│ App 2     │ María      │ Datos     │ →    │
│ ...       │ ...        │ ...       │ ...  │
└────────────────────────────────────────────┘
   Mostrando 1 a 10 de 6 apps    [← →]
```

### 2. Header Actualizado en Página Principal

#### Nuevo Título y Subtítulo

- **Título**: "Estación Shiny + R" (en lugar de "Galería de Apps Shiny")
- **Subtítulo actualizado**: "Aplicaciones desarrolladas en el curso de [Estación R](https://estacion-r.com/) ["🖥️ Introducción a Shiny..."](https://estacion-r.com/courses)"

#### Hipervínculos

- **"Estación R"** → https://estacion-r.com/
- **Nombre del curso** → https://estacion-r.com/courses
- Ambos se abren en nueva pestaña
- Estilo con subrayado amarillo al hover

#### Imagen de Portada

- Imagen del curso a la derecha del título
- Borde negro de 3px
- Sombra amarilla (6px x 6px)
- Efecto hover: se eleva y aumenta sombra

```
┌─────────────────────────────────────────┐
│ Estación Shiny + R    [Imagen portada]  │
│ Aplicaciones del curso de Estación R... │
└─────────────────────────────────────────┘
```

### 3. Navegación con Tabs

La app ahora tiene una barra de navegación superior con dos pestañas:

```
┌────────────────────────────────────────┐
│ Estación Shiny + R                     │
│ [Galería] [Tabla]                      │
└────────────────────────────────────────┘
```

- **Galería** (🗂️): Vista de tarjetas (página principal)
- **Tabla** (📊): Vista de tabla con filtros

### 4. Nuevos Estilos CSS

#### Links con Estilo Minimalista

```css
/* Links azules con subrayado amarillo al hover */
.link-estacion, .link-curso {
  color: #405BFF;
  border-bottom: 2px solid transparent;
}

.link-estacion:hover, .link-curso:hover {
  border-bottom-color: #EAFF38;
}
```

#### Imagen de Portada

```css
/* Borde negro + sombra amarilla */
.img-portada {
  border: 3px solid #000000;
  box-shadow: 6px 6px 0 #EAFF38;
}

.img-portada:hover {
  transform: translateY(-4px);
  box-shadow: 8px 8px 0 #EAFF38;
}
```

#### Tabla Minimalista

- Header negro con texto blanco
- Bordes negros sólidos de 2px
- Hover: fondo amarillo claro (15% opacidad)
- Links azules con hover
- Paginación con botones minimalistas

#### Filtros

- Inputs con borde negro de 2px
- Focus: borde azul + sombra amarilla
- Bordes cuadrados (sin border-radius)

### 5. Nueva Función en utils.R

```r
create_apps_datatable_minimal(data)
```

- Crea tabla interactiva con estilo minimalista
- Maneja URLs que pueden ser NA
- Traducciones al español
- Personalización de columnas
- Fuente Ubuntu

## Estructura Actualizada

### Archivos Modificados

1. **[app.R](app.R)**
   - Cambió de `page_fluid` a `page_navbar`
   - 2 paneles: "Galería" y "Tabla"
   - Nuevo header con imagen y links
   - Filtros reactivos para la tabla
   - +160 líneas

2. **[R/utils.R](R/utils.R)**
   - Nueva función: `create_apps_datatable_minimal()`
   - Tabla con estilos personalizados
   - Manejo de datos filtrados

3. **[www/css/custom.css](www/css/custom.css)**
   - Estilos para links (`.link-estacion`, `.link-curso`)
   - Estilos para imagen (`.img-portada`)
   - Estilos para tabla (`.table-minimal`)
   - Estilos para filtros (`.form-control`, `.form-select`)
   - Estilos para navbar tabs
   - ~160 líneas nuevas

## Comparación de Versiones

### Versión 1 (Minimalista)
- 1 página
- Solo tarjetas
- Sin navegación
- Sin filtros
- 100 líneas de código

### Versión 2 (Actual)
- 2 páginas
- Tarjetas + Tabla
- Navbar con tabs
- 3 filtros de búsqueda
- Imagen en header
- Links interactivos
- ~260 líneas de código

## Paleta de Colores (Sin Cambios)

- 🔵 Azul: `#405BFF`
- 🟡 Amarillo: `#EAFF38`
- ⚪ Blanco: `#FFFFFF`
- ⚫ Negro: `#000000`

## Dependencias

Se agregó de vuelta el paquete `DT`:

```r
library(DT)  # Para DataTables
```

**Total**: 6 paquetes (shiny, bslib, readODS, dplyr, htmltools, DT)

## Responsive

Ambas páginas son completamente responsive:

- **Desktop**: Tabla completa, imagen grande
- **Tablet**: Tabla ajustada, imagen mediana
- **Mobile**: Tabla scrollable, imagen pequeña, navbar colapsable

## Ejecución

```r
shiny::runApp("app.R")
```

## Screenshots Conceptuales

### Página 1: Galería

```
┌─────────────────────────────────────────────┐
│ Estación Shiny + R    [📸 Portada]          │
│ Aplicaciones de Estación R "Intro Shiny"   │
├─────────────────────────────────────────────┤
│ ┌────────┐  ┌────────┐  ┌────────┐         │
│ │ App 1  │  │ App 2  │  │ App 3  │         │
│ │ Autor  │  │ Autor  │  │ Autor  │         │
│ │[Cat]   │  │[Cat]   │  │[Cat]   │         │
│ │Ver →   │  │Ver →   │  │Ver →   │         │
│ └────────┘  └────────┘  └────────┘         │
└─────────────────────────────────────────────┘
```

### Página 2: Tabla

```
┌─────────────────────────────────────────────┐
│ Listado de Aplicaciones                     │
│ Busca y filtra las aplicaciones             │
├─────────────────────────────────────────────┤
│ [Buscar] [Categoría ▼] [Autor ▼]           │
├─────────────────────────────────────────────┤
│ ┏━━━━━━━━┳━━━━━━┳━━━━━━━━━━┳━━━━━┓       │
│ ┃ Nombre ┃ Autor┃ Categoría┃ Link┃       │
│ ┣━━━━━━━━╋━━━━━━╋━━━━━━━━━━╋━━━━━┫       │
│ ┃ App 1  ┃ Juan ┃ Educación┃ →   ┃       │
│ ┃ App 2  ┃ María┃ Datos    ┃ →   ┃       │
│ ┗━━━━━━━━┻━━━━━━┻━━━━━━━━━━┻━━━━━┛       │
│                                             │
│ Mostrando 1-6 de 6      [← 1 →]           │
└─────────────────────────────────────────────┘
```

## Próximos Pasos Posibles

- [ ] Agregar búsqueda en tiempo real en la tabla
- [ ] Agregar ordenamiento por columnas
- [ ] Agregar exportar tabla a CSV
- [ ] Agregar vista de favoritos
- [ ] Agregar conteo de visitas por app

---

**Versión 2 Lista! 🎨**

*2 páginas • 4 colores • Tabla con filtros • Header mejorado*
