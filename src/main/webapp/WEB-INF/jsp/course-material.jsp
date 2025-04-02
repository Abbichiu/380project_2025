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
        <a href="${noteUrl}" target="_blank">Download</a>
      </li>
    </c:forEach>
  </ul>
</div>

<!-- Section: Comments -->
<div class="section">
  <h2>Comments</h2>
  <ul>
    <c:forEach var="comment" items="${comments}">
      <li class="comment">
        <strong>${comment.user.username}:</strong> ${comment.content}
      </li>
    </c:forEach>
  </ul>
</div>
</body>
</html>
