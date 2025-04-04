<!DOCTYPE html>
<html>
<head>
  <title>Course Material</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    h1, h2 {
      color: #333;
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
      color: #007bff;
    }
    a:hover {
      text-decoration: underline;
    }
    .section {
      margin-bottom: 30px;
    }
    .comment {
      font-size: 0.9em;
      background: #f9f9f9;
      padding: 10px;
      border-radius: 5px;
      margin-bottom: 10px;
    }
    .comment-form textarea {
      width: 100%;
      height: 80px;
      margin-bottom: 10px;
      padding: 10px;
      font-size: 1em;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    .comment-form button {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
    }
    .comment-form button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<h1>Lecture: ${lecture.title}</h1>

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