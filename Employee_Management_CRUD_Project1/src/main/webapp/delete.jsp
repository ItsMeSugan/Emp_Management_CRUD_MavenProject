<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ include file="db_config.jsp" %>

<c:set var="id" value="${param.id}" />

<c:if test="${not empty id}">
    <c:catch var="deleteException">
        <sql:update dataSource="${employeeDB}" var="deleteResult">
            DELETE FROM employees_info WHERE id = ?
            <sql:param value="${id}" />
        </sql:update>
        
        <c:choose>
            <c:when test="${deleteResult > 0}">
                <c:set var="message" value="Employee deleted successfully!" scope="session" />
            </c:when>
            <c:otherwise>
                <c:set var="error" value="Employee not found!" scope="session" />
            </c:otherwise>
        </c:choose>
    </c:catch>
    
    <c:if test="${not empty deleteException}">
        <c:set var="error" value="Error deleting employee: ${deleteException.message}" scope="session" />
    </c:if>
</c:if>

<c:redirect url="index.jsp" />