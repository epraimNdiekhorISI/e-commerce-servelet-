package com.groupeisi.company.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "produits")

public class Produits {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String ref;

    @Column(nullable = false)
    private String name;

    private Double stock;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private Users user;
}
