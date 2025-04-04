<!DOCTYPE html>
<html>
<head>
  <title>Teacher - Course Material</title>
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
    .delete-button {
      color: red;
      cursor: pointer;
      background: none;
      border: none;
      font-size: 0.9em;
    }
    .delete-button:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<h1>Lecture: ${lecture.title}</h1>

<!-- Section: Upload Files -->
<div class="section">
  <h2>Upload Lecture Notes</h2>
  <form action="${pageContext.request.contextPath}/teacher/lecture/${lecture.id}/upload" method="post" enctype="multipart/form-data">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <input type="file" name="file" required>
    <button type="submit">Upload</button>
  </form>
</div>

<!-- Section: Download Links -->
<div class="section">
  <h2>Lecture Notes</h2>
  <ul>
    <c:forEach var="noteUrl" items="${lecture.noteLinks}">
      <li>
        <a href="${noteUrl}" target="_blank">Download</a>
        <form action="${pageContext.request.contextPath}/teacher/lecture/${lecture.id}/file" method="post" style="display:inline;">
          <input type="hidden" name="_csrf" value="${_csrf.token}" />
          <input type="hidden" name="_method" value="delete">
          <input type="hidden" name="fileUrl" value="${noteUrl}">
          <button type="submit" class="delete-button">Delete</button>
        </form>
      </li>
    </c:forEach>
  </ul>
</div>

<!-- Section: Comments -->
<div class="section">
  <h2>Comments</h2>

  <!-- Existing Comments -->
  <ul>
    <c:forEach var="comment" items="${comments}">
      <li class="comment">
        <strong>${comment.user.username}:</strong> ${comment.content}
        <form action="${pageContext.request.contextPath}/teacher/lecture/${lecture.id}/comment/${comment.id}" method="post" style="display:inline;">
          <input type="hidden" name="_csrf" value="${_csrf.token}" />
          <input type="hidden" name="_method" value="delete">
          <button type="submit" class="delete-button">Delete</button>
        </form>
      </li>
    </c:forEach>
  </ul>

  <!-- Add New Comment -->
  <h3>Add a Comment</h3>

  <!-- Use security:authorize to dynamically set the action URL -->
  <security:authorize access="hasRole('ROLE_TEACHER')">
    <form class="comment-form" action="${pageContext.request.contextPath}/teacher/lecture/${lecture.id}/comment" method="post">
      <input type="hidden" name="_csrf" value="${_csrf.token}" />
      <textarea name="content" placeholder="Write your comment here..." required></textarea>
      <button type="submit">Post Comment</button>
    </form>
  </security:authorize>
  <security:authorize access="!hasRole('ROLE_TEACHER')">
    <form class="comment-form" action="${pageContext.request.contextPath}/lecture/${lecture.id}/comment" method="post">
      <input type="hidden" name="_csrf" value="${_csrf.token}" />
      <textarea name="content" placeholder="Write your comment here..." required></textarea>
      <button type="submit">Post Comment</button>
    </form>
  </security:authorize>
</div>
</body>
</html>