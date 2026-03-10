package com.shopsphere.frontend.controller;

import com.shopsphere.frontend.dto.RegisterRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

@Controller
public class RegisterController {

    private final RestTemplate restTemplate = new RestTemplate();

    @PostMapping("/register")
    public String register(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String password,
            Model model) {

        RegisterRequest request = new RegisterRequest();
        request.setName(name);
        request.setEmail(email);
        request.setPassword(password);

        try {
            String response = restTemplate.postForObject(
                    "http://localhost:8080/user/register",
                    request,
                    String.class
            );

            if ("USER_ALREADY_EXISTS".equals(response)) {
                model.addAttribute("error", "User already registered with this email");
                return "register";
            }

            model.addAttribute("msg", "Registration successful. Please login.");
            return "login";

        } catch (Exception e) {
            model.addAttribute("error", "Something went wrong");
            return "register";
        }
    }
}
