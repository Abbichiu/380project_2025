<!DOCTYPE html>
<html>
<head>
  <title>Poll Results (Teacher)</title>
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
    .back-button {
      display: inline-block; /* Make the link a block element */
      margin-bottom: 20px; /* Space below the link */
      color: #007bff; /* Blue link color */
      font-weight: bold; /* Bold text */
      text-decoration: none; /* No underline */
      text-align: center; /* Center the link */
    }
    .back-button:hover {
      text-decoration: underline; /* Underline on hover */
    }
    ul {
      list-style-type: none; /* Remove default list styling */
      padding: 0; /* Remove padding */
      margin: 20px 0; /* Space above and below the list */
    }
    ul li {
      margin-bottom: 10px; /* Space between list items */
      padding: 10px; /* Padding inside list items */
      background: white; /* White background for list items */
      border-radius: 5px; /* Rounded corners */
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    }
    .comments-section {
      margin-top: 30px; /* Space above comments section */
      background: white; /* White background for comments section */
      padding: 20px; /* Padding inside comments section */
      border-radius: 5px; /* Rounded corners */
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    }
    .comments-section ul {
      list-style-type: none; /* Remove default list styling */
      padding: 0; /* Remove padding */
    }
    .comments-section li {
      margin-bottom: 10px; /* Space between comments */
      border-bottom: 1px solid #ddd; /* Light grey border */
      padding-bottom: 10px; /* Space below comment */
    }
    .comment-form {
      margin-top: 20px; /* Space above comment form */
    }
    textarea {
      width: 100%; /* Full width textarea */
      height: 100px; /* Fixed height */
      margin-bottom: 10px; /* Space below textarea */
      padding: 10px; /* Padding inside textarea */
      border: 1px solid #ccc; /* Light grey border */
      border-radius: 4px; /* Rounded corners */
      box-sizing: border-box; /* Include padding in width */
    }
    button {
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
    .delete-button {
      background: red; /* No background */
      border-radius: 4px;
      cursor: pointer; /* Pointer cursor */
      font-size: 0.9em; /* Slightly smaller font size */
      width: 20px;
    }
  </style>
</head>
<body>
<h1>Poll Results (Teacher)</h1>
<h2>${poll.question}</h2>
<!-- Back Button -->
<a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>

<ul>
  <c:forEach var="count" items="${voteCounts}" varStatus="status">
    <li>Option ${status .index + 1}: ${count} votes</li>
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