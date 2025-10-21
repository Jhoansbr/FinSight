# FinSight - Estructura del Proyecto

## Descripción
FinSight es una aplicación de gestión financiera personal con interfaz moderna y funcionalidades de análisis inteligente.

## Estructura de Carpetas

### 📁 Pages/
Contiene todas las páginas principales de la aplicación:

- **Home/** - Página principal con dashboard financiero
- **Login/** - Página de inicio de sesión
- **registration/** - Páginas de registro de usuarios
- **Analysis/** - Página de análisis con gráficos
- **Movements/** - Página de movimientos financieros
- **Settings/** - Página de configuración

### 📁 core/
Contiene la lógica central y widgets reutilizables:

#### 📁 theme/
- **app_theme.dart** - Configuración del tema de la aplicación

#### 📁 widgets/
- **balance_card.dart** - Tarjeta de balance total con gradiente
- **ai_assistant_card.dart** - Tarjeta del asistente IA
- **income_expenses_cards.dart** - Tarjetas de ingresos y gastos
- **savings_goal_card.dart** - Tarjeta de meta de ahorro con barra de progreso
- **bottom_navigation.dart** - Barra de navegación inferior
- **main_navigation.dart** - Navegación principal entre páginas
- **expense_donut_chart.dart** - Gráfico de dona para gastos por categoría
- **monthly_trend_chart.dart** - Gráfico de barras para tendencia mensual

## Características Implementadas

### 🏠 Página Principal (Home)
- Saludo personalizado con avatar
- Tarjeta de balance total con gradiente
- Tarjeta del asistente IA con consejos
- Tarjetas de ingresos y gastos
- Tarjeta de meta de ahorro con barra de progreso
- Botón flotante para agregar transacciones

### 📊 Página de Análisis
- Gráfico de dona para distribución de gastos por categoría
- Gráfico de barras para tendencia mensual de ingresos vs gastos
- Botones de acción para nueva transacción y ver metas

### 🧭 Navegación
- Barra de navegación inferior con 4 secciones
- Navegación fluida entre páginas
- Indicadores visuales de página activa

## Tecnologías Utilizadas

- **Flutter** - Framework de desarrollo
- **fl_chart** - Librería para gráficos
- **intl** - Internacionalización
- **Material Design** - Sistema de diseño

## Colores del Tema

- **Primario**: #2196F3 (Azul)
- **Secundario**: #4CAF50 (Verde)
- **Fondo**: #F5F5F5 (Gris claro)
- **Texto**: #2C3E50 (Gris oscuro)
- **Balance**: Gradiente de #2C3E50 a #4CAF50

## Próximas Funcionalidades

- [ ] Integración con base de datos
- [ ] Autenticación de usuarios
- [ ] Gestión de transacciones
- [ ] Notificaciones push
- [ ] Exportación de reportes
- [ ] Modo oscuro

