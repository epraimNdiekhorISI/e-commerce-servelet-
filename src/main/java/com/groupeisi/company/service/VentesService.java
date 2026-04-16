package com.groupeisi.company.service;

import com.groupeisi.company.dao.ProduitsDao;
import com.groupeisi.company.dao.VentesDao;
import com.groupeisi.company.dto.VentesDto;
import com.groupeisi.company.entities.Produits;
import com.groupeisi.company.entities.Ventes;
import com.groupeisi.company.mapper.VentesMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.stream.Collectors;

public class VentesService {

    private static final Logger log = LoggerFactory.getLogger(VentesService.class);

    private VentesDao ventesDao = new VentesDao();
    private ProduitsDao produitsDao = new ProduitsDao();
    private VentesMapper ventesMapper = VentesMapper.INSTANCE;

    // Créer une vente
    public VentesDto save(VentesDto ventesDto) {
        // Règle métier : vérifier que le stock est suffisant
        Produits produit = produitsDao.findById(ventesDto.getProduitId());
        if (produit == null) {
            log.error("Produit non trouvé id={}", ventesDto.getProduitId());
            return null;
        }
        if (produit.getStock() < ventesDto.getQuantity()) {
            log.warn("Stock insuffisant. Disponible={}, Demandé={}",
                    produit.getStock(), ventesDto.getQuantity());
            return null; // Stock insuffisant
        }
        // Le stock DIMINUE lors d'une vente
        produit.setStock(produit.getStock() - ventesDto.getQuantity());
        produitsDao.save(produit);

        Ventes ventes = ventesMapper.toEntity(ventesDto);
        ventes = ventesDao.save(ventes);
        log.info("Vente enregistrée, stock restant : {}", produit.getStock());
        return ventesMapper.toDto(ventes);
    }

    // Chercher par ID
    public VentesDto findById(Long id) {
        Ventes ventes = ventesDao.findById(id);
        if (ventes == null) return null;
        return ventesMapper.toDto(ventes);
    }

    //  Toutes les ventes
    public List<VentesDto> findAll() {
        return ventesDao.findAll()
                .stream()
                .map(ventesMapper::toDto)
                .collect(Collectors.toList());
    }

    // ️ Mettre à jour
    public VentesDto update(VentesDto ventesDto) {
        Ventes ventes = ventesMapper.toEntity(ventesDto);
        ventes = ventesDao.save(ventes);
        return ventesMapper.toDto(ventes);
    }

    // Supprimer
    public void delete(Long id) {
        Ventes ventes = ventesDao.findById(id);
        if (ventes != null) {
            ventesDao.delete(ventes);
        }
    }

    //  Ventes par utilisateur
    public List<VentesDto> findByUser(Long userId) {
        return ventesDao.findByUser(userId)
                .stream()
                .map(ventesMapper::toDto)
                .collect(Collectors.toList());
    }
}