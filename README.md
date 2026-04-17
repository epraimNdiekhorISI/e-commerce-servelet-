# 🛒 E-Commerce Web Application (Java Servlet + JSP)

## 📌 Description

Cette application est une plateforme e-commerce développée en **Java EE (Servlet + JSP)** permettant de gérer les opérations commerciales de base telles que la gestion des produits, des achats, des ventes et des utilisateurs.

Elle repose sur une architecture en couches (DAO, Service, DTO) et utilise **Hibernate (JPA)** pour la persistance des données avec une base de données MySQL.

---

## 🎯 Objectifs du projet

* Mettre en place une architecture web robuste en Java
* Implémenter les opérations CRUD (Create, Read, Update, Delete)
* Gérer les flux commerciaux (achats et ventes)
* Assurer une séparation claire des responsabilités (MVC)

---

## 🧱 Architecture du projet

Le projet suit une architecture en couches :

* **DAO** : Accès aux données
* **Service** : Logique métier
* **DTO** : Objets de transfert de données
* **Entities** : Entités JPA (tables de la base)
* **Mapper** : Conversion entre Entity et DTO
* **Servlet** : Contrôleurs (gestion des requêtes HTTP)
* **JSP** : Interface utilisateur

---

## ⚙️ Technologies utilisées

* Java 17
* Servlet / JSP
* Hibernate (JPA)
* MySQL
* Maven
* Docker (MySQL + phpMyAdmin)

---

## 📁 Structure du projet

```
src/
 └── main/
     ├── java/com/groupeisi/company/
     │   ├── dao/
     │   ├── dto/
     │   ├── entities/
     │   ├── mapper/
     │   ├── service/
     │   ├── servlet/
     │   └── utils/
     │
     └── webapp/
         └── WEB-INF/views/
             ├── achats/
             ├── produits/
             ├── ventes/
             ├── users/
             └── auth/
```

---

## 🚀 Fonctionnalités principales

* 🔐 Authentification (connexion / inscription)
* 📦 Gestion des produits
* 🛒 Gestion des achats
* 💰 Gestion des ventes
* 👥 Gestion des utilisateurs

---

## 🗄️ Base de données

### Configuration

* SGBD : MySQL 8
* Nom de la base : `ecommerce_db`

### Initialisation

```sql
CREATE DATABASE ecommerce_db;
```

Les tables sont générées automatiquement grâce à Hibernate :

```
hibernate.hbm2ddl.auto=update
```

---

## 🐳 Lancement avec Docker

### Démarrer les services

```bash
docker-compose up -d
```

### Accès aux outils

* MySQL : `localhost:3306`
* phpMyAdmin : http://localhost:8081

---

## ▶️ Exécution du projet

1. Cloner le projet

```bash
git clone <url-du-projet>
```

2. Compiler avec Maven

```bash
mvn clean install
```

3. Déployer le fichier `.war` sur un serveur (Tomcat recommandé)

4. Accéder à l’application via :

```
http://localhost:8080/nom-du-projet
```

---

## 🔐 Sécurité

⚠️ Version actuelle :

* Authentification basique via session

Améliorations recommandées :

* Hashage des mots de passe (BCrypt)
* Gestion des rôles (admin/utilisateur)

---

## 📌 Améliorations futures

* Migration vers Spring Boot
* API REST
* Interface moderne (React / Angular)
* Ajout de tests unitaires
* Mise en place de logs

---

## 👨‍💻 Auteur

Projet réalisé dans le cadre d’un apprentissage en développement web Java.

