# Project-3-tier_arc using all concepts of Docker

>This project demonstrates a **Three-Tier Application Architecture** deployed using **Docker** and **Docker Compose** on an **AWS EC2 (Amazon Linux 2023)** instance.

- [To understand the project flow, refer to the screenshots below.  👇](#example-0)
- [The code for this project is provided above.   👆 ]()


The architecture separates the application into three logical layers:

1. **Web Tier (Nginx)** – Handles HTTP requests
2. **Application Tier (PHP-FPM)** – Processes business logic
3. **Database Tier (MySQL)** – Stores application data



  <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/doc.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>


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

## 🧰 Technologies Used

* AWS EC2 (Amazon Linux 2023)
* Docker
* Docker Compose
* Nginx
* PHP-FPM (Bitnami Image)
* MySQL
* Linux CLI

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



---

## 🪜 Step 1: Connect to EC2 Instance

```bash
ssh -i server1.pem ec2-user@<EC2_PUBLIC_IP>
```

Switch to root user:

```bash
sudo -i
```

---

## 📁 Step 2: Create Project Root Directory

```bash
cd /home/ec2-user
mkdir three_tier
cd three_tier
```

---

## 📂 Step 3: Create Three-Tier Folders

```bash
mkdir web app db
```

Directory structure now:

```
three_tier/
├── web/
├── app/
└── db/
```

---

## 🌐 Step 4: Web Tier (Nginx) Setup

### Create folders

```bash
cd web
mkdir code config
```

### Add HTML code

```bash
cd code
nano signup.html
```

(Add your HTML signup form here and save)

### Add Nginx config

```bash
cd ../config
nano default.conf
```

This config tells Nginx to forward PHP requests to the App container using FastCGI.

---

## ⚙️ Step 5: Application Tier (PHP-FPM) Setup

```bash
cd ../../app
mkdir code
cd code
nano submit.php
```

This PHP file receives form data and sends it to MySQL.

---

## 🗄️ Step 6: Database Tier (MySQL) Setup

```bash
cd ../../db
nano Dockerfile
```

Dockerfile builds a custom MySQL image.

Create SQL initialization file:

```bash
nano init.sql
```

This file:

* Creates database
* Creates table
* Inserts initial data

---

## 🧩 Step 7: Create docker-compose.yml

```bash
cd ..
nano docker-compose.yml
```

This file:

* Defines **web, app, db services**
* Creates **networks** and **volumes**
* Connects containers using service names

---

## ▶️ Step 8: Start the Project

```bash
docker-compose up -d
```

Docker will:

* Pull required images
* Build MySQL image
* Create networks & volume
* Start all three containers

---

## 🔍 Step 9: Verify Containers

```bash
docker ps
```

You should see:

* three_tier-web-1
* three_tier-app-1
* three_tier-db-1

---

## 🌍 Step 10: Access Application

Open browser:

```
http://<EC2_PUBLIC_IP>/signup.html
```

Submit the form → data will be stored in MySQL.

---

## 🧪 Step 11: Verify Database Data

```bash
docker exec -it three_tier-db-1 /bin/bash
mysql -u root -p
```

```sql
SHOW DATABASES;
USE FCT;
SELECT * FROM users;
```

---

## 🛑 Step 12: Stop or Clean Project

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

---
---
---


<a id="example-0"></a>


# Screenshot's

-  We removed everything that was created earlier—such as containers, images, networks, and volumes—to start fresh for our project.


   <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20204204.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>
  
---

- Create a project Directory and their reladed folders

  
<p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20210653.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>


---


- Then, place the required scripts and code files inside their respective folders.

  <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20211012.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>

  <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20211058.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>


---

- Run the `docker-compose file`

  
  <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20211511.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>


👍Here, everything required to run the project has been added, and the project is now running successfully.
---
---

- Ways to view the output
  - Hit the `public ip` in browser
  - You can go inside the database container and check the data.
    


Webpage output after accessing the application using the IP address.
  <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20183515.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>


---


Output after submitting the data.

  <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20183539.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>


---


Output after entering data – browser view and database container view.


  <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20184054.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>


---


Or How to access the data inside the database container
  <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20212819.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>



  <p align="center">
  <img src="https://github.com/nikiimisal/Project_3-tier_arc-using-all-concepts-of-Docker/blob/main/img/Screenshot%202026-01-16%20212851.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>

-----




































