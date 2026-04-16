package com.groupeisi.company.dao;

import com.groupeisi.company.entities.Users;
import com.groupeisi.company.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;


public class UsersDao implements IDao<Users, Long> {

    private static final Logger log = LoggerFactory.getLogger(UsersDao.class);

    @Override
    public Users save(Users users) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            if (users.getId() == null) {
                em.persist(users);
                log.info("Utilisateur créé : {}", users.getEmail());
            } else {
                em.merge(users);
                log.info("Utilisateur mis à jour : {}", users.getEmail());
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            log.error("Erreur de sauvegarde : {}", e.getMessage());
        } finally {
            em.close();
        }
        return users;
    }

    @Override
    public Users findById(Long id) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            Users users = em.find(Users.class, id);
            log.info("Recherche utilisateur id={} : {}", id, users != null ? "trouvé" : "non trouvé");
            return users;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Users> findAll() {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            // ✅ CORRECTION #2 : createQuery (pas createNamedQuery)
            List<Users> list = em.createQuery("SELECT u FROM Users u", Users.class).getResultList();
            log.info("Nombre d'utilisateurs trouvés : {}", list.size());
            return list;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Users users) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            Users managed = em.merge(users);
            em.remove(managed);
            em.getTransaction().commit();
            log.info("Utilisateur supprimé : {}", users.getEmail());
        } catch (Exception e) {
            em.getTransaction().rollback();
            log.error("Erreur lors de la suppression : {}", e.getMessage());
        } finally {
            em.close();
        }
    }


    public Users findByEmail(String email) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT u FROM Users u WHERE u.email = :email", Users.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (Exception e) {
            log.warn("Aucun utilisateur trouvé avec l'email : {}", email);
            return null;
        } finally {
            em.close();
        }
    }


    public Users findByEmailAndPassword(String email, String password) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery(
                            "SELECT u FROM Users u WHERE u.email = :email AND u.password = :password",
                            Users.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (Exception e) {
            log.warn("Authentification échouée pour : {}", email);
            return null;
        } finally {
            em.close();
        }
    }
}