package com.groupeisi.company.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AchatsDto {

    private Long id;
    private Date dateP;
    private double quantity;
    private Long produitId;
    private String produitName;
    private Long userId;
    private String userEmail;
}
