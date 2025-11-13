# Versión Minimalista - Galería Apps Shiny

## Cambios Implementados

### Diseño Simplificado

La aplicación ahora es **una sola página** con un diseño minimalista y limpio:

- ❌ Eliminado: Navbar con múltiples pestañas
- ❌ Eliminado: Estadísticas y gráficos
- ❌ Eliminado: Hero section con imagen
- ❌ Eliminado: Filtros de búsqueda
- ✅ Solo: Grid de tarjetas con las aplicaciones

### Nueva Paleta de Colores

Se utilizan únicamente **4 colores**:

```css
Azul:     #405BFF  (botones y enlaces)
Amarillo: #EAFF38  (sombras y badges)
Blanco:   #FFFFFF  (fondo)
Negro:    #000000  (texto y bordes)
```

### Tipografía

- **Fuente única**: Ubuntu (Google Fonts)
- Pesos: 400 (normal), 500 (medium), 700 (bold)

### Estructura Visual

```
┌─────────────────────────────────────────┐
│  Header                                 │
│  ├─ Título: "Galería de Apps Shiny"    │
│  └─ Subtítulo: Curso info              │
├─────────────────────────────────────────┤
│  Grid de Tarjetas (3 columnas)         │
│  ┌───────┐  ┌───────┐  ┌───────┐      │
│  │ App 1 │  │ App 2 │  │ App 3 │      │
│  └───────┘  └───────┘  └───────┘      │
│  ┌───────┐  ┌───────┐  ┌───────┐      │
│  │ App 4 │  │ App 5 │  │ App 6 │      │
│  └───────┘  └───────┘  └───────┘      │
├─────────────────────────────────────────┤
│  Footer                                 │
│  "Estación R - estacion-r.com"         │
└─────────────────────────────────────────┘
```

## Características de las Tarjetas

Cada tarjeta muestra:

1. **Nombre de la app** (título grande, negro)
2. **Autor** (texto azul)
3. **Categoría** (badge amarillo con borde negro)
4. **Descripción** (texto negro)
5. **Botón "Ver aplicación →"** (azul con borde negro)

### Efecto Hover

Al pasar el mouse sobre una tarjeta:
- Borde cambia a azul
- La tarjeta se eleva (translateY -4px)
- Aparece sombra amarilla (8px x 8px)

## Archivos Modificados

### 1. `app.R` - Simplificado

- Solo 100 líneas (antes: 307)
- Una sola página (page_fluid)
- Sin módulos complejos
- Sin navegación

### 2. `R/utils.R` - Nueva Función

Agregada: `create_app_card_minimal(app_info)`
- Crea tarjetas con diseño minimalista
- Maneja datos faltantes (NA)
- Estructura limpia y clara

### 3. `www/css/custom.css` - Reescrito

- Variables CSS con nueva paleta
- Estilos minimalistas
- Bordes sólidos de 2-3px
- Animaciones sutiles
- 100% responsive

## Dependencias Reducidas

### Antes (9 paquetes):
```r
shiny, bslib, readODS, dplyr, htmltools,
shinyWidgets, DT, ggplot2, plotly
```

### Ahora (5 paquetes):
```r
shiny, bslib, readODS, dplyr, htmltools
```

## Ejecutar la App

```r
# Opción 1: Directo
shiny::runApp("app.R")

# Opción 2: Script de inicio
source("run_app.R")
```

## Diseño Responsive

### Desktop (> 992px)
- 3 columnas (col-lg-4)
- Tarjetas con padding de 2rem
- Sombras de 8px al hover

### Tablet (768px - 992px)
- 2 columnas (col-md-6)
- Tarjetas con padding de 2rem

### Mobile (< 768px)
- 1 columna (100% width)
- Tarjetas con padding de 1.5rem
- Sombras reducidas (4px)
- Títulos más pequeños

## Comparación de Código

### Antes:
```r
# app.R con 4 paneles, filtros, gráficos
# 307 líneas
# 3 archivos de módulos
# CSS con múltiples colores
```

### Ahora:
```r
# app.R con 1 página simple
# 100 líneas
# 1 función auxiliar nueva
# CSS minimalista con 4 colores
```

## Estilo Visual

El diseño se inspira en:
- **Brutalismo web**: Bordes gruesos, formas simples
- **Swiss design**: Tipografía clara, grid ordenado
- **Flat design**: Sin gradientes, colores planos

### Elementos clave:
- Bordes negros de 2-3px en todo
- Sombras duras (no blur) en amarillo
- Contraste alto (negro sobre blanco)
- Espaciado generoso
- Tipografía Ubuntu (sans-serif moderna)

## Ejemplo de Tarjeta

```html
┌─────────────────────────────┐
│ App de Ejemplo             │ ← Negro, Ubuntu Bold, 1.5rem
│ Juan Pérez                 │ ← Azul, Ubuntu Medium, 1rem
│ [Educación]                │ ← Badge: amarillo + borde negro
│                            │
│ Esta app muestra datos de  │ ← Negro, Ubuntu Regular, 0.95rem
│ educación de forma inter-  │
│ activa...                  │
│                            │
│ [Ver aplicación →]         │ ← Botón azul con borde negro
└─────────────────────────────┘
  Hover: borde azul + sombra amarilla
```

## Ventajas de esta Versión

✅ **Más rápida**: Menos paquetes y código
✅ **Más limpia**: Diseño enfocado en el contenido
✅ **Más simple**: Fácil de mantener y modificar
✅ **Más moderna**: Estética minimalista actual
✅ **Mejor rendimiento**: Menos JavaScript y CSS

## Siguientes Pasos Posibles

1. Agregar filtro simple por categoría
2. Agregar buscador de texto
3. Agregar contador de apps
4. Agregar paginación si hay muchas apps
5. Agregar animación de carga

---

**Versión Minimalista Lista! 🎨**

*4 colores • 1 fuente • Sin estadísticas • Enfoque en las apps*
