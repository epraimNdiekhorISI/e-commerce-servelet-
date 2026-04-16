package com.groupeisi.company.mapper;

import com.groupeisi.company.dto.ProduitsDto;
import com.groupeisi.company.entities.Produits;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface ProduitsMapper {

    ProduitsMapper INSTANCE = Mappers.getMapper(ProduitsMapper.class);

    @Mapping(source = "user.id", target = "userId")
    @Mapping(source = "user.email" , target = "userEmail")
    ProduitsDto toDto(Produits produits);

    @Mapping(source = "userId" , target = "user.id")
    @Mapping(target = "user.email" , ignore = true)
    Produits toEntity(ProduitsDto produitsDto);
}
