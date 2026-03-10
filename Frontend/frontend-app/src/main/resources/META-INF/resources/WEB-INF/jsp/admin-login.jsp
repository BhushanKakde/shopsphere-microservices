<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>

<style>

body{
font-family:Arial;
background:#f1f3f6;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
}

.login-box{
background:white;
padding:30px;
width:320px;
border-radius:6px;
box-shadow:0 2px 8px rgba(0,0,0,0.2);
}

h2{
text-align:center;
color:#2874f0;
}

input{
width:100%;
padding:10px;
margin:8px 0;
border:1px solid #ccc;
border-radius:4px;
}

button{
width:100%;
padding:10px;
background:#2874f0;
color:white;
border:none;
border-radius:4px;
font-weight:bold;
cursor:pointer;
}

button:hover{
background:#1d5ed6;
}

</style>

</head>

<body>

<div class="login-box">

<h2>Admin Login</h2>

<form action="/admin/login" method="post">

<input type="email" name="email" placeholder="Admin Email" required>

<input type="password" name="password" placeholder="Password" required>

<button type="submit">Login</button>

</form>

</div>

</body>
</html>