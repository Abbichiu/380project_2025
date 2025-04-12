<!DOCTYPE html>
<html>
<head>
  <title>Course Material</title>
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
    ul {
      list-style-type: none;
      padding: 0;
    }
    ul li {
      margin-bottom: 10px;
    }
    a {
      text-decoration: none;
      color: #007bff; /* Blue link color */
    }
    a:hover {
      text-decoration: underline; /* Underline on hover */
    }
    .section {
      margin-bottom: 30px;
      background: white; /* White background for sections */
      padding: 20px; /* Padding inside sections */
      border-radius: 5px; /* Rounded corners */
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    }
    .comment {
      font-size: 0.9em;
      background: #f9f9f9; /* Light grey background for comments */
      padding: 10px;
      border-radius: 5px;
      margin-bottom: 10px;
    }
    .comment-form textarea {
      width: 100%; /* Full width textarea */
      height: 80px; /* Fixed height */
      margin-bottom: 10px;
      padding: 10px;
      font-size: 1em;
      border: 1px solid #ccc; /* Light grey border */
      border-radius: 5px; /* Rounded corners */
      box-sizing: border-box; /* Include padding in width */
    }
    .comment-form button {
      background-color: #007bff; /* Blue button background */
      color: white; /* White text */
      border: none; /* No border */
      padding: 10px 20px; /* Padding inside button */
      border-radius: 5px; /* Rounded corners */
      cursor: pointer; /* Pointer cursor on hover */
      transition: background-color 0.3s; /* Smooth transition */
    }
    .comment-form button:hover {
      background-color: #0056b3; /* Darker blue on hover */
    }
    .back-button {
      display: inline-block; /* Make the link a block element */
      margin-bottom: 20px; /* Space below the link */
      color: #007bff; /* Blue link color */
      font-weight: bold; /* Bold text */
      text-align: center; /* Center the link */
    }
    .back-button:hover {
      text-decoration: underline; /* Underline on hover */
    }
  </style>
</head>
<body>
<h1>Lecture: ${lecture.title}</h1>
<div>
  <a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>
</div>
<!-- Section: Download Links -->
<div class="section">
  <h2>Lecture Notes</h2>
  <ul>
    <c:forEach var="noteUrl" items="${lecture.noteLinks}">
      <li>
        <!-- Link to download files -->
        <a href="${pageContext.request.contextPath}/lecture/${lecture.id}/download?fileUrl=${noteUrl}" target="_blank">Download</a>
      </li>
    </c:forEach>
  </ul>
</div>

<!-- Section: Comments -->
<div class="section">
  <h2>Comments</h2>

  <!-- Display Existing Comments -->
  <ul>
    <c:forEach var="comment" items="${comments}">
      <li class="comment">
        <strong>${comment.user.username}:</strong> ${comment.content}
      </li>
    </c:forEach>
  </ul>

  <!-- Add a New Comment -->
  <h3>Add a Comment</h3>
  <form class="comment-form" action="${pageContext.request.contextPath}/lecture/${lecture.id}/comment" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <textarea name="content" placeholder="Write your comment here..." required></textarea>
    <button type="submit">Post Comment</button>
  </form>
</div>
</body>
</html>