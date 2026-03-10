<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ShopSphere | Cart</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f1f3f6;
        }

        .header {
            background: #2874f0;
            color: white;
            padding: 15px 30px;
            font-size: 22px;
            font-weight: bold;
        }

        .container {
            display: flex;
            padding: 30px;
            gap: 30px;
        }

        .cart-items {
            flex: 3;
        }

        .cart-card {
            display: flex;
            align-items: center;
            background: white;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            gap: 20px;
        }

        .cart-card img {
            width: 120px;
            height: 120px;
            object-fit: cover;
        }

        .details {
            flex: 1;
        }

        .qty {
            margin-top: 10px;
        }

        .qty button {
            width: 32px;
            height: 32px;
            font-size: 18px;
            cursor: pointer;
        }

        .remove-btn {
            background: red;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 4px;
            margin-top: 10px;
        }

        .price-box {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .checkout-btn {
            width: 100%;
            padding: 12px;
            background: #2874f0;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
    </style>
</head>

<body>

<div class="header">🛒 Your Cart</div>

<div class="container">

    <div class="cart-items" id="cartItems"></div>

    <div class="price-box">
        <h3>Price Details</h3>
        <p>Total Items: <span id="totalItems">0</span></p>
        <p>Total Price: ₹<span id="totalPrice">0</span></p>

        <hr>

        <!-- ✅ Place Order Button -->
        <button class="checkout-btn" onclick="goToCheckout()">
            Place Order
        </button>
    </div>

</div>

<script>

/* ================= SESSION ================= */
const userId = "<%= session.getAttribute("userId") %>";
console.log("USER ID:", userId);

if (!userId || userId === "null") {
    alert("Session expired. Please login again.");
    window.location.href = "/login";
}

/* ================= LOAD CART ================= */
fetchCart();

function fetchCart() {

    let totalItems = 0;
    let totalPrice = 0;

    fetch("http://localhost:8083/cart/user/" + userId)
        .then(res => res.json())
        .then(items => {

            const container = document.getElementById("cartItems");
            container.innerHTML = "";

            if (!items || items.length === 0) {
                container.innerHTML = "<h3>Your cart is empty 🛒</h3>";
                document.getElementById("totalItems").innerText = 0;
                document.getElementById("totalPrice").innerText = 0;
                return;
            }

            items.forEach(item => {

                const price = item.price;
                const qty = item.quantity;

                totalItems += qty;
                totalPrice += price * qty;

                container.innerHTML += `
                    <div class="cart-card">

                        <img src="\${item.imageUrl}"
                             alt="\${item.productName}"
                             referrerpolicy="no-referrer"
                             onerror="this.src='https://via.placeholder.com/120?text=No+Image'">

                        <div class="details">
                            <h4>\${item.productName}</h4>
                            <p><b>Price:</b> ₹\${price}</p>
                            <p><b>Subtotal:</b> ₹\${price * qty}</p>

                            <div class="qty">
                                <button onclick="updateQty(\${item.id}, \${qty - 1})">−</button>
                                <span style="margin:0 10px;">\${qty}</span>
                                <button onclick="updateQty(\${item.id}, \${qty + 1})">+</button>
                            </div>

                            <button class="remove-btn"
                                    onclick="removeItem(\${item.id})">
                                Remove
                            </button>
                        </div>
                    </div>
                `;
            });

            document.getElementById("totalItems").innerText = totalItems;
            document.getElementById("totalPrice").innerText = totalPrice;
        })
        .catch(() => alert("❌ Failed to load cart"));
}

/* ================= UPDATE QTY ================= */
function updateQty(cartItemId, newQty) {

    if (newQty <= 0) {
        removeItem(cartItemId);
        return;
    }

    fetch("http://localhost:8083/cart/update", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            cartItemId: cartItemId,
            quantity: newQty
        })
    })
    .then(() => fetchCart())
    .catch(() => alert("❌ Quantity update failed"));
}

/* ================= REMOVE ITEM ================= */
function removeItem(id) {

    fetch("http://localhost:8083/cart/remove/" + id, {
        method: "DELETE"
    })
    .then(() => fetchCart())
    .catch(() => alert("❌ Remove failed"));
}

/* ================= CHECKOUT ================= */
function goToCheckout() {

    const totalPrice = document.getElementById("totalPrice").innerText;

    if (totalPrice == 0) {
        alert("Cart is empty!");
        return;
    }

    window.location.href = "/checkout";

}

</script>

</body>
</html>
