package com.shopsphere.cartservice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class RestTemplateConfig {

    @Bean
   // 🔥 THIS IS THE KEY
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
