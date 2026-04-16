package com.groupeisi.company.service;

import com.groupeisi.company.dao.ProduitsDao;
import com.groupeisi.company.dto.ProduitsDto;
import com.groupeisi.company.entities.Produits;
import com.groupeisi.company.mapper.ProduitsMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.stream.Collectors;

public class ProduitsService {

    private static final Logger log = LoggerFactory.getLogger(ProduitsService.class);

    private ProduitsDao produitsDao = new ProduitsDao();
    private ProduitsMapper produitsMapper = ProduitsMapper.INSTANCE;

    //  Créer un produit
    public ProduitsDto save(ProduitsDto produitsDto) {
        // Règle métier : la référence doit être unique
        Produits existing = produitsDao.findByRef(produitsDto.getRef());
        if (existing != null) {
            log.warn("Référence produit déjà existante : {}", produitsDto.getRef());
            return null;
        }
        Produits produits = produitsMapper.toEntity(produitsDto);
        produits = produitsDao.save(produits);
        return produitsMapper.toDto(produits);
    }

    // Chercher par ID
    public ProduitsDto findById(Long id) {
        Produits produits = produitsDao.findById(id);
        if (produits == null) return null;
        return produitsMapper.toDto(produits);
    }

    //  Tous les produits
    public List<ProduitsDto> findAll() {
        return produitsDao.findAll()
                .stream()
                .map(produitsMapper::toDto)
                .collect(Collectors.toList());
    }

    //  Mettre à jour
    public ProduitsDto update(ProduitsDto produitsDto) {
        Produits produits = produitsMapper.toEntity(produitsDto);
        produits = produitsDao.save(produits);
        return produitsMapper.toDto(produits);
    }

    // Supprimer
    public void delete(Long id) {
        Produits produits = produitsDao.findById(id);
        if (produits != null) {
            produitsDao.delete(produits);
        }
    }
}