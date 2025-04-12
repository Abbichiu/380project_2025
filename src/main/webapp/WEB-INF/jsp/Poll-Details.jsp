<!DOCTYPE html>
<html>
<head>
  <title>Poll Details</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      background-color: #f4f4f4; /* Light grey background */
      color: #333; /* Dark text color */
    }
    h1, h2 {
      color: #333;
      text-align: center; /* Center headings */
    }
    .error-message {
      color: red; /* Red text for error messages */
      font-weight: bold; /* Bold text */
      margin: 10px 0; /* Space around error message */
      text-align: center; /* Center the message */
    }
    .back-button {
      display: inline-block; /* Make the link a block element */
      margin-bottom: 20px; /* Space below the link */
      color: #007bff; /* Blue link color */
      font-weight: bold; /* Bold text */
      text-align: center; /* Center the link */
      text-decoration: none; /* No underline */
    }
    .back-button:hover {
      text-decoration: underline; /* Underline on hover */
    }
    .poll-form {
      margin-top: 20px;
      background: white; /* White background for the form */
      padding: 20px; /* Padding inside the form */
      border-radius: 5px; /* Rounded corners */
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    }
    .poll-options {
      list-style-type: none; /* Remove default list styling */
      padding: 0; /* Remove padding */
    }
    .poll-options li {
      margin-bottom: 10px; /* Space between options */
    }
    button {
      margin-top: 10px; /* Space above button */
      padding: 10px 15px; /* Padding inside button */
      background-color: #007bff; /* Blue button background */
      color: #fff; /* White text */
      border: none; /* No border */
      border-radius: 4px; /* Rounded corners */
      cursor: pointer; /* Pointer cursor on hover */
      width: 100%; /* Full width button */
      transition: background-color 0.3s; /* Smooth transition */
    }
    button:hover {
      background-color: #0056b3; /* Darker blue on hover */
    }
  </style>
</head>
<body>
<h1>Poll Details</h1>
<!-- Back Button -->
<a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>

<!-- Display error message if present -->
<c:if test="${not empty error}">
  <div class="error-message">${error}</div>
</c:if>

<h2>${poll.question}</h2>

<!-- Poll form -->
<form class="poll-form" action="${pageContext.request.contextPath}/poll/vote" method="post">
  <input type="hidden" name="_csrf" value="${_csrf.token}" />
  <input type="hidden" name="pollId" value="${poll.id}">
  <ul class="poll-options">
    <c:forEach var="option" items="${poll.options}" varStatus="status">
      <li>
        <label>
          <input type="checkbox" name="selectedOptions" value="${status.index}">
            ${option}
        </label>
      </li>
    </c:forEach>
  </ul>
  <button type="submit">Submit</button>
</form>
</body>
</html>