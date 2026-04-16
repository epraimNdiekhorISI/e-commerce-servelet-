package com.groupeisi.company.mapper;

import com.groupeisi.company.dto.AchatsDto;
import com.groupeisi.company.entities.Achats;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface AchatsMapper {

    AchatsMapper INSTANCE = Mappers.getMapper(AchatsMapper.class);

    @Mapping(source = "produit.id", target = "produitId")
    @Mapping(source = "produit.name", target = "produitName")
    @Mapping(source = "user.id", target = "userId")
    @Mapping(source = "user.email", target = "userEmail")
    AchatsDto toDto(Achats achats);

    @Mapping(source = "produitId", target = "produit.id")
    @Mapping(target = "produit.name",  ignore = true)
    @Mapping(source = "userId", target = "user.id")
    @Mapping(target = "user.email", ignore = true)
    Achats toEntity(AchatsDto achatsDto);
}
