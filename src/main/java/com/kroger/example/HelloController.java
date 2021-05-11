package com.kroger.example;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
//import javax.servlet.http;

@RestController
public class HelloController {
	private String password="SuperSpecialAisle7";
	private String token="TheF5KeyIsSoRefreshing";
	String s = null;
	
	protected void doGet() {
	try {
		//doSomeWork();
		System.out.println(s.toString());
	} catch (NullPointerException ex) {
		// BAD: printing a stack trace back to the response
		ex.printStackTrace();
		return;
	}

	/*try {
		doSomeWork();
	} catch (NullPointerException ex) {
		// GOOD: log the stack trace, and send back a non-revealing response
		log("Exception occurred", ex);
		response.sendError(
			HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
			"Exception occurred");
		return;
	}*/
}

	@RequestMapping("/")
	public String index() {
		doGet();
		/*try {
//doSomeWork();
} catch (NullPointerException ex) {
// BAD: printing a stack trace back to the response
ex.printStackTrace();
return;
}*/
		return "Greetings from Spring Boot!";
	}
	
	

}
