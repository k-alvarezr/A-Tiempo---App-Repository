# A Tiempo Web

Prototipo de acompañamiento remoto para Laura Ríos.

## Tecnología

- HTML5
- CSS3 (variables de diseño, Grid y Flexbox)
- JavaScript ECMAScript 2020+
- jQuery 4.0.0 (archivo local, usado para la apertura animada del formulario de contacto)
- Inter (archivo local; licencia SIL OFL en `fonts/OFL.txt`)

Se usa la misma base HTML/CSS/JavaScript/jQuery del laboratorio. jQuery está incluido localmente para evitar una dependencia de red. El UI kit de Stitch se personalizó en `css/style.css` con tokens propios y componentes reutilizables.

## Ejecutar

Abre `index.html` en un navegador moderno. Para servirlo localmente:

```sh
python -m http.server 8080 --directory web
```

Visita `http://localhost:8080`.

## Pantallas y flujo

W00 invitación → W01 panel de hoy → W02 recordatorios → W03 creación → W04 detalle → W05 edición. W06 alertas → W07 detalle de alerta. W08 acceso y permisos. La sección «Sistema visual» presenta los componentes y estados utilizados.

Los formularios actualizan la maqueta de forma local. La búsqueda, filtros, pestañas y diálogos responden a la interacción. Llamadas, mensajes y sincronización son simulados: no contactan a nadie ni confirman una actividad en nombre de Elena.
