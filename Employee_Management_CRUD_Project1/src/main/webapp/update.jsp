<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sql" uri="jakarta.tags.sql"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ include file="db_config.jsp"%>

<c:set var="id" value="${param.id}" />
<c:set var="updateFirst_Name" value="${param.updateFirst_Name}" />
<c:set var="updateLast_Name" value="${param.updateLast_Name}" />
<c:set var="updatePhone_Number" value="${param.updatePhone_Number}" />
<c:set var="updateAge" value="${param.updateAge}" />
<c:set var="updateJoin_Date" value="${param.updateJoin_Date}" />

<c:set var="first_Name" value="${param.first_Name}" />
<c:set var="last_Name" value="${param.last_Name}" />
<c:set var="phone_Number" value="${param.phone_Number}" />
<c:set var="ageStr" value="${param.Age}" />
<c:set var="join_Date" value="${param.Join_Date}" />

 <c:if test="${not empty id}">
	<c:catch var="updateException">
		<c:set var="sqlQuery" value="UPDATE employees_info SET " />
		<c:set var="paramCount" value="0" />

		<c:if test="${updateFirst_Name == 'true' and not empty first_Name}">
			<c:set var="sqlQuery" value="${sqlQuery} first_Name = ?" />
			<c:set var="paramCount" value="${paramCount + 1}" />
		</c:if>

		<c:if test="${updateLast_Name == 'true' and not empty last_Name}">
			<c:if test="${paramCount > 0}">, </c:if>
			<c:set var="sqlQuery" value="${sqlQuery} last_Name = ?" />
			<c:set var="paramCount" value="${paramCount + 1}" />
		</c:if>

		<c:if
			test="${updatePhone_Number == 'true' and not empty phone_Number}">
			<c:if test="${paramCount > 0}">, </c:if>
			<c:set var="sqlQuery" value="${sqlQuery} phone_Number = ?" />
			<c:set var="paramCount" value="${paramCount + 1}" />
		</c:if>

		<c:if test="${updateAge == 'true' and not empty ageStr}">
			<c:if test="${paramCount > 0}">, </c:if>
			<fmt:parseNumber var="age" value="${ageStr}" integerOnly="true" />
			<c:set var="sqlQuery" value="${sqlQuery} Age = ?" />
			<c:set var="paramCount" value="${paramCount + 1}" />
		</c:if>

		<c:if test="${updateJoin_Date == 'true' and not empty join_Date}">
			<c:if test="${paramCount > 0}">, </c:if>
			<c:set var="sqlQuery" value="${sqlQuery} Join_Date = ?" />
			<c:set var="paramCount" value="${paramCount + 1}" />
		</c:if>

		<c:set var="sqlQuery" value="${sqlQuery} WHERE id = ?" />

		<c:if test="${paramCount > 0}">
			<sql:update dataSource="${employeeDB}" var="updateResult">
                ${sqlQuery}
                <c:if
					test="${updateFirst_Name == 'true' and not empty first_Name}">
					<sql:param value="${first_Name}" />
				</c:if>
				<c:if test="${updateLast_Name == 'true' and not empty last_Name}">
					<sql:param value="${last_Name}" />
				</c:if>
				<c:if
					test="${updatePhone_Number == 'true' and not empty phone_Number}">
					<sql:param value="${phone_Number}" />
				</c:if>
				<c:if test="${updateAge == 'true' and not empty ageStr}">
					<sql:param value="${age}" />
				</c:if>
				<c:if test="${updateJoin_Date == 'true' and not empty join_Date}">
					<sql:param value="${join_Date}" />
				</c:if>
				<sql:param value="${id}" />
			</sql:update>

			<c:choose>
				<c:when test="${updateResult > 0}">
					<c:set var="message" value="Employee updated successfully!"
						scope="session" />
				</c:when>
				<c:otherwise>
					<c:set var="error" value="Employee not found or no changes made!"
						scope="session" />
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test="${paramCount == 0}">
			<c:set var="error" value="No fields selected for update!"
				scope="session" />
		</c:if>
	</c:catch>

	<c:if test="${not empty updateException}">
		<c:set var="error"
			value="Error updating employee: ${updateException.message}"
			scope="session" />
	</c:if>
</c:if>

<c:redirect url="index.jsp" /> 


