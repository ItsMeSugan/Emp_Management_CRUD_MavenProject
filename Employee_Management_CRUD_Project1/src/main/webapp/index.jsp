<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ include file="db_config.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Management System</title>
<style>
table { border-collapse: collapse; width: 100%; margin: 10px 0; }
th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
th { background-color: #f2f2f2; }
.form-section { margin: 20px 0; padding: 15px; border: 1px solid #ccc; }
.success { color: green; margin: 10px 0; }
.error { color: red; margin: 10px 0; }
button { padding: 5px 10px; margin: 5px; }
input, select { padding: 5px; margin: 2px; }
.checkbox-item { margin: 5px 0; }
</style> 
</head>
<body>

	<h1>Employee Management System</h1>

	<%
	String message = (String) session.getAttribute("message");
	String error = (String) session.getAttribute("error");

	if (message != null) {
	%>
	<div class="success"><%=message%></div>
	<%
	session.removeAttribute("message");
	}
	if (error != null) {
	%>
	<div class="error"><%=error%></div>
	<%
	session.removeAttribute("error");
	}
	%>


	<sql:query dataSource="${employeeDB}" var="allEmployees">
    SELECT id, first_Name, last_Name FROM employees_info ORDER BY id
	</sql:query>

	<!-- Insert New Employee Form -->
	<div class="form-section">
		<h2>Add New Employee</h2>
		<form action="insert.jsp" method="POST">
			<table>
				<tr>
					<td>First Name:</td>
					<td><input type="text" name="first_Name" required></td>
				</tr>
				<tr>
					<td>Last Name:</td>
					<td><input type="text" name="last_Name" required></td>
				</tr>
				<tr>
					<td>Phone Number:</td>
					<td><input type="text" name="phone_Number" required></td>
				</tr>
				<tr>
					<td>Age:</td>
					<td><input type="number" name="Age" required></td>
				</tr>
				<tr>
					<td>Join Date:</td>
					<td><input type="date" name="Join_Date" required></td>
				</tr>
				<tr>
					<td colspan="2"><button type="submit">Add Employee</button></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- Update Employee Form -->
	<div class="form-section">
		<h2>Update Employee</h2>
		<form action="update.jsp" method="POST">
			<div>
				<label>Select Employee:</label> 
				<select name="id" required>
					<option value="">-- Select Employee --</option>
					<c:forEach var="emp" items="${allEmployees.rows}">
						<option value="${emp.id}">ID: ${emp.id} - ${emp.first_Name} ${emp.last_Name}</option>
					</c:forEach>
				</select>
			</div>

			<div>
				<h4>Select fields to update:</h4>

				<div class="checkbox-item">
					<input type="checkbox" name="updateFirst_Name" value="true">
					<label>First Name:</label> 
					<input type="text" name="first_Name" placeholder="New first name">
				</div>

				<div class="checkbox-item">
					<input type="checkbox" name="updateLast_Name" value="true">
					<label>Last Name:</label> 
					<input type="text" name="last_Name" placeholder="New last name">
				</div>

				<div class="checkbox-item">
					<input type="checkbox" name="updatePhone_Number" value="true">
					<label>Phone Number:</label> 
					<input type="text" name="phone_Number" placeholder="New phone number">
				</div>

				<div class="checkbox-item">
					<input type="checkbox" name="updateAge" value="true"> 
					<label>Age:</label>
					<input type="number" name="Age" placeholder="New age">
				</div>

				<div class="checkbox-item">
					<input type="checkbox" name="updateJoin_Date" value="true">
					<label>Join Date:</label> 
					<input type="date" name="Join_Date">
				</div>
			</div>

			<div>
				<button type="submit">Update Employee</button>
			</div>
		</form>
	</div>

	<!-- Delete Employee Form -->
	<div class="form-section">
		<h2>Delete Employee</h2>
		<form action="delete.jsp" method="POST">
			<div>
				<label>Select Employee to Delete:</label> 
				<select name="id" required>
					<option value="">-- Select Employee --</option>
					<c:forEach var="emp" items="${allEmployees.rows}">
						<option value="${emp.id}">ID: ${emp.id} - ${emp.first_Name} ${emp.last_Name}</option>
					</c:forEach>
				</select>
			</div>
			<div>
				<button type="submit">Delete Employee</button>
			</div>
		</form>
	</div>

	<!-- View Employee List Button -->
	<div class="form-section">
		<h2>View Employee</h2>
		<a href="employee_list.jsp"><button>Show Employee List</button></a>
	</div>

</body>
</html>