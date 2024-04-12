package org.yann.demo.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.yann.demo.service.FileStorageServiceImpl;
import org.yann.demo.service.ImageService;
import org.yann.demo.service.UserService;
import org.apache.commons.text.StringSubstitutor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

import org.springframework.stereotype.Controller;

@Controller
public class UserController {
  
	Logger logger = LoggerFactory.getLogger(UserController.class);

	// @Autowired
  	ImageService gallery;

	@GetMapping("/user")
	public void loadGallery(@RequestParam(name="name", required=false, defaultValue="World") String name, Model model) {
		
		try {
			gallery = new FileStorageServiceImpl("/Users/yannc/Downloads/images/");
			gallery.load();
			logger.info(StringSubstitutor.replaceSystemProperties("You are running with java.version = ${java.version} and os.name = ${os.name}."));
			logger.info(gallery.get().toString());
			model.addAttribute("images",  gallery.get() );
			model.addAttribute("mypath",  "file:///Users/yannc/Downloads/images/" );

			UserService users = new UserService();
			users.getUser(name);

		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
