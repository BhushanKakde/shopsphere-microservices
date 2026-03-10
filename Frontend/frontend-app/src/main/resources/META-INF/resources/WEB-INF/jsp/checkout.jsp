<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ShopSphere | Checkout</title>

    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f1f3f6;
            margin: 0;
        }

        .header {
            background: #2874f0;
            color: white;
            padding: 15px 30px;
            font-size: 22px;
            font-weight: bold;
        }

        .container {
            width: 450px;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            width: 100%;
            padding: 12px;
            background: green;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: darkgreen;
        }
    </style>
</head>

<body>

<div class="header">🚚 Delivery Details</div>

<div class="container">

    <input type="text" id="name" placeholder="Full Name" required>
    <input type="text" id="phone" placeholder="Phone Number" required>
    <input type="text" id="address" placeholder="Address" required>
    <input type="text" id="city" placeholder="City" required>
    <input type="text" id="pincode" placeholder="Pincode" required>

    <select id="paymentMethod">
        <option value="COD">Cash On Delivery</option>
        <option value="ONLINE">Online</option>
    </select>

    <button onclick="placeOrder()">Place Order</button>

</div>

<script>

const userId = "<%= session.getAttribute("userId") %>";

if (!userId || userId === "null") {
    alert("Session expired. Please login again.");
    window.location.href = "/login";
}

function placeOrder() {

    const orderData = {
        fullName: document.getElementById("name").value,
        phone: document.getElementById("phone").value,
        address: document.getElementById("address").value,
        city: document.getElementById("city").value,
        pincode: document.getElementById("pincode").value,
        paymentMethod: document.getElementById("paymentMethod").value
    };

    fetch("http://localhost:8084/orders/place/" + userId, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(orderData)
    })
    .then(res => {
        if (!res.ok) {
            throw new Error("Order failed");
        }
        return res.json();
    })
    .then(data => {
        alert("✅ Order Placed Successfully!");
        window.location.href = "/orders";
    })
    .catch(error => {
        console.error(error);
        alert("❌ Order Failed!");
    });
}

</script>

</body>
</html>
