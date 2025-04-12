<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4; /* Light grey background */
            margin: 0;
            padding: 20px; /* Padding around the body */
            color: #333; /* Dark text color */
            display: flex; /* Flexbox for centering */
            flex-direction: column; /* Column layout */
            align-items: center; /* Center items horizontally */
            justify-content: center; /* Center items vertically */
            height: 100vh; /* Full viewport height */
        }

        h1 {
            text-align: center; /* Center the heading */
            color: #333; /* Dark text color */
            margin-bottom: 20px; /* Space below heading */
        }

        .form-group {
            margin-bottom: 15px; /* Space below each form group */
            width: 300px; /* Fixed width for input fields */
        }

        .form-group label {
            display: block; /* Block display for labels */
            margin-bottom: 5px; /* Space below label */
            font-weight: bold; /* Bold text for labels */
        }

        .form-group input {
            width: 100%; /* Full width inputs */
            padding: 10px; /* Padding inside inputs */
            border: 1px solid #ccc; /* Light grey border */
            border-radius: 4px; /* Rounded corners */
            box-sizing: border-box; /* Include padding in width */
        }

        button {
            background-color: #007bff; /* Blue button background */
            color: white; /* White text */
            border: none; /* No border */
            padding: 10px 20px; /* Padding inside button */
            cursor: pointer; /* Pointer cursor on hover */
            border-radius: 5px; /* Rounded corners */
            width: 100%; /* Full width button */
            transition: background-color 0.3s; /* Smooth transition */
        }

        button:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        .success-message {
            color: green; /* Green text for success messages */
            font-weight: bold; /* Bold text */
            margin-bottom: 20px; /* Space below success message */
            text-align: center; /* Center the message */
        }

        .error-message {
            color: red; /* Red text for error messages */
            font-weight: bold; /* Bold text */
            margin-bottom: 20px; /* Space below error message */
            text-align: center; /* Center the message */
        }

        .back-button {
            margin-top: 20px; /* Space above the back button */
            text-decoration: none; /* No underline */
            color: #007bff; /* Blue link color */
            font-weight: bold; /* Bold text */
        }

        .back-button:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>
<h1>Register</h1>

<!-- Success Message -->
<c:if test="${not empty successMessage}">
    <div class="success-message">
            ${successMessage}
    </div>
</c:if>

<!-- Error Message -->
<c:if test="${not empty errorMessage}">
    <div class="error-message">
            ${errorMessage}
    </div>
</c:if>

<form action="${pageContext.request.contextPath}/register" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

    <div class="form-group">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
    </div>

    <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
    </div>

    <div class="form-group">
        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullName" required>
    </div>

    <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
    </div>

    <div class="form-group">
        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" name=" phoneNumber" required>
    </div>

    <button type="submit">Register</button>
</form>

<div class="back-link">
    <a href="<c:url value='/' /> ">Back to Home</a>
</div>
</body>
</html>