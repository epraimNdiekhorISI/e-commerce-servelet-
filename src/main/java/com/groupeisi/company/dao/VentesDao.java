package com.groupeisi.company.dao;

import com.groupeisi.company.entities.Ventes;
import com.groupeisi.company.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class VentesDao implements IDao<Ventes, Long> {

    private static final Logger log = LoggerFactory.getLogger(VentesDao.class);

    @Override
    public Ventes save(Ventes ventes) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            if (ventes.getId() == null) {
                em.persist(ventes);
                log.info("Vente créée pour le produit : {}", ventes.getProduit().getName());
            } else {
                ventes = em.merge(ventes);
                log.info("Vente mise à jour id={}", ventes.getId());
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            log.error("Erreur sauvegarde vente : {}", e.getMessage());
        } finally {
            em.close();
        }
        return ventes;
    }


    @Override
    public Ventes findById(Long id) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Ventes.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Ventes> findAll() {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT v FROM Ventes v", Ventes.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Ventes ventes) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            Ventes managed = em.merge(ventes);
            em.remove(managed);
            em.getTransaction().commit();
            log.info("Vente supprimée id={}", ventes.getId());
        } catch (Exception e) {
            em.getTransaction().rollback();
            log.error("Erreur suppression vente : {}", e.getMessage());
        } finally {
            em.close();
        }
    }

    //Toute les ventes d'un utilisateur
    public List<Ventes> findByUser(Long userId) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery(
                            "SELECT v FROM Ventes v WHERE v.user.id = :userId", Ventes.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

}
