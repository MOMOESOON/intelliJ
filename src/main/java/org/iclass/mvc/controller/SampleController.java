package org.iclass.mvc.controller;

import lombok.extern.log4j.Log4j2;
import org.iclass.mvc.service.CommunityService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.thymeleaf.model.IModel;

import java.util.List;

//  url 이 community 로 시작하면 DispatcherServlet 으로부터 CommunityController가 위임받아 처리합니다.
@Controller
@RequestMapping("/sample")
@Log4j2
public class SampleController {

	private final CommunityService service;
	
	private SampleController(CommunityService service) {
		this.service=service;
	}
	
	//여기서부터는 요청을 처리하는 핸들러 메소드입니다.
	//URL 설계 :  글 목록 조회는 /community/list , 글쓰기 /community/write , 글읽기 /community/read  

	
	@GetMapping("/hello")
	public void hello(Model model) {
		model.addAttribute("message","하이 스프링");
		model.addAttribute("list",List.of("모모","나연","nana","쯔위"));
	}

	@GetMapping("/spring")
	public void spring(@RequestParam(required = false) String name,
					   @RequestParam(required = false) Integer age) {
		log.info("파라미터 name: {}",name);
		log.info("파라미터 age: {}",age);
		//required = false 로 하면 파라미터 값이 null 이 되어야하므로
		//int,long 들은 Integer, Long 과 같이 래퍼(Wrapper) 타입으로 선언합니다.
	}

}
