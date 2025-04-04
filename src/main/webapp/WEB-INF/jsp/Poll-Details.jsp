<!DOCTYPE html>
<html>
<head>
  <title>Poll Details</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    h1, h2 {
      color: #333;
    }
    .error-message {
      color: red;
      font-weight: bold;
      margin: 10px 0;
    }
    .poll-form {
      margin-top: 20px;
    }
    .poll-options {
      list-style-type: none;
      padding: 0;
    }
    .poll-options li {
      margin-bottom: 10px;
    }
    button {
      margin-top: 10px;
      padding: 10px 15px;
      background-color: #007bff;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<h1>Poll Details</h1>
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