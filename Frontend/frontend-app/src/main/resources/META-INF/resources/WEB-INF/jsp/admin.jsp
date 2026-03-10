<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>

<html>
<head>
<title>ShopSphere | Admin Dashboard</title>

<style>

body{
margin:0;
font-family:Arial, Helvetica, sans-serif;
background:#f1f3f6;
}

/* HEADER */

.header{
background:#2874f0;
color:white;
padding:15px 30px;
display:flex;
justify-content:space-between;
align-items:center;
}

.logo{
font-size:24px;
font-weight:bold;
}

.user-info{
display:flex;
align-items:center;
gap:15px;
}

.logout-btn{
background:white;
color:#2874f0;
border:none;
padding:8px 14px;
border-radius:4px;
cursor:pointer;
font-weight:bold;
}

/* TITLE */

.title{
padding:20px 30px;
background:white;
}

.title h2{
margin:0;
color:#2874f0;
}

/* DASHBOARD */

.container{
padding:30px;
display:flex;
gap:20px;
flex-wrap:wrap;
}

/* CARDS */

.card{
background:white;
width:220px;
padding:20px;
border-radius:6px;
box-shadow:0 2px 8px rgba(0,0,0,0.15);
text-align:center;
}

.card h3{
margin:0;
color:#555;
}

.card h2{
margin-top:10px;
color:#2874f0;
}

/* BUTTONS */

.actions{
padding:30px;
}

.action-btn{
background:#00a65a;
color:white;
padding:10px 15px;
border-radius:5px;
text-decoration:none;
font-weight:bold;
margin-right:10px;
}

.action-btn:hover{
background:#008d4c;
}

</style>

</head>

<body>

<!-- HEADER -->

<div class="header">

<div class="logo">🛒 ShopSphere Admin</div>

<div class="user-info">

<a href="/" class="action-btn">🏠 Home</a>

<form action="/logout" method="get">
<button class="logout-btn">Logout</button>
</form>

</div>

</div>

<!-- TITLE -->

<div class="title">
<h2>📊 Admin Dashboard</h2>
</div>

<!-- DASHBOARD CARDS -->

<div class="container">

<div class="card">
<h3>Total Products</h3>
<h2 id="productCount">0</h2>
</div>

<div class="card">
<h3>Total Orders</h3>
<h2 id="orderCount">0</h2>
</div>

<div class="card">
<h3>Total Users</h3>
<h2 id="userCount">0</h2>
</div>

<div class="card">
<h3>Total Revenue</h3>
<h2 id="revenue">₹0</h2>
</div>

</div>

<!-- ACTION BUTTONS -->

<div class="actions">

<a href="/admin/products" class="action-btn">
📦 Manage Products
</a>

<a href="/admin/orders" class="action-btn">
📦 Manage Orders
</a>

</div>

<script>

/* LOAD DASHBOARD DATA */

loadProducts();
loadOrders();
loadUsers();

/* PRODUCTS */

function loadProducts(){

fetch("http://localhost:8082/products")

.then(res => res.json())

.then(data => {
document.getElementById("productCount").innerText = data.length;
})

.catch(err=>{
console.log("Product API Error:",err);
});

}

/* ORDERS */

function loadOrders(){

fetch("http://localhost:8084/orders")

.then(res => res.json())

.then(data => {

document.getElementById("orderCount").innerText = data.length;

let total = 0;

data.forEach(o => {

if(o.totalAmount){
total += o.totalAmount;
}

});

document.getElementById("revenue").innerText = "₹" + total;

})

.catch(err=>{
console.log("Order API Error:",err);
});

}

/* USERS */

function loadUsers(){

fetch("http://localhost:8081/user/all")

.then(res => res.json())

.then(data => {
document.getElementById("userCount").innerText = data.length;
})

.catch(err=>{
console.log("User API Error:",err);
});

}

</script>

</body>
</html>
