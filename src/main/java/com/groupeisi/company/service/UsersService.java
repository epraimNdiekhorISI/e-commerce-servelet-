package com.groupeisi.company.service;

import com.groupeisi.company.dao.UsersDao;
import com.groupeisi.company.dto.UsersDto;
import com.groupeisi.company.entities.Users;
import com.groupeisi.company.mapper.UsersMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.stream.Collectors;

public class UsersService {

    private static final Logger log = LoggerFactory.getLogger(UsersService.class);

    // Le Service utilise le DAO et le Mapper
    private UsersDao usersDao = new UsersDao();
    private UsersMapper usersMapper = UsersMapper.INSTANCE;

    //Créer un utilisateur
    public UsersDto save(UsersDto usersDto) {
        // Règle métier : vérifier que l'email n'existe pas déjà
        Users existing = usersDao.findByEmail(usersDto.getEmail());
        if (existing != null) {
            log.warn("Email déjà utilisé : {}", usersDto.getEmail());
            return null; // On retourne null pour signaler l'échec
        }
        // DTO → Entité → sauvegarde → retour DTO
        Users users = usersMapper.toEntity(usersDto);
        users = usersDao.save(users);
        return usersMapper.toDto(users);
    }

    // Chercher par ID
    public UsersDto findById(Long id) {
        Users users = usersDao.findById(id);
        if (users == null) {
            log.warn("Utilisateur non trouvé id={}", id);
            return null;
        }
        return usersMapper.toDto(users);
    }

    // Récupérer tous les utilisateurs
    public List<UsersDto> findAll() {
        return usersDao.findAll()
                .stream()
                .map(usersMapper::toDto)
                .collect(Collectors.toList());
    }

    // Mettre à jour
    public UsersDto update(UsersDto usersDto) {
        Users users = usersMapper.toEntity(usersDto);
        users = usersDao.save(users);
        return usersMapper.toDto(users);
    }

    // Supprimer
    public void delete(Long id) {
        Users users = usersDao.findById(id);
        if (users != null) {
            usersDao.delete(users);
            log.info("Utilisateur supprimé id={}", id);
        }
    }

    //Authentification
    public Users authenticate(String email, String password) {
        Users user = usersDao.findByEmailAndPassword(email, password);
        if (user != null) {
            log.info("Authentification réussie : {}", email);
        } else {
            log.warn("Authentification échouée : {}", email);
        }
        return user;
    }

    // Ajoute cette méthode après la méthode "save()"
    public Users saveWithPassword(Users user) {
        // Règle métier : vérifier que l'email n'existe pas déjà
        Users existing = usersDao.findByEmail(user.getEmail());
        if (existing != null) {
            log.warn("Email déjà utilisé : {}", user.getEmail());
            return null;
        }
        return usersDao.save(user);
    }
}