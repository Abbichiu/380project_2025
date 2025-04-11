<!DOCTYPE html>
<html>
<head>
  <title>User Login</title>
</head>
<body>
<c:if test="${param.error != null}">
  <p style="color: red;">Login failed. Please check your username and password.</p>
</c:if>
<c:if test="${param.logout != null}">
  <p style="color: green;">You have successfully logged out.</p>
</c:if>

<h2>Login</h2>
<form action="login" method="POST">
  <label for="username">Username:</label><br/>
  <input type="text" id="username" name="username" required/><br/><br/>

  <label for="password">Password:</label><br/>
  <input type="password" id="password" name="password" required/><br/><br/>

  <input type="checkbox" id="remember-me" name="remember-me"/>
  <label for="remember-me">Remember me</label><br/><br/>

  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
  <input type="submit" value="Log In"/>
</form>

<!-- Add a link to register -->
<p>If you don't have an account, <a href="<c:url value='/register' />">register here</a>.</p>
</body>
</html>