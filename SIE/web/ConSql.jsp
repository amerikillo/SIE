<%-- 
    Document   : ConSql
    Created on : 26/02/2014, 07:55:08 AM
    Author     : Americo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conn.*" %>
<%
    ConectionDB_SQLServer consql=new ConectionDB_SQLServer();
    try{
        consql.conectar();
        //consql.cierraConexion();
    }catch (Exception e){
        out.println(e.getMessage());
    }
%>
