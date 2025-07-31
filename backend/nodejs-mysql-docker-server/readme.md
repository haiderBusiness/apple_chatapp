# Node.js + MySQL App (Dockerized)

A simple Node.js REST API using MySQL as the database, fully containerized using Docker. Designed for easy local development and ready to deploy to cloud platforms like DigitalOcean, AWS, or others.

---

## 📦 Features

- Node.js Express API
- MySQL 8.0 database
- Docker + Docker Compose
- `.env` for configuration
- Wait-for script ensures DB is ready before app starts

---

## 🚀 Quick Start

### 1. Install Requirements

- Docker Desktop (https://www.docker.com/products/docker-desktop)
- (Optional) Node.js for local development

### 2. Clone This Repository

```bash
git clone https://github.com/yourusername/my-node-mysql-app.git
cd my-node-mysql-app
```

---

### 3. Create a `.env` File

Create a `.env` file in the project root with the following:

```env
DB_HOST=db
DB_USER=testuser
DB_PASSWORD=password
DB_NAME=testdb
```

---

### 4. Build and Run the App

```bash
docker compose up --build
```

This will:

- Build the Node.js app container  
- Start a MySQL 8.0 container  
- Wait for MySQL to be ready before launching the app  

---

## 🌐 API Endpoints

### `GET /api/users`

Returns a list of users from the database.

### `POST /api/users`

Creates a new user.

**Body Example (JSON):**
```json
{
  "name": "Alice"
}
```

---

## 🛠 Database Notes

On first run, you need to create the `users` table manually unless using the auto-create logic in `db.js`.

You can do this by accessing the MySQL container:

```bash
docker exec -it my-node-mysql-app-db-1 mysql -u testuser -p
# password: password

USE testdb;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);
```

Or use the built-in table creation logic in `db.js`.

---

## 🔧 Project Structure

```text
my-node-mysql-app/
├── Dockerfile
├── docker-compose.yml
├── wait-for.sh
├── .env
├── index.js
├── db.js
├── package.json
└── README.md
```

---

## 🔁 Common Commands

| Command                                 | Description                                |
|-----------------------------------------|--------------------------------------------|
| `docker compose up --build`            | Build and run the containers               |
| `docker compose down`                  | Stop and remove containers                 |
| `docker compose down -v`               | Also remove volumes (e.g. clean MySQL data)|
| `docker exec -it <container> bash`     | Access a running container (like a shell)  |

---

## 👨‍💻 Contributing

If someone new is picking this up:

- Make sure Docker Desktop is running.
- Clone the repo.
- Create a `.env` file.
- Run: `docker compose up --build`
- Add new endpoints to `index.js` or update DB schema in `db.js`.

---

## 📤 Deployment

This app is ready for deployment to cloud platforms. You can:

- Push it to GitHub
- Use Docker Hub or another image registry
- Deploy to DigitalOcean using App Platform or a droplet with Docker

---

## 📧 Support

If you have questions, open an issue or contact the original developer.
