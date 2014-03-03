<%-- 
    Document   : index
    Created on : 17/02/2014, 03:34:46 PM
    Author     : Americo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conn.*" %>
<!DOCTYPE html>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddhhmmss"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%

    HttpSession sesion = request.getSession();
    String usua = "";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
    } else {
        response.sendRedirect("index.jsp");
    }
    ConectionDB con = new ConectionDB();

    String fol_gnkl = "", fol_remi = "", orden_compra = "", fecha = "";
    try {
        if (request.getParameter("accion").equals("buscar")) {
            fol_gnkl = request.getParameter("fol_gnkl");
            fol_remi = request.getParameter("fol_remi");
            orden_compra = request.getParameter("orden_compra");
            fecha = request.getParameter("fecha");
        }
    } catch (Exception e) {

    }
    if (fol_gnkl == null) {
        fol_gnkl = "";
        fol_remi = "";
        orden_compra = "";
        fecha = "";
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
        <link href="css/datepicker3.css" rel="stylesheet">
        <!---->
        <title>SIE Sistema de Ingreso de Entradas</title>
    </head>
    <body>
        <div class="container">
            <h1>SIE</h1>
            <div class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="main_menu.jsp">Sistema de Ingreso de Entradas</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="captura.jsp">Captura de Insumos</a></li>
                            <li><a href="catalogo.jsp">Catálogo de Proveedores</a></li>
                            <!--li><a href="historial.jsp">Catalogo de Lotes</a></li-->
                            <li><a href="reimpresion.jsp">Reimpresión de Docs</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href=""><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>

            <div>
                <h3>Reimpresion de Documentos</h3>
                <h4>Seleccione el folio a imprimir</h4>
                <form method="post">
                    <div class="row">
                        <div class="col-md-12 disabled">
                            <h4>Filtrar por:</h4>
                        </div>
                    </div> 
                    <div class = "row">
                        <div class="col-md-1">
                            Folio GNKL: 
                        </div>
                        <div class = "col-md-2">
                            <input type="text" class="form-control" name="fol_gnkl" value="<%=fol_gnkl%>">
                        </div>
                        <div class="col-md-1">
                            Folio de Remisión
                        </div>
                        <div class = "col-md-2">
                            <input type="text" class="form-control" name="fol_remi" value="<%=fol_remi%>">
                        </div>
                        <div class="col-md-1">
                            Orden de Compra 
                        </div>
                        <div class = "col-md-2">
                            <input type="text" class="form-control" name="orden_compra" value="<%=orden_compra%>">
                        </div>
                        <div class="col-md-1">
                            Fecha
                        </div>
                        <div class = "col-md-2">
                            <input type="text" class="form-control" id="fecha" name="fecha" value="<%=fecha%>" data-date-format="yyyy-mm-dd">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <button class="btn btn-block btn-primary" type="submit" value="buscar" name="accion">Buscar</button>
                        </div>
                        <div class="col-lg-6">
                            <button class="btn btn-block btn-primary" type="submit">Todos</button>
                        </div>
                    </div>
                </form>
                <table class="table table-bordered table-striped">
                    <tr>
                        <td>Folio GNKL</td>
                        <td>Folio Remisión</td>
                        <td>Orden de Compra</td>
                        <td>Fecha</td>
                        <td></td>
                    </tr>
                    <%
                        try {
                            con.conectar();
                            try {
                                ResultSet rset = con.consulta("select folio_gnk, folio_remi, orden_compra, date from datos_inv_cod where folio_gnk like  '%" + fol_gnkl + "%' and folio_remi like '%" + fol_remi + "%' and orden_compra like '%" + orden_compra + "%' and date like  '%" + fecha + "%'  group by folio_gnk;");
                                while (rset.next()) {
                    %>
                    <tr>

                        <td><%=rset.getString(1)%></td>
                        <td><%=rset.getString(2)%></td>
                        <td><%=rset.getString(3)%></td>
                        <td><%=rset.getString(4)%></td>
                        <td>
                            <form action="reimpReporte.jsp">
                                <input class="hidden" name="fol_gnkl" value="<%=rset.getString(1)%>">
                                <button class="btn btn-block btn-primary">Imprimir</button>
                            </form>
                        </td>
                    </tr>
                    <%
                                }
                            } catch (Exception e) {

                            }
                            con.cierraConexion();
                        } catch (Exception e) {

                        }
                    %>
                    <tr>

                    </tr>
                </table>
            </div>
        </div>
        <br><br><br>
        <div class="navbar navbar-fixed-bottom navbar-inverse">
            <div class="text-center text-muted">
                GNK Logística || Desarrollo de Aplicaciones 2009 - 2014 <span class="glyphicon glyphicon-registration-mark"></span><br />
                Todos los Derechos Reservados
            </div>
        </div>
    </body>
</html>


<!-- 
================================================== -->
<!-- Se coloca al final del documento para que cargue mas rapido -->
<!-- Se debe de seguir ese orden al momento de llamar los JS -->
<script src="js/jquery-1.9.1.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-ui-1.10.3.custom.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script>
                                    $(function() {
                                        $("#fecha").datepicker();
                                        $("#fecha").datepicker('option', {dateFormat: 'dd/mm/yy'});
                                    });
</script>