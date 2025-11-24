# 🛠️ Backend – API MiGasto (Lumen + SQLite)

**MiGasto Backend** es una **API REST** ligera y simple, diseñada para gestionar transacciones financieras de forma rápida. Está construida con **Lumen**, el micro-framework de Laravel, y utiliza **SQLite** para un almacenamiento de datos local y portátil.

---

## 🎯 Propósito

El objetivo principal de esta API es proporcionar un sistema sencillo para:

* **Almacenar** transacciones financieras.
* **Listar** todas las transacciones existentes.
* **Crear** nuevas entradas mediante un endpoint REST simple.

---

## 📦 Tecnologías Utilizadas

| Tecnología | Descripción |
| :--- | :--- |
| **Lumen** | El micro-framework de Laravel, optimizado para APIs rápidas. |
| **SQLite** | Base de datos ligera, sin servidor, ideal para entornos locales. |
| **Eloquent ORM** | El ORM de Laravel para una interacción fluida con la base de datos. |
| **PHP 8+** | El lenguaje de programación principal. |
| **Composer** | Administrador de dependencias de PHP. |

---

## 🧠 Estructura y Funcionalidad

El núcleo del backend reside en el **`TransactionController.php`**, encargado de:

1.  **Validar** los datos de entrada del frontend.
2.  **Almacenar** las transacciones en el archivo **`database/database.sqlite`**.
3.  **Exponer** endpoints REST para las operaciones clave.
4.  **Servir** la información de las transacciones en formato **JSON**.

### 🗂️ Estructura Relevante del Proyecto

* `/app/Http/Controllers/TransactionController.php` **← Controlador principal**
* `/database/database.sqlite` **← Archivo de la base de datos**
* `/routes/web.php` **← Rutas de la API**

### 📝 Métodos Principales en `TransactionController.php`

| Método | Acción | Descripción |
| :--- | :--- | :--- |
| **`index()`** | Listar | Obtiene todas las transacciones desde SQLite y las retorna en JSON. |
| **`store()`** | Crear | Recibe, valida datos (monto, categoría, fecha, etc.), crea la transacción con Eloquent y la guarda. |

---

## 🔌 Rutas de la API

Las rutas están definidas en `routes/web.php`:

| Método HTTP | Ruta | Acción | Descripción |
| :--- | :--- | :--- | :--- |
| **GET** | `/api/transacciones` | `index()` | Lista todas las transacciones. |
| **POST** | `/api/transacciones/agregar` | `store()` | Crea una nueva transacción. |

---

## 💾 Uso y Configuración de SQLite

Se utiliza **SQLite** por su simplicidad, portabilidad y la eliminación de un servidor de base de datos externo.

### Configuración de `.env`

Asegúrate de que tu archivo `.env` contenga:

```ini
DB_CONNECTION=sqlite
DB_DATABASE=./database/database.sqlite
```


🛠️ Inicialización de la Base de Datos
Para preparar el archivo de base de datos local:

mkdir -p database
touch database/database.sqlite
chmod 664 database/database.sqlite

🚀 Instalación y Ejecución
Sigue estos pasos para levantar el proyecto en tu entorno local.

1. Instalación de Dependencias: composer install
2. Configuración Inicial: Crea el archivo .env (si no existe) y configúralo para SQLite: cp .env.example .env
   Si usas migraciones: php artisan migrate
3. Ejecutar el Servidor
   La API estará accesible en: http://localhost:8000
    
