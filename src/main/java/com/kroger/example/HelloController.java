package com.kroger.example;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletResponse;

@RestController
public class HelloController {
	// Should trigger passwords in SonarQube
	private String password="SuperSpecialAisle7";
	private String token="TheF5KeyIsSoRefreshing";
	// Should trigger Github PAT in Github Advanced Security - Secret Scanning
	private String pat_token="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";

	@RequestMapping("/")
	public String index() {
		return "Greetings from Spring Boot!";
	}

	// Should trigger: https://github.com/github/codeql/blob/main/java/ql/src/Security/CWE/CWE-209/StackTraceExposure.ql
	// Should trigger: (don't have url) Unnecessary toString()
	@RequestMapping("/hello")
	public String helloWorld(HttpServletResponse response) throws Exception  {
		try {
			String temp = "blah";
			System.out.println(temp.toString());
		} catch (NullPointerException ex) {
			ex.printStackTrace(response.getWriter());
		}

		return "Hello world";
	}

	// Should trigger duplicate code
	@RequestMapping("/goodbye")
	public String goodbyeWorld(HttpServletResponse response) throws Exception  {
		try {
			String temp = "blah";
			System.out.println(temp.toString());
		} catch (NullPointerException ex) {
			ex.printStackTrace(response.getWriter());
		}

		return "Hello world";
	}

}
