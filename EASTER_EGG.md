# 🍌 Easter Egg - BananaTech

## ¿Cómo activarlo?

1. Ve a tu sitio en Vercel: **https://dtechstore.vercel.app** (o tu URL personalizada)
2. En el buscador del header, escribe: **banana** (en mayúsculas, minúsculas o mixto)
3. Presiona Enter o haz clic en el botón de búsqueda
4. ¡Disfruta de la sorpresa! 🎉

## Detalles técnicos

- **Ubicación del código**: `frontend/src/components/Header.astro`
- **Trigger**: Búsqueda exacta de la palabra "banana" (case-insensitive)
- **Efecto**: Overlay con animación de banana gigante
- **Animaciones incluidas**:
  - Rotación suave
  - Rebote vertical
  - Efecto de brillo en el texto
  - Entrada con escala y rotación
  - Backdrop blur

## Características

- ✅ Responsive (funciona en móvil, tablet y desktop)
- ✅ Animaciones suaves con CSS
- ✅ Cierre con botón o clic fuera del contenido
- ✅ No interfiere con búsquedas normales
- ✅ Limpia el input después de activarse

## Personalización

Para modificar el easter egg, edita:
- **Texto**: Línea con `.banana-text`
- **Tamaño de banana**: Propiedad `font-size` en `.banana-giant`
- **Colores**: Gradientes en `.banana-text` y `.banana-close`
- **Animaciones**: Keyframes al final del archivo
