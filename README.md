# 🎬 Most Wanted Movies – Movie Rental & Review Platform
A web-based Movie Rental and Review Platform that allows users to browse, rent, download, and review movies dynamically. This application serves both movie enthusiasts and administrators with a complete movie catalog, rental, and review management solution.
## 🎯 Project Overview

Most Wanted Movies is a lightweight yet feature-rich web platform built with Java, JSP, and Servlets that allows users to browse, rent, download, and review movies. It uses plain text files for data storage — showcasing how powerful applications can be developed even without a traditional database.

## ✨ Features

### 💠 User Features
- **Browse & Discover**: View movies with title, genre, rating, and description.
- **Rent & Download**: Securely rent movies and manage downloads.
- **Review System**: Submit, edit, and delete movie reviews.
- **Watch Later**: Save movies for future viewing.
- **Account Management**: Register, log in, and delete your account.

### 💠 Admin Features
- **Movie Management**: Add, update, or delete movies from the catalog.
- **User Management**: Manage and remove user accounts.
- **Review Management**: Monitor, edit, or delete user-submitted reviews.

---

## 🧑‍💻 Tech Stack
- **Backend**: Java Servlets (MVC pattern) for business logic and request handling.
- **Frontend**: JSP for dynamic content, HTML, CSS, JavaScript for UI.
- **Storage**: Plain text files (CSV-style format) for all data (coursework requirement).
- **Utilities**: Custom `FileHandler` class for reading, writing, and parsing data.

---

## 🎯 Project Structure

```
MostWantedMovies/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── movie/
│   │   │           ├── model/                   # Java classes for entities
│   │   │           ├── servlet/                 # Servlets grouped by functionality
│   │   │           │   ├── AdminLogin/
│   │   │           │   ├── DownloadsManagement/
│   │   │           │   ├── MovieManagement/
│   │   │           │   ├── RentalManagement/
│   │   │           │   ├── ReviewsManagement/
│   │   │           │   ├── UserManagement/
│   │   │           │   └── WatchLaterListManagement/
│   │   │           └── utils/                   # Utility/helper classes
│   │   └── webapp/
│   │       ├── *.jsp                            # JSP pages for user & admin
│   │       ├── data/                            # Text file storage for project data
│   │       │   ├── downloads.txt
│   │       │   ├── movies.txt
│   │       │   ├── recently_watched.txt
│   │       │   ├── rented_movies.txt
│   │       │   ├── reviews.txt
│   │       │   ├── users.txt
│   │       │   └── watch_later.txt
│   │       └── images/                          # Image resources
├── web/
│   └── WEB-INF/
│       └── web.xml                              # Deployment descriptor
└── README.md                                    # Project documentation
```
---

## 🚀 Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/SadeeshaJayawardhana/MostWantedMovies.git
   ```
2. Save it inside a folder in desktop and rename it as Project.
3. Open the project in IntelliJ IDEA.
4. Install Java Development Kit (JDK) 21.
5. Configure your server (Apache Tomcat 9.x).
6. Deploy and run.
---

## 📌 Usage

* **User Side:**

  * Open the application in a browser.
  * Browse movies or search for specific titles.
  * Rent/download movies and leave reviews.
  * Manage your watch list and account settings.
* **Admin Side:**

  * Login via the admin portal.
  * Manage movie catalog and user accounts.
  * Moderate user reviews.
---

## 📄 License

This project is licensed under the MIT License.

---

<p align="center">✨ Developed by <strong>Sadeesha Jayawardhana</strong> ✨</p>

