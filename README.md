# Project-3-tier_arc-using-all concepts of Docker

This project demonstrates a **Three-Tier Application Architecture** deployed using **Docker** and **Docker Compose** on an **AWS EC2 (Amazon Linux 2023)** instance.

The architecture separates the application into three logical layers:

1. **Web Tier (Nginx)** – Handles HTTP requests
2. **Application Tier (PHP-FPM)** – Processes business logic
3. **Database Tier (MySQL)** – Stores application data

---

## 📌 Project Objective

* Understand **Three-Tier Architecture**
* Learn **Docker containerization** concepts
* Use **Docker Compose** for multi-container orchestration
* Implement **custom Docker networks & volumes**
* Deploy and connect services using **service names**

---

## 🏗️ Architecture Overview

```
Browser
   │
   ▼
[Nginx Web Container]
   │ (FastCGI)
   ▼
[PHP-FPM App Container]
   │
   ▼
[MySQL DB Container]
```

Each tier runs in its **own container**, communicating through **Docker networks**.

---

## 🧰 Technologies Used

* AWS EC2 (Amazon Linux 2023)
* Docker
* Docker Compose
* Nginx
* PHP-FPM (Bitnami Image)
* MySQL
* Linux CLI


---

## ⚙️ Infrastructure Setup

### ⚙️  Launch EC2 Instance

* Instance Type: `t3.micro`
* OS: Amazon Linux 2
* Security Group:

  * Allow **SSH (22)**
  * Allow **HTTP (80)**
  * Allow MYSQL**HTTP (3000)**
  * Allow **HTTP (3306)**
  * Allow  PHP-FPM **HTTP (9000)**
  * Allow PHP**HTTP (3306)**
 

> 🔹 Best Practice:<br>
> EC2 can be launched using **Terraform / Jenkins**.<br>
> For better understanding, name the instance:<br>
> **`Ansible-Docker-WordPress`**

---

## 📂 Project Directory Structure

```
three_tier/
├── web/
│   ├── code/
│   │   └── signup.html
│   └── config/
│       └── default.conf
│
├── app/
│   └── code/
│       └── submit.php
│
├── db/
│   ├── Dockerfile
│   └── init.sql
│
└── docker-compose.yml
```

---

## 🌐 Docker Networking

Two custom bridge networks are used:

* **webnet** → Communication between Web & App tier
* **dbnet** → Communication between App & DB tier

Docker service names are used instead of IP addresses.

---

## 💾 Docker Volume

A named volume is created for MySQL data persistence:

* `three_tier_vol1`

This ensures database data is **not lost** even if containers stop or restart.

---

## ⚙️ Docker Compose Services

### 🔹 Web Service (Nginx)

* Image: `nginx:latest`
* Exposes port **80**
* Uses custom Nginx configuration
* Connected to `webnet`

### 🔹 App Service (PHP-FPM)

* Image: `bitnami/php-fpm`
* Exposes port **9000**
* Connected to both `webnet` and `dbnet`

### 🔹 DB Service (MySQL)

* Custom image built from Dockerfile
* Initializes database using `init.sql`
* Uses Docker volume for persistence
* Connected to `dbnet`

---

## ▶️ How to Run the Project

### Step 1: Connect to EC2

```bash
ssh -i server1.pem ec2-user@<EC2_PUBLIC_IP>
```

### Step 2: Switch to Root

```bash
sudo -i
```

### Step 3: Navigate to Project Directory

```bash
cd /home/ec2-user/three_tier
```

### Step 4: Start Containers

```bash
docker-compose up -d
```

---

## 🛑 Stop / Shutdown Containers

* Stop containers only:

```bash
docker-compose stop
```

* Stop and remove containers:

```bash
docker-compose down
```

* Stop and remove containers + volumes:

```bash
docker-compose down -v
```

---

## 🔍 Verification

### Check running containers

```bash
docker ps
```

### Access MySQL container

```bash
docker exec -it three_tier-db-1 /bin/bash
mysql -u root -p
```

### Verify database

```sql
SHOW DATABASES;
USE FCT;
SELECT * FROM users;
```

---

## ✅ Output

* Application accessible via browser using EC2 public IP
* Data submitted via form is stored in MySQL
* Containers communicate securely using Docker networks

---

## 🎯 Key Learnings

* Three-Tier Architecture design
* Docker container lifecycle
* Docker Compose orchestration
* Networking between containers
* Data persistence using volumes
* Real-world deployment workflow

---

## 📌 Conclusion

This project demonstrates a **real-world Three-Tier application deployment** using Docker. It is beginner-friendly and helps bridge the gap between basic Docker concepts and production-level architecture.

---

⭐ *This project is ideal for Cloud & DevOps beginners and interview preparation.*
