package com.groupeisi.company.dao;

import com.groupeisi.company.entities.Produits;
import com.groupeisi.company.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class ProduitsDao implements IDao<Produits, Long> {

    private static final Logger log = LoggerFactory.getLogger(ProduitsDao.class);

    @Override
    public Produits save(Produits produits) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            if (produits.getId() == null) {
                em.persist(produits);
                log.info("Produit créé : {}", produits.getName());
            } else  {
                produits = em.merge(produits);
                log.info("Produit mise à jour : {}", produits.getName());
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            log.error("Erreur sauvegarde produit : {}", e.getMessage());
        } finally {
            em.close();
        }
        return produits;
    }

    @Override
    public Produits findById(Long id) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try  {
            return em.find(Produits.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Produits> findAll() {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try   {
            return em.createQuery("SELECT p FROM Produits p", Produits.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Produits produits) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            Produits managed = em.merge(produits);
            em.remove(managed);
            em.getTransaction().commit();
            log.info("Produuit supprimé : {}", produits.getName());
        } catch (Exception e) {
            em.getTransaction().rollback();
            log.error("Erreur suppression produit : {}", e.getMessage());
        } finally {
            em.close();
        }
    }

    // recherche par reference
    public Produits findByRef(String ref) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Produits p WHERE p.ref = :ref", Produits.class)
                    .setParameter("ref", ref)
                    .getSingleResult();
        } catch (Exception e) {
            log.warn("Aucun produit trouvé avec la ref : {}", ref);
            return null;
        } finally {
            em.close();
        }
    }
}
