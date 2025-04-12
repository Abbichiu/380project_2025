<!DOCTYPE html>
<html>
<head>
  <title>Teacher - Course Material</title>
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
    .section {
      margin-bottom: 30px; /* Space below each section */
      background: white; /* White background for sections */
      padding: 20px; /* Padding inside sections */
      border-radius: 5px; /* Rounded corners */
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    }
    ul {
      list-style-type: none; /* Remove default list styling */
      padding: 0; /* Remove padding */
    }
    ul li {
      margin-bottom: 10px; /* Space between list items */
      padding: 10px; /* Padding inside list items */
      background: #f9f9f9; /* Light grey background for list items */
      border-radius: 5px; /* Rounded corners */
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    }
    a {
      text-decoration: none; /* No underline */
      color: #007bff; /* Blue link color */
    }
    a:hover {
      text-decoration: underline; /* Underline on hover */
    }
    .comment {
      font-size: 0.9em; /* Slightly smaller font size for comments */
      background: #f9f9f9; /* Light grey background for comments */
      padding: 10px; /* Padding inside comments */
      border-radius: 5px; /* Rounded corners */
      margin-bottom: 10px; /* Space below comments */
    }
    .comment-form textarea {
      width: 100%; /* Full width textarea */
      height: 80px; /* Fixed height */
      margin-bottom: 10px; /* Space below textarea */
      padding: 10px; /* Padding inside textarea */
      font-size: 1em; /* Font size */
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
    .delete-button {
      color: red; /* Red text for delete button */
      background: none; /* No background */
      border: none; /* No border */
      cursor: pointer; /* Pointer cursor */
      font-size: 0.9em; /* Slightly smaller font size */
    }
    .delete-button:hover {
      text-decoration: underline; /* Underline on hover */
    }
  </style>
</head>
<body>
<h1>Lecture: ${lecture.title}</h1>

<!-- Back Button -->
<a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>

<!-- Section: Upload Files -->
<div class="section">
  <h2> Upload Lecture Notes</h2>
  <form action="${pageContext.request.contextPath}/teacher/lecture/${lecture.id}/upload-multiple" method="post" enctype="multipart/form-data">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <input type="file" name="files" multiple required> <!-- Multiple file input -->
    <button type="submit">Upload Files</button>
  </form>
</div>

<!-- Section: Lecture Notes -->
<div class="section">
  <h2>Lecture Notes</h2>
  <ul>
    <c:forEach var="noteUrl" items="${lecture.noteLinks}">
      <li>
        <!-- File download link -->
        <a href="${pageContext.request.contextPath}/lecture/${lecture.id}/download?fileUrl=${noteUrl}" target="_blank">Download</a>
        <!-- File delete button -->
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