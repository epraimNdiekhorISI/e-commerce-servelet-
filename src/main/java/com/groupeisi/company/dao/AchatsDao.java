package com.groupeisi.company.dao;

import com.groupeisi.company.entities.Achats;
import com.groupeisi.company.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import lombok.extern.slf4j.Slf4j;


import java.util.List;

@Slf4j
public class AchatsDao implements IDao<Achats, Long>{

    @Override
    public Achats save(Achats achats) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try  {
            em.getTransaction().begin();
            if (achats.getId()  == null) {
                em.persist(achats);
                log.info("Achat créé pour le produit : {}", achats.getProduit().getName());
            } else {
                achats = em.merge(achats);
                log.info("Achats mise à jour id = {}", achats.getId());
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            log.error("Erreur sauvegarde achat : {}", e.getMessage());
        } finally {
            em.close();
        }
        return achats;
    }

    @Override
    public Achats findById(Long id) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try   {
            return em.find(Achats.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Achats> findAll() {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT a FROM Achats a", Achats.class)
                    .getResultList();
        }  finally {
            em.close();
        }
    }

    @Override
    public void delete(Achats achats) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            Achats managed = em.merge(achats);
            em.remove(managed);
            em.getTransaction().commit();
            log.info("Achat supprimé id = {}", achats.getId());
        } catch (Exception e) {
            em.getTransaction().rollback();
            log.error("Erreur suppression  achat : {}", e.getMessage());
        } finally {
            em.close();
        }

    }

    // tous les achats d'un utilisateur
    public List<Achats> findByUser(Long userId){
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT a FROM Achats a WHERE a.user.id = :useId", Achats.class)
                    .setParameter("useId", userId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
