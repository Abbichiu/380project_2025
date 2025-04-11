<!DOCTYPE html>
<html>
<head>
  <title>User Login</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4; /* Light grey background */
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh; /* Full viewport height */
      color: #333; /* Dark text color */
    }

    h2 {
      text-align: center; /* Center the heading */
      color: #333; /* Dark text color */
      margin-bottom: 20px; /* Space below heading */
    }

    label {
      display: block; /* Block display for labels */
      margin-bottom: 5px; /* Space between label and input */
      color: #555; /* Slightly lighter text color */
    }

    input[type="text"],
    input[type="password"] {
      width: 100%; /* Full width inputs */
      padding: 10px; /* Padding inside inputs */
      margin-bottom: 15px; /* Space below inputs */
      border: 1px solid #ccc; /* Light border */
      border-radius: 4px; /* Rounded corners */
      box-sizing: border-box; /* Include padding in width */
    }

    .checkbox-container {
      display: flex; /* Use flexbox for alignment */
      align-items: center; /* Center items vertically */
      margin-bottom: 15px; /* Space below checkbox */
    }

    input[type="checkbox"] {
      margin-right: 5px; /* Space between checkbox and label */
    }

    input[type="submit"] {
      background-color: #007bff; /* Blue background */
      color: white; /* White text */
      border: none; /* No border */
      padding: 10px; /* Padding inside button */
      border-radius: 4px; /* Rounded corners */
      cursor: pointer; /* Pointer cursor on hover */
      width: 100%; /* Full width button */
      transition: background-color 0.3s; /* Smooth transition */
    }

    input[type="submit"]:hover {
      background-color: #0056b3; /* Darker blue on hover */
    }

    .error-message {
      color: red; /* Red text for error messages */
      text-align: center; /* Center the error message */
      margin-bottom: 15px; /* Space below error message */
    }

    .success-message {
      color: green; /* Green text for success messages */
      text-align: center; /* Center the success message */
      margin-bottom: 15px; /* Space below success message */
    }

    p {
      text-align: center; /* Center the paragraph */
    }

    a {
      color: #007bff; /* Blue link color */
      text-decoration: none; /* No underline */
    }

    a:hover {
      text-decoration: underline; /* Underline on hover */
    }

    .back-link {
      margin-top: 20px; /* Space above the back link */
      text-align: center; /* Center the back link */
    }
  </style>
</head>
<body>
<div>
  <c:if test="${param.error != null}">
    <p class="error-message">Login failed. Please check your username and password.</p>
  </c:if>
  <c:if test="${param.logout != null}">
    <p class="success-message">You have successfully logged out.</p>
  </c:if>

  <h2>Login</h2>
  <form action="login" method="POST">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required/>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required/>

    <div class="checkbox-container">
      <input type="checkbox" id="remember-me" name="remember-me"/>
      <label for="remember-me">Remember me</label>
    </div>

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="submit" value="Log In"/>
  </form>

  <p>If you don't have an account, <a href="<c:url value='/register' />">register here</a>.</p>

  <!-- Back to Home link -->
  <div class="back-link">
    <a href="<c:url value='/' /> ">Back to Home</a>
  </div>
</div>
</body>
</html>