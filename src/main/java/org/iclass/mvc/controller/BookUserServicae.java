package org.iclass.mvc.controller;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import org.iclass.mvc.dao.BookUserMapper;
import org.iclass.mvc.dto.BookUser;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@RequiredArgsConstructor(access = AccessLevel.PRIVATE)//생성자 접근권한
public class

BookUserServicae {
    private final BookUserMapper dao;
    public int join(BookUser dto){
        return dao.insert(dto);
    }
    public  BookUser login(Map<String,String> map){
        return dao.login(map);
    }



}
