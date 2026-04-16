-- Script d'initialisation de la base de données ecommerce_db
-- Ce fichier est exécuté automatiquement au premier démarrage du conteneur MySQL

CREATE DATABASE IF NOT EXISTS ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ecommerce_db;

-- Les tables seront créées automatiquement par Hibernate (hbm2ddl.auto=update)
-- Ce script sert uniquement à s'assurer que la base existe

SELECT 'Base de données ecommerce_db initialisée avec succès !' AS message;
