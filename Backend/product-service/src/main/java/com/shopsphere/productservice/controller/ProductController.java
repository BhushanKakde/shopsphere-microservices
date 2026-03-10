package com.shopsphere.productservice.controller;

import com.shopsphere.productservice.entity.Product;
import com.shopsphere.productservice.repository.ProductRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/products")
public class ProductController {

    private final ProductRepository repo;

    public ProductController(ProductRepository repo) {
        this.repo = repo;
    }

    /* GET ALL PRODUCTS */
    @GetMapping
    public List<Product> getAllProducts() {
        return repo.findAll();
    }

    /* GET PRODUCT BY ID */
    @GetMapping("/{id}")
    public Product getProduct(@PathVariable Long id) {
        return repo.findById(id).orElseThrow();
    }

    /* SEARCH */
    @GetMapping("/search")
    public List<Product> search(@RequestParam String keyword) {
        return repo.findByNameContainingIgnoreCase(keyword);
    }

    /* CATEGORY */
    @GetMapping("/category/{category}")
    public List<Product> byCategory(@PathVariable String category) {
        return repo.findByCategory(category);
    }

    /* ADD PRODUCT */
    @PostMapping
    public Product addProduct(@RequestBody Product product) {
        return repo.save(product);
    }

    /* UPDATE PRODUCT */
    @PutMapping("/{id}")
    public Product updateProduct(@PathVariable Long id, @RequestBody Product product) {

        Product existing = repo.findById(id).orElseThrow();

        existing.setName(product.getName());
        existing.setDescription(product.getDescription());
        existing.setPrice(product.getPrice());
        existing.setImageUrl(product.getImageUrl());
        existing.setCategory(product.getCategory());

        return repo.save(existing);
    }

    /* DELETE PRODUCT */
    @DeleteMapping("/{id}")
    public void deleteProduct(@PathVariable Long id) {
        repo.deleteById(id);
    }
}