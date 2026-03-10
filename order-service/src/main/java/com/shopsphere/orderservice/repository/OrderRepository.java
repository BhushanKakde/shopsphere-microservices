package com.shopsphere.orderservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.shopsphere.orderservice.entity.Order;
import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findByUserId(Long userId);

}