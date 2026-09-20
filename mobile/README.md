# A Tiempo Mobile · Android

Aplicación Android de demostración para Elena, basada en los mockups M01–M14 de Stitch. El contenido vive en `app/src/main/assets/`: HTML5, CSS3 y JavaScript ECMAScript 2020+. Una actividad Java mínima lo carga en `WebView`, sin servidor, Internet ni permisos sensibles.

La tipografía Atkinson Hyperlegible Next se incluye localmente para uso sin conexión; su licencia SIL OFL está en `app/src/main/assets/fonts/OFL.txt`.

## Versiones y requisitos

- Android Gradle Plugin 8.7.3
- Gradle 8.9 (si se abre en Android Studio)
- Java 17
- `compileSdk` 35, `targetSdk` 35, `minSdk` 27 (Android 8.1)
- Android Studio con SDK 35 y Build Tools instalados

## Ejecutar APK

El APK de depuración verificado se encuentra en [`apk/A-Tiempo-debug.apk`](apk/A-Tiempo-debug.apk). Puede instalarse en Android API 27 o superior. La firma es de depuración: no es adecuada para publicar en Google Play.

## Flujo

M01 Hoy; M02 Recordatorios; M03 Qué y cuándo; M04 Repetición y aviso; M05 Revisar y guardar; M06 Detalle; M07 Edición; M08 Alerta activa; M09 Hecha; M10 Pospuesta; M11 Apoyo; M12 Agregar apoyo; M13 Revisar invitación; M14 Estado. La ruta `#design` documenta el sistema visual usado.

Los controles y la navegación funcionan sin backend. Los cambios se guardan solo en el almacenamiento local del dispositivo. No se envían invitaciones reales ni se efectúan llamadas. No se presenta como sistema clínico.
