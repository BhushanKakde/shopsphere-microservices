package com.shopsphere.cartservice.service;

import com.shopsphere.cartservice.dto.CartRequest;
import com.shopsphere.cartservice.dto.ProductDto;
import com.shopsphere.cartservice.entity.CartItem;
import com.shopsphere.cartservice.repository.CartRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Service
public class CartService {

    private final CartRepository repo;
    private final RestTemplate restTemplate;

    // ✅ Product service URL
    private static final String PRODUCT_SERVICE_URL = "http://localhost:8080/products/";

    public CartService(CartRepository repo, RestTemplate restTemplate) {
        this.repo = repo;
        this.restTemplate = restTemplate;
    }

    /* =====================================================
       ✅ ADD TO CART  (FINAL + FIXED)
    ====================================================== */
    public CartItem addToCart(CartRequest req) {

        System.out.println("\n========== ADD TO CART ==========");
        System.out.println("User ID    : " + req.getUserId());
        System.out.println("Product ID : " + req.getProductId());
        System.out.println("Quantity   : " + req.getQuantity());

        // 🔥 Fetch product from Product Service
        ProductDto product = restTemplate.getForObject(
                PRODUCT_SERVICE_URL + req.getProductId(),
                ProductDto.class
        );

        if (product == null) {
            throw new RuntimeException("Product not found with ID: " + req.getProductId());
        }

        System.out.println("Fetched Product:");
        System.out.println("Name  : " + product.getName());
        System.out.println("Price : " + product.getPrice());
        System.out.println("Image : " + product.getImageUrl());

        // 🔁 Check if product already exists in cart
        CartItem item = repo
                .findByUserIdAndProductId(req.getUserId(), req.getProductId())
                .orElse(new CartItem());

        item.setUserId(req.getUserId());
        item.setProductId(req.getProductId());

        // 🔥 STORE PRODUCT SNAPSHOT (THIS FIXES YOUR UI)
        item.setProductName(product.getName());
        item.setPrice(product.getPrice());
        item.setImageUrl(product.getImageUrl());

        // 🔁 Quantity handling
        if (item.getId() != null) {
            item.setQuantity(item.getQuantity() + req.getQuantity());
        } else {
            item.setQuantity(req.getQuantity());
        }

        CartItem saved = repo.save(item);

        System.out.println("Saved Cart Item:");
        System.out.println("Cart ID : " + saved.getId());
        System.out.println("Qty     : " + saved.getQuantity());
        System.out.println("=================================\n");

        return saved;
    }

    /* =====================================================
       ✅ GET CART
    ====================================================== */
    public List<CartItem> getCart(Long userId) {

        System.out.println("\n========== GET CART ==========");
        System.out.println("User ID : " + userId);

        List<CartItem> items = repo.findByUserId(userId);

        System.out.println("Items found: " + items.size());
        for (CartItem item : items) {
            System.out.println(
                item.getProductName() + " | ₹" +
                item.getPrice() + " | Qty: " +
                item.getQuantity()
            );
        }

        System.out.println("================================\n");
        return items;
    }

    /* =====================================================
       ✅ REMOVE ITEM
    ====================================================== */
    public void removeItem(Long id) {

        CartItem item = repo.findById(id).orElse(null);

        if (item == null) {
            System.out.println("⚠️ Cart item already deleted, ID: " + id);
            return; // silently ignore (BEST PRACTICE)
        }

        repo.deleteById(id);
        System.out.println("✅ Cart item deleted: " + id);
    }


    /* =====================================================
       ✅ CLEAR CART
    ====================================================== */
    public void clearCart(Long userId) {

        System.out.println("Clearing cart for user: " + userId);

        List<CartItem> items = repo.findByUserId(userId);
        repo.deleteAll(items);

        System.out.println("Cart cleared");
    }

    /* =====================================================
       ✅ UPDATE QUANTITY
    ====================================================== */
    public CartItem updateQuantity(Long cartItemId, int quantity) {

        System.out.println("Update Qty | Cart ID: " + cartItemId + " -> " + quantity);

        CartItem item = repo.findById(cartItemId)
                .orElseThrow(() -> new RuntimeException("Cart item not found"));

        if (quantity <= 0) {
            repo.deleteById(cartItemId);
            System.out.println("Quantity <= 0, item deleted");
            return null;
        }

        item.setQuantity(quantity);
        return repo.save(item);
    }
}
