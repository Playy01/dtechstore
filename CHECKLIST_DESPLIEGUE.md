# ✅ Checklist de Despliegue

Usa esta lista para asegurarte de que todo esté listo antes de desplegar.

---

## 📋 Antes de Desplegar

### Código
- [ ] Todo el código está en GitHub
- [ ] No hay errores de compilación
- [ ] Las dependencias están actualizadas
- [ ] `.gitignore` está configurado correctamente

### Base de Datos
- [ ] Schema SQL está listo (`database/schema.sql`)
- [ ] Tienes datos de prueba (opcional)
- [ ] Conoces la cadena de conexión

### Variables de Entorno
- [ ] `JWT_SECRET` es seguro y único
- [ ] `DB_DSN` está configurado
- [ ] `ALLOWED_ORIGINS` incluye tu dominio frontend
- [ ] `PUBLIC_API_URL` apunta al backend correcto

### Archivos de Configuración
- [ ] `backend/railway.Dockerfile` existe
- [ ] `frontend/railway.Dockerfile` existe
- [ ] `railway.toml` está configurado
- [ ] `nginx.conf` está optimizado

---

## 🚀 Durante el Despliegue

### Railway Setup
- [ ] Cuenta creada en Railway
- [ ] Repositorio conectado
- [ ] MySQL provisionado
- [ ] Schema importado a la base de datos

### Backend
- [ ] Servicio creado
- [ ] Root directory: `backend`
- [ ] Dockerfile path: `backend/railway.Dockerfile`
- [ ] Variables de entorno configuradas
- [ ] Deployment exitoso
- [ ] URL pública copiada
- [ ] Health check funciona: `/api/health`

### Frontend
- [ ] Servicio creado
- [ ] Root directory: `frontend`
- [ ] Dockerfile path: `frontend/railway.Dockerfile`
- [ ] `PUBLIC_API_URL` actualizado con URL del backend
- [ ] Deployment exitoso
- [ ] URL pública copiada

### CORS
- [ ] `ALLOWED_ORIGINS` actualizado con URL del frontend
- [ ] Backend redesployado
- [ ] CORS funciona correctamente

---

## ✅ Después del Despliegue

### Pruebas Funcionales
- [ ] Frontend carga correctamente
- [ ] Registro de usuario funciona
- [ ] Login funciona
- [ ] Productos se muestran
- [ ] Carrito funciona
- [ ] Proceso de pago funciona
- [ ] Panel de admin accesible

### Pruebas de API
- [ ] `GET /api/health` → 200 OK
- [ ] `GET /api/products` → Lista de productos
- [ ] `POST /api/auth/register` → Crea usuario
- [ ] `POST /api/auth/login` → Retorna token
- [ ] `GET /api/orders` → Requiere autenticación

### Seguridad
- [ ] HTTPS habilitado (automático en Railway)
- [ ] JWT_SECRET es único y seguro
- [ ] CORS configurado solo para tu dominio
- [ ] No hay secretos en el código
- [ ] Variables sensibles en Railway, no en GitHub

### Performance
- [ ] Imágenes optimizadas
- [ ] Gzip habilitado
- [ ] Cache configurado
- [ ] Tiempo de carga < 3 segundos

### Monitoreo
- [ ] Logs del backend revisados
- [ ] Logs del frontend revisados
- [ ] No hay errores en consola del navegador
- [ ] Uso de recursos monitoreado en Railway

---

## 🐛 Troubleshooting

Si algo no funciona:

### Backend no inicia
1. Revisa logs en Railway
2. Verifica `DB_DSN`
3. Confirma que MySQL está corriendo
4. Verifica que el schema se importó

### Frontend no conecta
1. Verifica `PUBLIC_API_URL` en variables
2. Revisa CORS en backend
3. Abre consola del navegador
4. Verifica que backend esté corriendo

### Base de datos no conecta
1. Verifica que MySQL esté activo
2. Revisa la cadena de conexión
3. Confirma que el schema se importó
4. Revisa permisos de usuario

### CORS errors
1. Verifica `ALLOWED_ORIGINS` en backend
2. Incluye protocolo: `https://`
3. No incluyas `/` al final
4. Redeploy backend después de cambios

---

## 📊 Métricas de Éxito

Tu despliegue es exitoso si:

- ✅ Frontend carga en < 3 segundos
- ✅ API responde en < 500ms
- ✅ Usuarios pueden registrarse y hacer login
- ✅ Productos se cargan correctamente
- ✅ Carrito funciona sin errores
- ✅ No hay errores en logs
- ✅ HTTPS funciona correctamente
- ✅ Uso de recursos < 50% del límite gratuito

---

## 🎉 ¡Felicidades!

Si completaste todos los checks, tu e-commerce está en producción.

### Próximos pasos:
1. Agrega productos reales
2. Configura dominio personalizado (opcional)
3. Configura backups automáticos
4. Monitorea el uso de recursos
5. Comparte tu proyecto

---

## 📞 Soporte

Si necesitas ayuda:
- Revisa las guías: `DESPLIEGUE_RAILWAY.md`
- Consulta logs en Railway Dashboard
- Revisa la documentación de Railway
- Busca en Railway Discord

---

**Última actualización**: Noviembre 2025
