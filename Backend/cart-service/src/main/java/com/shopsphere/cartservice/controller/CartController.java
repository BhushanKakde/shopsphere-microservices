package com.shopsphere.cartservice.controller;

import com.shopsphere.cartservice.dto.CartRequest;
import com.shopsphere.cartservice.entity.CartItem;
import com.shopsphere.cartservice.service.CartService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/cart")
public class CartController {

    private final CartService service;

    public CartController(CartService service) {
        this.service = service;
    }

    /* ===============================
       ADD TO CART
    =============================== */
    @PostMapping("/add")
    public ResponseEntity<CartItem> addToCart(@RequestBody CartRequest request) {
        CartItem item = service.addToCart(request);
        return ResponseEntity.ok(item);
    }

    /* ===============================
       GET USER CART
    =============================== */
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<CartItem>> getUserCart(@PathVariable Long userId) {
        return ResponseEntity.ok(service.getCart(userId));
    }

    /* ===============================
       REMOVE CART ITEM
    =============================== */
    @DeleteMapping("/remove/{id}")
    public ResponseEntity<Void> removeItem(@PathVariable Long id) {
        service.removeItem(id);
        return ResponseEntity.ok().build();
    }

    /* ===============================
       UPDATE QUANTITY
    =============================== */
    @PutMapping("/update")
    public ResponseEntity<CartItem> updateQuantity(
            @RequestBody Map<String, Integer> body) {

        Long cartItemId = body.get("cartItemId").longValue();
        int quantity = body.get("quantity");

        CartItem updated = service.updateQuantity(cartItemId, quantity);
        return ResponseEntity.ok(updated);
    }

    /* ===============================
       CLEAR CART
    =============================== */
    @DeleteMapping("/clear/{userId}")
    public ResponseEntity<Void> clearCart(@PathVariable Long userId) {
        service.clearCart(userId);
        return ResponseEntity.ok().build();
    }
}
