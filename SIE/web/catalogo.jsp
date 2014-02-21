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
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
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
                            <li><a href="historial.jsp">Catalogo de Lotes</a></li>
                            <li><a href="reimpresion.jsp">Reimpresión de Docs</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href=""><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Catalogo de Proveedores</h3>
            </div>
            <div class="panel-body ">
                <form class="form-horizontal" role="form" name="formulario1" id="formulario1" method="post" action="Proveedores">
                    <div class="form-group">
                        <div class="form-group">
                            <label for="Clave" class="col-xs-1 control-label">Clave</label>
                            <div class="col-xs-1">
                                <input type="text" class="form-control" id="Clave" name="Clave" placeholder="Clave" onKeyPress="return tabular(event, this)" autofocus >
                            </div>
                            <label for="Nombre" class="col-xs-1 control-label">Nombre</label>
                            <div class="col-xs-1">
                                <input type="text" class="form-control" id="Nombre" name="Nombre" placeholder="Nombre" onKeyPress="return tabular(event, this)" />
                            </div>
                            <label for="Direccion" class="col-xs-1 control-label">Dirección</label>
                            <div class="col-xs-3">
                                <input type="text" class="form-control" id="Direccion" name="Direccion" placeholder="Direccion" onKeyPress="return tabular(event, this)" />
                            </div>
                            <label for="Colonia" class="col-xs-1 control-label">Colonia</label>
                            <div class="col-xs-2">
                                <input type="text" class="form-control" id="Colonia" name="Colonia" placeholder="Colonia" onKeyPress="return tabular(event, this)" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <label for="Poblacion" class="col-xs-1 control-label">Población</label>
                            <div class="col-xs-1">
                                <input type="text" class="form-control" id="Poblacion" name="Poblacion" placeholder="Poblacion" onKeyPress="return tabular(event, this)"  >
                            </div>
                            <label for="CP" class="col-xs-1 control-label">C.P.</label>
                            <div class="col-xs-1">
                                <input type="text" class="form-control" id="CP" name="CP" placeholder="CP" onKeyPress="return tabular(event, this)" />
                            </div>
                            <label for="RFC" class="col-xs-1 control-label">RFC</label>
                            <div class="col-xs-3">
                                <input type="text" class="form-control" id="RFC" name="RFC" placeholder="RFC" onKeyPress="return tabular(event, this)" />
                            </div>
                            <label for="CON" class="col-xs-1 control-label">CON</label>
                            <div class="col-xs-2">
                                <input type="text" class="form-control" id="CON" name="CON" placeholder="CON" onKeyPress="return tabular(event, this)" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <label for="CLS" class="col-xs-1 control-label">CLS</label>
                            <div class="col-xs-1">
                                <input type="CLS" class="form-control" id="CLS" name="CLS" placeholder="CLS" onKeyPress="return tabular(event, this)"  >
                            </div>
                            <label for="Telefono" class="col-xs-1 control-label">Telefono</label>
                            <div class="col-xs-1">
                                <input type="text" class="form-control" id="Telefono" name="Telefono" placeholder="Telefono" onKeyPress="return tabular(event, this)" />
                            </div>
                            <label for="FAX" class="col-xs-1 control-label">FAX</label>
                            <div class="col-xs-3">
                                <input type="text" class="form-control" id="FAX" name="FAX" placeholder="FAX" onKeyPress="return tabular(event, this)" />
                            </div>
                            <label for="Mail" class="col-xs-1 control-label">Mail</label>
                            <div class="col-xs-2">
                                <input type="text" class="form-control" id="Mail" name="Mail" placeholder="Mail" onKeyPress="return tabular(event, this)" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <label for="Observaciones" class="col-xs-2 control-label">Observaciones</label>
                            <div class="col-xs-4">
                                <textarea class="form-control" id="Observaciones" name="Observaciones" placeholder="Observaciones" onKeyPress="return tabular(event, this)"></textarea>
                            </div>
                            <div class="col-xs-1">
                                <button class="btn btn-block btn-primary" type="submit" name="accion" accion="guardar" onclick="valida_alta();"> Guardar</button> 
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="panel-footer">
                <table class="table table-bordered">
                    <tr>
                        <td>Clave</td>
                        <td>Nombre</td>
                        <td>Direccion</td>
                        <td>Colonia</td>
                        <td>Poblacion</td>
                        <td>CP</td>
                        <td>RFC</td>
                        <td>Con</td>
                        <td>Cls</td>
                        <td>Telefono</td>
                        <td>Fax</td>
                        <td>Mail</td>
                        <td>Observaciones</td>
                    </tr>
                    <%
                        try {
                            con.conectar();
                            ResultSet rset = con.consulta("select * from provee_all order by F_Claprv asc");
                            while (rset.next()) {
                    %>
                    <tr>
                        <td><small><%=rset.getString(1)%></small></td>
                        <td><small><%=rset.getString(2)%></small></td>
                        <td><small><%=rset.getString(3)%></small></td>
                        <td><small><%=rset.getString(4)%></small></td>
                        <td><small><%=rset.getString(5)%></small></td>
                        <td><small><%=rset.getString(6)%></small></td>
                        <td><small><%=rset.getString(7)%></small></td>
                        <td><small><%=rset.getString(8)%></small></td>
                        <td><small><%=rset.getString(9)%></small></td>
                        <td><small><%=rset.getString(10)%></small></td>
                        <td><small><%=rset.getString(11)%></small></td>
                        <td><small><%=rset.getString(12)%></small></td>
                        <td><small><%=rset.getString(13)%></small></td>

                    <form method="get" action="">
                        <input name="id" type="text" style="" class="hidden" value="<%=rset.getString(1)%>" />
                        <td>
                            <div class="col-xs-1">
                                <button class="btn btn-warning" name="accion" value="modificar"><span class="glyphicon glyphicon-pencil" ></span></button>
                            </div>
                        </td>
                        <td>
                            <div  class="col-xs-1 ">
                                <button class="btn btn-danger" onclick="return confirm('¿Seguro de que desea eliminar?');" name="accion" value="eliminar"><span class="glyphicon glyphicon-remove"></span></button>
                            </div>
                        </td>
                    </form>
                    </tr>
                    <%
                            }
                            con.cierraConexion();
                        } catch (Exception e) {
                        }
                    %>
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
<script>
    function valida_alta(){
        var Clave = document.formulario1.Clave.value;
        var Nombre = document.formulario1.Nombre.value;
        var Telefono = document.formulario1.Telefono.value;
        if (Clave === "" || Nombre === "" || Telefono === "") {
            alert("Tiene campos vacíos, verifique.");
            return false;
        }
    }
</script>