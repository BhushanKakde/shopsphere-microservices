<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>ShopSphere | Admin Orders</title>

<style>

body{
margin:0;
font-family:Arial;
background:#f1f3f6;
}

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

.container{
padding:30px;
}

table{
width:100%;
background:white;
border-collapse:collapse;
box-shadow:0 2px 8px rgba(0,0,0,0.15);
}

th,td{
padding:12px;
border-bottom:1px solid #ddd;
text-align:center;
}

th{
background:#2874f0;
color:white;
}

.status-select{
padding:6px;
}

.update-btn{
background:#00a65a;
color:white;
border:none;
padding:6px 10px;
border-radius:4px;
cursor:pointer;
}

</style>

</head>

<body>

<div class="header">
<div class="logo">🛒 ShopSphere Admin</div>

<a href="/admin/products" style="color:white;text-decoration:none;">
Manage Products
</a>
</div>


<div class="container">

<h2>📦 Manage Orders</h2>

<table>

<thead>
<tr>
<th>Order ID</th>
<th>User</th>
<th>Total</th>
<th>Status</th>
<th>Update</th>
</tr>
</thead>

<tbody id="orderTable"></tbody>

</table>

</div>


<script>

loadOrders();

function loadOrders(){

fetch("http://localhost:8084/orders")

.then(res=>res.json())

.then(data=>{

const table=document.getElementById("orderTable");

table.innerHTML="";

data.forEach(o=>{

table.innerHTML+=`

<tr>

<td>\${o.id}</td>

<td>\${o.fullName}</td>

<td>₹\${o.totalAmount}</td>

<td>

<select id="status-\${o.id}" class="status-select">

<option value="PLACED">PLACED</option>
<option value="SHIPPED">SHIPPED</option>
<option value="DELIVERED">DELIVERED</option>

</select>

</td>

<td>

<button class="update-btn"
onclick="updateStatus(\${o.id})">
Update
</button>

</td>

</tr>

`;

});

});

}

function updateStatus(orderId){

const status=document.getElementById("status-"+orderId).value;

fetch("http://localhost:8084/orders/update-status/"+orderId,{

method:"PUT",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({
status:status
})

})
.then(()=>{

alert("Order updated");

loadOrders();

});

}

</script>

</body>
</html>