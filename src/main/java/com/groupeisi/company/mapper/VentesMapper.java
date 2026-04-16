package com.groupeisi.company.mapper;

import com.groupeisi.company.dto.VentesDto;
import com.groupeisi.company.entities.Ventes;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface VentesMapper {

    VentesMapper INSTANCE = Mappers.getMapper(VentesMapper.class);

    @Mapping(source = "produit.id", target = "produitId")
    @Mapping(source = "produit.name", target = "produitName")
    @Mapping(source = "user.id", target = "userId")
    @Mapping(source = "user.email", target = "userEmail")
    VentesDto toDto(Ventes ventes);

    @Mapping(source = "produitId", target = "produit.id")
    @Mapping(target = "produit.name",  ignore = true)
    @Mapping(source = "userId", target = "user.id")
    @Mapping(target = "user.email", ignore = true)
    Ventes toEntity(VentesDto ventesDto);
}
