# A Tiempo — prototipos de frontend

Implementación navegable de los mockups de **A Tiempo**: acompañamiento respetuoso de la rutina de Elena. La persona mayor confirma sus propias actividades; Laura, su contacto autorizado, acompaña y consulta.

## Estructura

- [`web/`](web/) — panel de apoyo remoto (W00–W08), HTML, CSS y JavaScript.
- [`mobile/`](mobile/) — aplicación Android (M01–M14) con interfaz HTML/CSS/JavaScript empaquetada en una actividad nativa `WebView`.

Los prototipos no tienen servidor ni procesan datos reales. Los cambios de estado se guardan únicamente en el dispositivo/navegador mediante `localStorage`. No representan un sistema médico ni realizan llamadas o envían mensajes.

## Diseños fuente

- [Mockups web en Stitch](https://stitch.withgoogle.com/projects/8934927616997904325)
- [Mockups mobile en Stitch](https://stitch.withgoogle.com/projects/8753419281421727622)
- `A_Tiempo_Entregable_UI_Web.pdf` y `A_Tiempo_Entregable_UI_Mobile.pdf`, documentos del proyecto original (no incluidos en el repositorio).

## Uso

Consulta los README de cada carpeta para ejecutar y compilar. Navega desde el menú lateral web y la barra inferior móvil; los controles de formularios, filtros, pestañas, modal y confirmaciones son interactivos. La interfaz incorpora los tokens de color, escala de 8 px, jerarquía y reglas de autonomía del UI kit de los mockups, implementados con CSS y componentes HTML reales.

## Estado de la entrega

Se incluye un APK de depuración firmado en `mobile/apk/A-Tiempo-debug.apk`, con `minSdkVersion 27`. Se verificaron la firma, el manifiesto y las pantallas del prototipo; yo como propietario del proyecto confirmo que instale el APK y navegue por la aplicación en mi celular Android. La web se probó en navegador con sus rutas y controles principales. No se incluyen credenciales, datos de pacientes ni integración real.
