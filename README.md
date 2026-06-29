```
  ██████╗██╗███╗   ██╗███████╗███╗   ███╗ █████╗
 ██╔════╝██║████╗  ██║██╔════╝████╗ ████║██╔══██╗
 ██║     ██║██╔██╗ ██║█████╗  ██╔████╔██║███████║
 ██║     ██║██║╚██╗██║██╔══╝  ██║╚██╔╝██║██╔══██║
 ╚██████╗██║██║ ╚████║███████╗██║ ╚═╝ ██║██║  ██║
  ╚═════╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝
```

# 🎬 Cinema — Spring Boot

A complete Cinema Management web application built with **Spring Boot**, **Spring Security**, **Spring Data JPA**, **Freemarker**, **PostgreSQL**, **WebSockets**, and **JavaMail**.

This project was developed as part of the **Spring Boot – More, Than Spring** module at **42 Network / 1337**. It extends the previous Cinema projects by introducing authentication, authorization, localization, validation, and email account verification.

---

# ✨ Features

## 👤 Authentication & Security

- Custom Sign In / Sign Up pages
- Spring Security authentication
- Role-based authorization
- Remember-Me support
- CSRF protection
- BCrypt password hashing
- Email confirmation before login

---

## 🔐 Authorization

### Administrator

- Manage movie halls
- Manage films
- Manage sessions
- Access profile page

### Authenticated Users

- Browse movie sessions
- Search sessions
- Join movie chat rooms
- Upload avatars
- View profile

---

## 📧 Email Verification

- Confirmation email sent after registration
- Unique UUID verification token
- Account activation through email link
- Unverified users cannot log in

---

## 🌍 Internationalization (i18n)

Supports multiple languages:

- 🇺🇸 English
- 🇫🇷 French
- 🇲🇦 Arabic

Localization includes:

- Navigation
- Authentication pages
- Validation messages
- Success & error messages

Language selection is stored inside browser cookies.

---

## ✅ Form Validation

Registration validation includes:

- Username required
- Email format validation
- Password strength validation
- Phone number validation
- Required fields validation
- Terms acceptance

Custom validation:

- `@ValidPassword`
- `@ValidPhoneNumber`

---

## 🎥 Movie Management

Administrators can:

- Create movie halls
- Create films
- Upload posters
- Schedule movie sessions
- Configure ticket prices

---

## 🔍 Live Search

AJAX powered search

- Instant movie search
- Dynamic page updates
- JSON responses
- No page refresh required

---

## 💬 Real-Time Chat

Each movie has its own chat room.

Features:

- STOMP WebSockets
- Live messaging
- Message persistence
- Last 20 messages loaded automatically
- User avatars

---

## 🖼 Avatar Upload

Users can

- Upload avatars
- Store images on the server
- Generate unique filenames
- Display avatars inside chat

---

# 🛠 Tech Stack

## Backend

- Java 21
- Spring Boot
- Spring MVC
- Spring Security
- Spring Data JPA
- Spring Validation
- Spring Mail
- Spring WebSocket (STOMP)
- Hibernate ORM

## Frontend

- Freemarker
- HTML5
- CSS3
- JavaScript
- jQuery

## Database

- PostgreSQL

## Build Tool

- Maven

---

# 📁 Project Structure

```
Cinema
│
├── src
│   ├── main
│   │
│   ├── java
│   │   └── com.cinema
│   │       ├── config
│   │       ├── controllers
│   │       ├── services
│   │       ├── repositories
│   │       ├── models
│   │       ├── validation
│   │       ├── exceptions
│   │       ├── security
│   │       └── websocket
│   │
│   ├── resources
│   │   ├── templates
│   │   ├── static
│   │   ├── i18n
│   │   ├── schema.sql
│   │   ├── data.sql
│   │   └── application.properties
│   │
│   └── uploads
│
├── pom.xml
└── README.md
```

---

# ⚙️ Installation

## Clone repository

```bash
git clone https://github.com/yourusername/Cinema.git
cd Cinema
```

---

## Create database

```sql
CREATE DATABASE cinema;
```

---

## Configure application.properties

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/cinema
spring.datasource.username=postgres
spring.datasource.password=password
```

---

## Configure Mail

```properties
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password

spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
```

Or configure these values using environment variables.

---

## Build

```bash
mvn clean install
```

---

## Run

```bash
mvn spring-boot:run
```

The application will start on

```
http://localhost:8080/cinema
```

---

# 🌐 Main Routes

## Authentication

| Route | Description |
|--------|-------------|
| /signIn | Login |
| /signUp | Register |
| /confirm | Account confirmation |
| /profile | User profile |

---

## Admin

| Route | Description |
|--------|-------------|
| /admin/panel/halls | Manage halls |
| /admin/panel/films | Manage films |
| /admin/panel/sessions | Manage sessions |

---

## User

| Route | Description |
|--------|-------------|
| /sessions | Browse sessions |
| /sessions/search | Live search |
| /sessions/{id} | Session details |
| /films/{id}/chat | Movie chat |
| /films/{id}/messages | Chat history |

---

# 🔌 WebSocket

## Endpoint

```
/ws
```

## Subscribe

```
/topic/films/{filmId}/chat
```

## Send

```
/app/films/{filmId}/chat
```

---

# 📚 Main Concepts

This project demonstrates

- Spring Boot
- Spring MVC
- Spring Security
- Spring Data JPA
- Hibernate ORM
- Bean Validation
- Custom Constraint Validators
- Internationalization (i18n)
- Cookie Locale Resolver
- JavaMailSender
- Email Verification
- BCrypt Password Encoding
- Session Management
- Remember-Me Authentication
- CSRF Protection
- AJAX
- REST APIs
- STOMP WebSockets
- File Upload
- MVC Architecture

---

# 📖 Subject Requirements

This project follows the specifications of the **Spring Boot – More, Than Spring** subject.

Implemented requirements include:

- ✅ Spring Boot application
- ✅ Spring Data JPA repositories
- ✅ Spring Security
- ✅ Custom authentication pages
- ✅ Remember-Me
- ✅ CSRF protection
- ✅ Role-based authorization
- ✅ Localization (i18n)
- ✅ Validation with custom annotations
- ✅ Email confirmation
- ✅ JavaMailSender integration
- ✅ WebSockets
- ✅ AJAX search
- ✅ File upload
- ✅ Persistent chat messages

---

# 👨‍💻 Author

**Elbarae EL-ghannouchi**

Backend Software Engineer

Student at **1337 Coding School (42 Network)**

---

# 📄 License

This project was developed for educational purposes as part of the 42 Network curriculum.
