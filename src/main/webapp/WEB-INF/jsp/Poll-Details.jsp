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
<h2>${poll.question}</h2>

<!-- Poll form -->
<form class="poll-form" action="/Lab10/poll/vote" method="post">
  <input type="hidden" name="pollId" value="${poll.id}">
  <ul class="poll-options">
    <c:forEach var="option" items="${poll.options}">
      <li>
        <label>
          <input type="checkbox" name="selectedOptions" value="${option}">
            ${option}
        </label>
      </li>
    </c:forEach>
  </ul>
  <button type="submit">Submit</button>
</form>
</body>
</html>