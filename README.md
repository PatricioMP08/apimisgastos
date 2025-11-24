🛠️ Backend – API MiGasto (Lumen + SQLite)

Este es el backend del proyecto MiGasto, una API ligera construida con Lumen que gestiona transacciones financieras usando SQLite como base de datos local.
Su propósito es proporcionar un sistema rápido y simple para almacenar, listar y crear transacciones financieras.

📦 Tecnologías utilizadas

Lumen (Laravel Micro-Framework)
SQLite
Eloquent ORM
PHP 8+
Composer

🗂️ Estructura relevante del proyecto

/app
   /Http
      /Controllers
         TransactionController.php   ← Controlador principal
/database
   database.sqlite                   ← Archivo SQLite
/routes
   web.php                           ← Rutas de la API

🧠 Funcionalidad del Backend

El backend se encarga de:

Almacenar transacciones en SQLite
Validar datos recibidos desde el frontend
Exponer endpoints REST simples
Servir información en formato JSON
El archivo clave es TransactionController.php, donde se implementan las operaciones principales sobre las transacciones.

🧩 Métodos principales en TransactionController.php
index()
    Obtiene todas las transacciones desde SQLite
    Retorna un JSON con toda la lista
    Puede ordenar las transacciones si se necesita

store()
    Recibe datos desde el frontend (JSON)
    Valida monto, categoría, fecha, etc.
    Crea una nueva transacción con Eloquent
    Guarda automáticamente en database/database.sqlite
    Retorna la transacción recién creada

🔌 Rutas definidas (en routes/web.php)
Método	Ruta	                    Acción	    Descripción
GET	    /api/transacciones	        index()	    Listar todas las transacciones
POST	/api/transacciones/agregar	store()	    Crear una nueva transacción

💾 Uso de SQLite

Este backend utiliza SQLite como base de datos por su simplicidad y portabilidad.

Configuración en .env:
DB_CONNECTION=sqlite
DB_DATABASE=./database/database.sqlite

Crear archivo SQLite:
mkdir -p database
touch database/database.sqlite
chmod 664 database/database.sqlite

🚀 Instalación del proyecto

Instalar dependencias:
composer install

Crear archivo .env:
cp .env.example .env

Configurar .env para SQLite.

Si usas migraciones:
php artisan migrate

▶️ Ejecutar el backend

Puedes usar el servidor embebido de PHP:
php -S localhost:8000 -t public

Acceso a la API:

GET http://localhost:8000/api/transacciones
POST http://localhost:8000/api/transacciones/agregar

🧪 Ejemplo de Request

POST – Crear transacción

POST /api/transacciones/agregar
Content-Type: application/json

{
  "monto": 7500,
  "categoria": "Transporte",
  "fecha": "2025-01-20",
  "descripcion": "Viaje en bus"
}

📜 Respuesta típica
{
  "id": 1,
  "monto": 7500,
  "categoria": "Transporte",
  "fecha": "2025-01-20",
  "descripcion": "Viaje en bus",
  "created_at": "2025-01-20T12:34:56Z"
}
