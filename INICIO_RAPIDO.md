# Inicio Rápido - Galería Apps Shiny Estación R

## Verificación del Estado

La aplicación ha sido creada y verificada exitosamente:

- ✓ Todos los archivos de código creados
- ✓ Estructura de carpetas completa
- ✓ Recursos (imágenes, CSS, JS) copiados
- ✓ Datos cargados correctamente (6 aplicaciones)
- ✓ Todas las funciones probadas y funcionando
- ✓ Sin errores de sintaxis

## Inicio en 3 Pasos

### 1. Instalar Dependencias (primera vez)

```r
source("install_dependencies.R")
```

### 2. Probar que Todo Funcione

```r
source("test_app.R")
```

### 3. Ejecutar la Aplicación

**Opción A - Script de inicio rápido:**
```r
source("run_app.R")
```

**Opción B - Comando directo:**
```r
shiny::runApp("app.R")
```

**Opción C - Desde RStudio:**
1. Abre el archivo `app.R`
2. Haz clic en el botón "Run App" (arriba a la derecha)

## Estructura de Datos

El archivo `lista_shinyapps.ods` actualmente contiene:

- **6 aplicaciones** de estudiantes
- **Columnas**: autor, nombre_app, descripcion, url, categoria
- **5 categorías** diferentes

### Ejemplo de datos:

| autor | nombre_app | categoria | url |
|-------|------------|-----------|-----|
| Javier Ontivero | Indicadores de Eficiencia Interna | Educación | https://... |
| Cristopher Cardarelli | ElectoApp | Datos electorales | - |
| Graciela Bellotti | Género y Mercado de Trabajo | Género y Mercado de Trabajo | https://... |

## Características de la App

### Página de Inicio
- Hero section con logo y portada del curso
- Tarjetas de estadísticas (total apps, estudiantes, categorías)
- Apps destacadas (3 más recientes)

### Galería
- Vista de tarjetas con todas las apps
- Filtros por:
  - Búsqueda de texto (nombre o autor)
  - Categoría
  - Autor
- Links directos a cada aplicación

### Estadísticas
- Value boxes con métricas clave
- Gráfico de apps por categoría (interactivo con plotly)
- Gráfico de línea temporal de apps
- Tabla completa con DataTables

### Acerca de
- Información del proyecto
- Link a Estación R

## Personalización

### Colores de la Marca

Los colores de Estación R están definidos en:
- `imagen_de_marca_estacion_r/_brand.yml`
- `www/css/custom.css` (variables CSS)
- `app.R` (tema bslib)

**Paleta:**
- Azul: `#447099` (primario)
- Naranja: `#EE6331` (accent)
- Verde: `#72994E`
- Teal: `#419599`
- Burgundy: `#9A4665`

### Modificar Imágenes

Reemplaza los archivos en `www/img/`:
- `logo_estacion_r_ancho.png` - Logo del navbar
- `portada_curso.png` - Imagen del hero section

### Agregar Más Apps

1. Edita `lista_shinyapps.ods`
2. Agrega nuevas filas con: autor, nombre_app, descripcion, url, categoria
3. Recarga la aplicación

## Deployment

### shinyapps.io (Recomendado)

```r
install.packages("rsconnect")
rsconnect::setAccountInfo(name="tu-usuario", token="...", secret="...")
rsconnect::deployApp()
```

### Servidor Local

```bash
# Copiar proyecto a directorio de Shiny Server
sudo cp -r . /srv/shiny-server/galeria-apps/
```

## Solución de Problemas

### Error: "No se encontró el archivo"
- Verifica que estés en el directorio correcto del proyecto
- Usa `getwd()` para ver el directorio actual
- Usa `setwd("/ruta/al/proyecto")` si es necesario

### Error: "Package not found"
- Ejecuta `source("install_dependencies.R")` nuevamente

### La app no carga datos
- Verifica que `lista_shinyapps.ods` exista
- Comprueba que tenga las columnas correctas
- Ejecuta `source("test_app.R")` para diagnosticar

## Archivos Importantes

| Archivo | Descripción |
|---------|-------------|
| `app.R` | Aplicación principal |
| `R/utils.R` | Funciones auxiliares (carga datos, gráficos, etc.) |
| `R/ui_modules.R` | Módulos de interfaz |
| `R/server_modules.R` | Lógica del servidor |
| `www/css/custom.css` | Estilos personalizados |
| `lista_shinyapps.ods` | Datos de las aplicaciones |
| `test_app.R` | Script de pruebas |
| `run_app.R` | Inicio rápido |

## Soporte

- Documentación completa: `README.md`
- Contexto del proyecto: `claude.md`
- Web: https://estacion-r.com/

---

**¡La aplicación está lista para usar! 🚀**
