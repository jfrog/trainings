package org.yann.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.yann.demo.service.ImageService;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;

@Controller
public class UploadController {
  
	Logger logger = LoggerFactory.getLogger(UploadController.class);

	// @Autowired
  	ImageService gallery;

	@GetMapping("/upload")
	public String uploadImage() {
		
		logger.info("test");
		
		// fetch values from tag field

		// inject in the DB

		// model.addAttribute("images",  gallery.get() );
		// model.addAttribute("mypath",  "file:///Users/yannc/Downloads/images/" );
		return "uploadform";
	}

	@GetMapping("/dummy")
	void manual(HttpServletResponse response) throws IOException {
		response.setHeader("Custom-Header", "foo");
		response.setStatus(200);
		response.getWriter().println("Hello World!");
	}
}
