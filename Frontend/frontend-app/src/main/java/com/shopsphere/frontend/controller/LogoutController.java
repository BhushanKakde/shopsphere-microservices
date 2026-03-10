package com.shopsphere.frontend.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogoutController {

    @GetMapping("/logout")
    public String logout(HttpSession session) {

        // ✅ DESTROY SESSION
        session.invalidate();

        return "redirect:/login";
    }
}
