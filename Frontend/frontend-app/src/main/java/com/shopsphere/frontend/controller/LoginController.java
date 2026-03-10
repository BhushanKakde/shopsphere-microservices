package com.shopsphere.frontend.controller;

import com.shopsphere.frontend.dto.LoginRequest;
import com.shopsphere.frontend.dto.UserDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

@Controller
public class LoginController {

    private final RestTemplate restTemplate = new RestTemplate();

    @PostMapping("/login")
    public String login(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        LoginRequest request = new LoginRequest();
        request.setEmail(email);
        request.setPassword(password);

        UserDto user;

        try {
            user = restTemplate.postForObject(
                    "http://localhost:8080/user/login",
                    request,
                    UserDto.class
            );
        } catch (Exception e) {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }

        // ✅ SAVE BOTH userId + username
        session.setAttribute("userId", user.getId());
        session.setAttribute("username", user.getName());

        return "redirect:/";
    }
}
