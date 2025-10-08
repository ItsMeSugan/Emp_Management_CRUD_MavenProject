<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="db_config.jsp" %>

<c:set var="first_Name" value="${param.first_Name}" />
<c:set var="last_Name" value="${param.last_Name}" />
<c:set var="phone_Number" value="${param.phone_Number}" />
<c:set var="ageStr" value="${param.Age}" />
<c:set var="join_Date" value="${param.Join_Date}" />

<c:choose>
    <c:when test="${not empty first_Name and not empty last_Name and not empty phone_Number 
                    and not empty ageStr and not empty join_Date}">
        
        <c:catch var="insertException">
            <fmt:parseNumber var="age" value="${ageStr}" integerOnly="true" />
            
            <sql:update dataSource="${employeeDB}" var="insertResult">
                INSERT INTO employees_info (first_Name, last_Name, phone_Number, Age, Join_Date) 
                VALUES (?, ?, ?, ?, ?)
                <sql:param value="${first_Name}" />
                <sql:param value="${last_Name}" />
                <sql:param value="${phone_Number}" />
                <sql:param value="${age}" />
                <sql:param value="${join_Date}" />
            </sql:update>
            
            <c:choose>
                <c:when test="${insertResult > 0}">
                    <c:set var="message" value="Employee added successfully!" scope="session" />
                </c:when>
                <c:otherwise>
                    <c:set var="error" value="Failed to add employee!" scope="session" />
                </c:otherwise>
            </c:choose>
        </c:catch>
        
        <c:if test="${not empty insertException}">
            <c:set var="error" value="Error adding employee: ${insertException.message}" scope="session" />
        </c:if>
    </c:when>
    <c:otherwise>
        <c:set var="error" value="All fields are required!" scope="session" />
    </c:otherwise>
</c:choose>

<c:redirect url="index.jsp" />