AGENDA CNP — VERSIÓN CON SINCRONIZACIÓN EN SUPABASE

ARCHIVOS
- index.html: aplicación modificada (mantiene la agenda local y añade acceso/sincronización).
- sw.js: service worker con caché actualizada para publicar la nueva versión.
- manifest.webmanifest: manifiesto PWA original.
- supabase.sql: tabla y políticas privadas de seguridad.

PASOS DE CONFIGURACIÓN
1. Crea un proyecto en https://supabase.com/ (guarda la contraseña del proyecto).
2. En el proyecto, abre SQL Editor, pega el contenido de supabase.sql y pulsa Run.
3. En Project Settings > API (o API Keys), copia Project URL y la clave publicable/anon (NUNCA service_role ni secret key).
4. Abre index.html y sustituye:
   SUPABASE_URL='https://TU-PROYECTO.supabase.co'
   SUPABASE_ANON_KEY='PEGA_AQUI_TU_CLAVE_ANON_PUBLICABLE'
   por los valores reales.
5. En Supabase > Authentication, deja habilitado el proveedor Email. Abre la app, usa «Crear mi cuenta» con tu correo y contraseña y confirma el correo si Supabase lo solicita. Después, en los ajustes de Authentication/User Signups, desactiva «Allow new users to sign up» para que nadie más pueda registrarse. Tu usuario existente podrá seguir iniciando sesión.
6. Publica los archivos index.html, sw.js y manifest.webmanifest en el repositorio GitHub Pages, sustituyendo los anteriores.
7. Abre la app con conexión, inicia sesión. Si aún no existe fila en la nube, la app subirá automáticamente los datos locales. Si ya existe una copia remota y hay cambios locales pendientes, te preguntará qué copia conservar.

NOTAS IMPORTANTES
- La app sigue guardando localmente cada cambio. Sin conexión no se pierden los cambios; se sincronizan al volver a tener conexión y sesión activa.
- La sincronización actual usa una única copia JSON por cuenta (sencilla y adecuada para uso personal). Si editas simultáneamente la agenda en dos dispositivos mientras están desconectados, el último envío puede sustituir al otro. Para evitarlo, sincroniza un dispositivo antes de editar en otro.
- La primera carga de la biblioteca Supabase requiere conexión. Una vez cargada y con sesión iniciada, la interfaz y los datos locales siguen disponibles offline.
- No pongas nunca la clave service_role en index.html ni en GitHub.
