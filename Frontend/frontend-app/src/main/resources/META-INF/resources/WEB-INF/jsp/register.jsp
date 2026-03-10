<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Register</title>

<style>

body{
    font-family: Arial, Helvetica, sans-serif;
    background:#f1f3f6;
    text-align:center;
    padding-top:80px;
}

h2{
    color:#2874f0;
}

form{
    display:inline-block;
    background:white;
    padding:30px;
    border-radius:6px;
    box-shadow:0 2px 10px rgba(0,0,0,0.2);
}

input{
    width:220px;
    padding:8px;
    margin-top:5px;
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
    background:#1f5ed1;
}

.success{
    color:green;
    font-weight:bold;
}

.error{
    color:red;
    font-weight:bold;
}

a{
    text-decoration:none;
    color:#2874f0;
    font-weight:bold;
}

</style>

</head>

<body>

<h2>Register</h2>

<!-- SUCCESS MESSAGE -->
<c:if test="${not empty msg}">
    <p class="success">${msg}</p>
</c:if>

<!-- ERROR MESSAGE -->
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<form action="/register" method="post">

<label>Name:</label><br>
<input type="text" name="name" required><br><br>

<label>Email:</label><br>
<input type="email" name="email" required><br><br>

<label>Password:</label><br>
<input type="password" name="password" required><br><br>

<button type="submit">Register</button>

</form>

<br><br>

<a href="/login">Already have an account? Login</a>

</body>
</html>