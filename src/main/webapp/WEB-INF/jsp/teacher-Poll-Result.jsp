<!DOCTYPE html>
<html>
<head>
  <title>Poll Results (Teacher)</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    h1, h2 {
      color: #333;
    }
    .comments-section {
      margin-top: 30px;
    }
    .comments-section ul {
      list-style-type: none;
      padding: 0;
    }
    .comments-section li {
      margin-bottom: 10px;
      border-bottom: 1px solid #ddd;
      padding-bottom: 10px;
    }
    .comment-form {
      margin-top: 20px;
    }
    textarea {
      width: 100%;
      height: 100px;
      margin-bottom: 10px;
    }
    button {
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
    .delete-button {
      color: red;
      background: none;
      border: none;
      cursor: pointer;
      font-size: 0.9em;
    }
    .delete-button:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<h1>Poll Results (Teacher)</h1>
<h2>${poll.question}</h2>
<!-- Back Button -->
<a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>
<form action="<c:url value='/logout' />" method="POST">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <button type="submit">Logout</button>
</form>

<ul>
  <c:forEach var="count" items="${voteCounts}" varStatus="status">
    <li>Option ${status.index + 1}: ${count} votes</li>
  </c:forEach>
</ul>

<div class="comments-section">
  <h2>Comments</h2>
  <ul>
    <c:forEach var="comment" items="${poll.comments}">
      <li>
        <strong>${comment.user.username}:</strong>
        <p>${comment.content}</p>
        <!-- Delete comment form -->
        <form action="${pageContext.request.contextPath}/poll/teacher/${poll.id}/comment/${comment.id}" method="post" style="display:inline;">
          <input type="hidden" name="_csrf" value="${_csrf.token}" />
          <input type="hidden" name="_method" value="delete">
          <button type="submit" class="delete-button">Delete</button>
        </form>
      </li>
    </c:forEach>
  </ul>
</div>

<!-- Add a comment (available to teachers) -->
<form class="comment-form" action="${pageContext.request.contextPath}/poll/${poll.id}/comment" method="post">
  <input type="hidden" name="_csrf" value="${_csrf.token}" />
  <textarea name="content" placeholder="Add your comment here..." required></textarea>
  <button type="submit">Add Comment</button>
</form>

</body>
</html>