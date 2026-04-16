package com.groupeisi.company.mapper;

import com.groupeisi.company.dto.UsersDto;
import com.groupeisi.company.entities.Users;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UsersMapper {

    // instance du mapper
    UsersMapper INSTANCE = Mappers.getMapper(UsersMapper.class);

    //Entité -> DTO
    UsersDto toDto(Users user);

    //DTO -> Entité
    Users toEntity(UsersDto usersDto);
}
