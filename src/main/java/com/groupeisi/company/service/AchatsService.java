package com.groupeisi.company.service;

import com.groupeisi.company.dao.AchatsDao;
import com.groupeisi.company.dao.ProduitsDao;
import com.groupeisi.company.dto.AchatsDto;
import com.groupeisi.company.entities.Achats;
import com.groupeisi.company.entities.Produits;
import com.groupeisi.company.mapper.AchatsMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.stream.Collectors;

public class AchatsService {

    private static final Logger log = LoggerFactory.getLogger(AchatsService.class);

    private AchatsDao achatsDao = new AchatsDao();
    private ProduitsDao produitsDao = new ProduitsDao();
    private AchatsMapper achatsMapper = AchatsMapper.INSTANCE;

    //  Créer un achat
    public AchatsDto save(AchatsDto achatsDto) {
        // Règle métier : mise à jour du stock après achat
        Produits produit = produitsDao.findById(achatsDto.getProduitId());
        if (produit == null) {
            log.error("Produit non trouvé id={}", achatsDto.getProduitId());
            return null;
        }
        // Le stock AUGMENTE lors d'un achat (on achète pour stocker)
        produit.setStock(produit.getStock() + achatsDto.getQuantity());
        produitsDao.save(produit);

        Achats achats = achatsMapper.toEntity(achatsDto);
        achats = achatsDao.save(achats);
        log.info("Achat enregistré, nouveau stock : {}", produit.getStock());
        return achatsMapper.toDto(achats);
    }

    //  Chercher par ID
    public AchatsDto findById(Long id) {
        Achats achats = achatsDao.findById(id);
        if (achats == null) return null;
        return achatsMapper.toDto(achats);
    }

    // Tous les achats
    public List<AchatsDto> findAll() {
        return achatsDao.findAll()
                .stream()
                .map(achatsMapper::toDto)
                .collect(Collectors.toList());
    }

    //  Mettre à jour
    public AchatsDto update(AchatsDto achatsDto) {
        Achats achats = achatsMapper.toEntity(achatsDto);
        achats = achatsDao.save(achats);
        return achatsMapper.toDto(achats);
    }

    // Supprimer
    public void delete(Long id) {
        Achats achats = achatsDao.findById(id);
        if (achats != null) {
            achatsDao.delete(achats);
        }
    }

    // Achats par utilisateur
    public List<AchatsDto> findByUser(Long userId) {
        return achatsDao.findByUser(userId)
                .stream()
                .map(achatsMapper::toDto)
                .collect(Collectors.toList());
    }
}