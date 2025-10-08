<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ include file="db_config.jsp"%>

<%
String id = request.getParameter("id");
if (id == null) {
	response.sendRedirect("index.jsp");
	return;
}
%>

<sql:query dataSource="${employeeDB}" var="employee">
    SELECT * FROM employees_info WHERE id = ?
    <sql:param value="<%=id%>" />
</sql:query>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Employee</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
}

table {
	border-collapse: collapse;
	margin: 20px 0;
}

td {
	padding: 10px;
}

input[type="text"], input[type="number"], input[type="date"] {
	padding: 8px;
	width: 200px;
}

button {
	padding: 8px 15px;
	margin: 5px;
}
</style>

</head>
<body>

	<h1>Edit Employee</h1>

	<c:if test="${employee.rowCount == 0}">
		<p>Employee not found.</p>
		<a href="index.jsp">Back to List</a>
	</c:if>

	<c:if test="${employee.rowCount > 0}">
		<c:forEach var="emp" items="${employee.rows}">
			<form action="update.jsp" method="POST">
				<input type="hidden" name="id" value="${emp.id}">
				<table>
					<tr>
						<td>First Name:</td>
						<td><input type="text" name="first_Name"
							value="${emp.first_Name}" required></td>
					</tr>
					<tr>
						<td>Last Name:</td>
						<td><input type="text" name="last_Name"
							value="${emp.last_Name}" required></td>
					</tr>
					<tr>
						<td>Phone Number:</td>
						<td><input type="text" name="phone_Number"
							value="${emp.phone_Number}" required></td>
					</tr>
					<tr>
						<td>Age:</td>
						<td><input type="number" name="Age" value="${emp.Age}"
							required></td>
					</tr>
					<tr>
						<td>Join Date:</td>
						<td><input type="date" name="Join_Date"
							value="${emp.Join_Date}" required></td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit">Update Employee</button> <a
							href="index.jsp"><button type="button">Cancel</button></a>
						</td>
					</tr>
				</table>
			</form>
		</c:forEach>
	</c:if>

</body>
</html>