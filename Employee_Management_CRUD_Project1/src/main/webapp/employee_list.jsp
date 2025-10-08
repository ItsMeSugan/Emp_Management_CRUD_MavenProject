<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sql" uri="jakarta.tags.sql"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee List</title>
<style>
.table-style {
    border-collapse: collapse;
    border: 1px solid #000;
}
.table-style th, .table-style td {
    padding: 5px;
    border: 1px solid #000;
}


table {
	border-collapse: collapse;
	width: 100%;
	margin: 10px 0;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

button {
	padding: 5px 10px;
	margin: 5px;
}
</style>
</head>
<body>

	<h1>Employee List</h1>


	<sql:setDataSource var="employeeDB" driver="com.mysql.cj.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/employee_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
		user="root" password="Suganjana@1405" />

	<sql:query dataSource="${employeeDB}" var="result">
    	SELECT * FROM employees_info ORDER BY id DESC
	</sql:query>

	<c:if test="${result.rowCount == 0}">
		<p>No employees found.</p>
	</c:if>
	<c:if test="${result.rowCount > 0}">
		<table border="1" class="table-style">
			<tr>
				<th>ID</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Phone Number</th>
				<th>Age</th>
				<th>Join Date</th>
			</tr>
			<c:forEach var="row" items="${result.rows}">
				<tr>
					<td><c:out value="${row.id}" /></td>
					<td><c:out value="${row.first_Name}" /></td>
					<td><c:out value="${row.last_Name}" /></td>
					<td><c:out value="${row.phone_Number}" /></td>
					<td><c:out value="${row.Age}" /></td>
					<td><c:out value="${row.Join_Date}" /></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<div style="margin: 10px 0;">
		<a href="index.jsp"><button>Go Back</button></a>
	</div>

</body>
</html>