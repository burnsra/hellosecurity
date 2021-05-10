package com.kroger.example;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {
	private String password="SuperSpecialAisle7";
	private String token="TheF5KeyIsSoRefreshing";

	@RequestMapping("/")
	public String index() {
		return "Greetings from Spring Boot!";
	}

}