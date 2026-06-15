<div align="center">

# 🅿️ SmartPark — Intelligent Parking Management System

### A full-stack, production-deployed **Intelligent Transport System (ITS)** with a complete DevOps pipeline.

*Real-time slot tracking · Automated billing · Role-based dashboards · CI/CD · Containerized · Security-scanned*

<br/>

[![Python](https://img.shields.io/badge/Python-3.11-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/Flask-3.0-000000?style=for-the-badge&logo=flask&logoColor=white)](https://flask.palletsprojects.com/)
[![SQLite](https://img.shields.io/badge/SQLite-3-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://www.sqlite.org/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![Render](https://img.shields.io/badge/Deployed%20on-Render-46E3B7?style=for-the-badge&logo=render&logoColor=white)](https://render.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

</div>

---

## 📖 Overview

**SmartPark** is an end-to-end smart parking solution that digitizes the entire parking lifecycle — from discovering a free slot to receiving an itemized exit receipt. It pairs a clean, dark-mode web experience with a **fully automated DevOps pipeline** (build → scan → containerize → deploy), demonstrating both application engineering and modern delivery practices.

> Built as part of an **Intelligent Transport Systems (ITS)** project to showcase full-stack development, secure authentication, real-time state management, and CI/CD automation.

---

## ✨ Highlights

- 🔄 **Real-time slot availability** — live grid auto-refreshes via a JSON API; no page reloads.
- 🔐 **Secure authentication** — hashed passwords (Werkzeug), session management, and role-based access control (User / Admin).
- ⏱️ **Live parking timer & automated billing** — duration tracked to the second, cost computed on exit with a transparent rate model.
- 🧾 **Itemized digital receipts** — entry/exit time, duration, rate, and total cost.
- 🛠️ **Full admin control panel** — manage slots, monitor revenue, and audit every booking across all users.
- 🚀 **Production CI/CD** — Jenkins pipeline with code quality, security scanning, containerization, and automated deployment.

---

## 🧩 Tech Stack

| Layer | Technologies |
|-------|--------------|
| **Frontend** | HTML5, CSS3 (custom dark-mode UI), Vanilla JavaScript, Font Awesome 6, Google Fonts (Inter) |
| **Backend** | Python 3.11, Flask 3.0 |
| **Database** | SQLite 3 |
| **Auth & Security** | Werkzeug password hashing, server-side sessions |
| **DevOps** | Docker, Jenkins, SonarCloud (static analysis), Trivy (vulnerability scanning), DockerHub, Render |

---

## 🏗️ DevOps Pipeline

This project ships through a complete, automated delivery pipeline — not just a local script.

```
 ┌──────────┐   ┌───────────────┐   ┌────────────┐   ┌──────────────┐   ┌────────────┐   ┌──────────┐
 │  GitHub  │ → │  SonarCloud   │ → │   Trivy    │ → │ Docker Build │ → │  DockerHub │ → │  Render  │
 │  (push)  │   │ code quality  │   │ vuln scan  │   │  & package   │   │   push     │   │  deploy  │
 └──────────┘   └───────────────┘   └────────────┘   └──────────────┘   └────────────┘   └──────────┘
```

| Stage | Tooling | Purpose |
|-------|---------|---------|
| **Code Quality** | SonarCloud | Static analysis, bugs & code smells |
| **Security Scan** | Trivy | Dependency & filesystem vulnerability scanning |
| **Containerization** | Docker | Reproducible `python:3.11-slim` image |
| **Registry** | DockerHub | Versioned image storage |
| **Deployment** | Render | Zero-touch cloud deployment |

*Pipeline defined in [`Jenkinsfile`](Jenkinsfile) · Container defined in [`Dockerfile`](Dockerfile).*

---

## 🚀 Quick Start

### Option A — Run with Python

```bash
# 1. Clone the repository
git clone https://github.com/sirrj4rvis/smart-parking.git
cd smart-parking

# 2. Install dependencies
pip install -r requirements.txt

# 3. Run the app
python app.py
```

Open **http://127.0.0.1:5000** — the SQLite database is auto-created and seeded with **15 demo slots** on first run.

### Option B — Run with Docker

```bash
docker build -t smart-parking .
docker run -p 5000:5000 smart-parking
```

---

## 🔑 Demo Credentials

| Role  | Email               | Password   |
|-------|---------------------|------------|
| **Admin** | `admin@parking.com` | `admin123` |
| **User**  | *register your own account* | *your choice* |

---

## 🎯 Features

<table>
<tr>
<th>👤 User</th>
<th>🛡️ Admin</th>
</tr>
<tr>
<td valign="top">

- Register / Login / Logout
- Live parking grid 🟢 Available / 🔴 Occupied
- Filter slots by vehicle type (Car / Bike / Truck)
- Book a slot with vehicle number
- Live parking timer (HH:MM:SS)
- Exit & receive itemized receipt
- Personal booking history

</td>
<td valign="top">

- Statistics dashboard (slots, users, revenue)
- Add new parking slots
- Delete slots (guarded against occupied ones)
- Manually toggle slot status
- View **all** bookings system-wide
- Live revenue tracking

</td>
</tr>
</table>

---

## 💰 Billing Logic

A transparent, hour-based pricing model with a one-hour minimum:

```
Hours Billed = max(ceil(Duration in Minutes / 60), 1)
Total Cost   = Hours Billed × Rate per Hour (₹)
```

> **Example:** 45 minutes at ₹30/hr → 1 hour billed → **₹30**

---

## 🗄️ Data Model

| Table | Purpose |
|-------|---------|
| `users` | Registered users and admins (hashed credentials, roles) |
| `parking_slots` | All slots with location, vehicle type, rate & live status |
| `bookings` | Each parking session — entry/exit times, duration & computed cost |

---

## 📁 Project Structure

```
smart-parking/
├── app.py              # Flask backend — routes, auth, billing logic
├── schema.sql          # Database table definitions
├── requirements.txt    # Python dependencies
├── Dockerfile          # Container image definition
├── Jenkinsfile         # CI/CD pipeline (Sonar → Trivy → Docker → Render)
├── templates/          # Jinja2 templates
│   ├── base.html       # Shared layout (navbar, footer)
│   ├── index.html      # Landing page
│   ├── login.html · register.html
│   ├── dashboard.html  # User slot grid
│   ├── booking.html · receipt.html · my_bookings.html
│   └── admin/          # Admin dashboard, slot & booking management
└── static/
    ├── css/style.css   # Dark-mode premium UI
    └── js/main.js      # Live timer, slot filter, auto-refresh
```

---

## 🌐 API

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/slots` | `GET` | Returns live slot statuses as JSON (powers the auto-refresh grid) |

---

## 📜 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Built with ☕ and Flask** · Star ⭐ the repo if you find it useful!

</div>
