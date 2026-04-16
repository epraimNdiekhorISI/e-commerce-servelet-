package com.groupeisi.company;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TestLogs {

    private static final Logger log = LoggerFactory.getLogger(TestLogs.class);

    public static void main(String[] args) {

        log.debug("Ceci est un message DEBUG");
        log.info("Ceci est un message INFO");
        log.warn("Ceci est un message WARN");
        log.error("Ceci est un message ERROR");

        log.info("Application ecommerce démarrée ✅");
        log.warn("Stock insuffisant pour le produit id={}", 42);
        log.error("Erreur connexion base de données : {}", "timeout");
    }
}