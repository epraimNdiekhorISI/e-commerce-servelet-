package com.groupeisi.company.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "achats")

public class Achats {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Temporal(TemporalType.DATE)
    private Date dateP;

    private double quantity;

    @ManyToOne
    @JoinColumn(name = "produit_id")
    private Produits produit;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private Users user;
}
