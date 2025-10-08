<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<sql:setDataSource 
    var="employeeDB" 
    driver="com.mysql.cj.jdbc.Driver" 
    url="jdbc:mysql://localhost:3306/employee_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
    user="root"
    password="Suganjana@1405" />
