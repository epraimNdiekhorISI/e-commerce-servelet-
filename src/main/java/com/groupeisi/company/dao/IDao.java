package com.groupeisi.company.dao;

import com.groupeisi.company.entities.Achats;

import java.util.List;

public interface IDao<T, ID> {

    // crée ou modifie
    T save(T t);

    //chercher par ID
    T findById(ID id);

    // recuper tous les enregistrements
    List<T> findAll();

    //supprimer
    void  delete(T t);
}
