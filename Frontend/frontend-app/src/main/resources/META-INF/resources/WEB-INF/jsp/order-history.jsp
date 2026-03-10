<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>ShopSphere Orders</title>

<!-- PDF Library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

<style>

body{
font-family:Arial;
background:#f5f5f5;
}

.bill{
width:500px;
background:white;
padding:20px;
margin:20px auto;
border:1px solid #ddd;
box-shadow:0 2px 5px rgba(0,0,0,0.1);
}

.shop-header{
text-align:center;
border-bottom:2px solid #000;
padding-bottom:10px;
margin-bottom:15px;
}

.shop-header h2{
margin:0;
}

.bill-info{
margin-bottom:15px;
}

.product{
display:flex;
align-items:center;
border-top:1px solid #eee;
padding-top:10px;
margin-top:10px;
}

.product img{
width:70px;
height:70px;
object-fit:cover;
margin-right:15px;
}

.total{
border-top:2px solid black;
margin-top:15px;
padding-top:10px;
font-size:18px;
font-weight:bold;
}

.download-btn{
background:#2874f0;
color:white;
padding:10px 15px;
border:none;
border-radius:5px;
cursor:pointer;
font-weight:bold;
margin-top:15px;
}

.download-btn:hover{
background:#1f5ed1;
}

</style>

</head>

<body>

<h2 style="text-align:center">My Orders</h2>

<div id="orders"></div>

<script>

const userId = "<%= session.getAttribute("userId") %>";

fetch("http://localhost:8084/orders/user/" + userId)
.then(response => response.json())
.then(data => {

const container = document.getElementById("orders");

if(!data || data.length === 0){
container.innerHTML="No orders yet.";
return;
}

data.forEach(order => {

const billNumber = "SS-"+order.id+"-"+Math.floor(Math.random()*10000);

let html =

"<div class='bill' id='invoice-"+order.id+"'>" +

"<div class='shop-header'>" +
"<h2>ShopSphere</h2>" +
"<p>Mobile: 9021523020</p>" +
"</div>" +

"<div class='bill-info'>" +
"<p><b>Bill No:</b> "+billNumber+"</p>" +
"<p><b>Order ID:</b> "+order.id+"</p>" +
"<p><b>Name:</b> "+order.fullName+"</p>" +
"<p><b>City:</b> "+order.city+"</p>" +
"<p><b>Status:</b> "+order.status+"</p>" +
"</div>";

if(order.items){

order.items.forEach(item => {

html +=

"<div class='product'>" +

"<img src='"+item.imageUrl+"' crossorigin='anonymous'>" +

"<div>" +
"<p><b>Product:</b> "+item.productName+"</p>" +
"<p>Price: ₹"+item.price+"</p>" +
"<p>Quantity: "+item.quantity+"</p>" +
"</div>" +

"</div>";

});

}

html +=

"<div class='total'>" +
"Total Amount: ₹"+order.totalAmount +
"</div>" +

"<p style='text-align:center;margin-top:15px'>Thank you for shopping with <b>ShopSphere</b></p>" +

"<div style='text-align:center'>" +
"<button class='download-btn' onclick='downloadInvoice(\"invoice-"+order.id+"\")'>⬇ Download Invoice</button>" +
"</div>" +

"</div>";

container.innerHTML += html;

});

})
.catch(err=>{
document.getElementById("orders").innerHTML="Failed to load orders.";
});


function downloadInvoice(invoiceId){

const element = document.getElementById(invoiceId);

// Wait until images load
const images = element.getElementsByTagName("img");

const promises = [];

for (let img of images) {

if (!img.complete) {

promises.push(new Promise(resolve => {

img.onload = resolve;
img.onerror = resolve;

}));

}

}

Promise.all(promises).then(() => {

const options = {

margin:0.5,

filename:'ShopSphere-Invoice.pdf',

image:{ type:'jpeg', quality:1 },

html2canvas:{
scale:3,
useCORS:true
},

jsPDF:{
unit:'in',
format:'letter',
orientation:'portrait'
}

};

html2pdf().set(options).from(element).save();

});

}

</script>

</body>
</html>