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
    String folio_gnk = "", fecha = "", folio_remi = "", orden = "", provee = "", recib = "", entrega = "", origen = "", coincide = "", observaciones = "", clave = "", descrip = "";
    try {
        folio_gnk = (String) session.getAttribute("folio");
        fecha = (String) session.getAttribute("fecha");
        folio_remi = (String) session.getAttribute("folio_remi");
        orden = (String) session.getAttribute("orden");
        provee = (String) session.getAttribute("provee");
        recib = (String) session.getAttribute("recib");
        entrega = (String) session.getAttribute("entrega");
        origen = (String) session.getAttribute("origen");
        coincide = (String) session.getAttribute("coincide");
        observaciones = (String) session.getAttribute("observaciones");
        clave = (String) session.getAttribute("clave");
        descrip = (String) session.getAttribute("descrip");
    } catch (Exception e) {
    }
    if (folio_gnk == null || folio_gnk.equals("")) {
        try {
            con.conectar();
            ResultSet rset = con.consulta("select max(folio_gnk) from datos_inv_cod");
            while (rset.next()) {
                folio_gnk = Integer.toString(Integer.parseInt(rset.getString(1)) + 1);
            }

            con.cierraConexion();
        } catch (Exception e) {
        }
        if (folio_gnk == null || folio_gnk.equals("null")) {
            folio_gnk = "1";
        }
        fecha = "";
        folio_remi = "";
        orden = "";
        provee = "";
        recib = "";
        entrega = "";
        origen = "";
        coincide = "";
        observaciones = "";
        clave = "";
        descrip = "";
    }
    //out.println((String)session.getAttribute("servletMsg"));
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/datepicker3.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
        <!---->
        <title>SIE Sistema de Ingreso de Entradas</title>
    </head>
    <body onLoad="foco();">
<div class="container">
            <h1>SIALSS</h1>
            <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4>
            <div class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="main_menu.jsp">Inicio</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">SIE <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="captura.jsp">Captura de Insumos</a></li>
                                    <li class="divider"></li>
                                    <li><a href="catalogo.jsp">Catálogo de Proveedores</a></li>
                                    <li><a href="reimpresion.jsp">Reimpresión de Docs</a></li>
<<<<<<< HEAD
                                    <li class="divider"></li>
                                    <li><a href="http://localhost:8088/Ubi">Ubicaciones</a></li>
                                    <li class="divider"></li>
                                    <li><a href="comparaUbiSgw.jsp">Diferencias SGW Ubicaciones</a></li>
                                </ul>
                            </li>
                            <!--li class="dropdown">
=======
                                </ul>
                            </li>
                            <li class="dropdown">
>>>>>>> FETCH_HEAD
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">ADASU<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="captura.jsp">Captura de Insumos</a></li>
                                    <li class="divider"></li>
                                    <li><a href="catalogo.jsp">Catálogo de Proveedores</a></li>
                                    <li><a href="reimpresion.jsp">Reimpresión de Docs</a></li>
                                </ul>
<<<<<<< HEAD
                            </li-->
                            <%
                                if (usua.equals("root")) {
                            %>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Usuario<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="usuarios/usuario_nuevo.jsp">Nuevo Usuario</a></li>
                                    <li><a href="usuarios/edita_usuario.jsp">Edicion de Usuarios</a></li>
                                </ul>
                            </li>
                            <%                                }
                            %>
=======
                            </li>
>>>>>>> FETCH_HEAD
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href=""><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Captura de Insumo</h3>
                </div>
                <form class="form-horizontal" role="form" name="formulario1" id="formulario1" method="post" action="Altas">
                    <div class="panel-body">
                        <div class="form-group">
                            <div class="form-group">
                                <label for="folio" class="col-sm-2 control-label">Folio GNK</label>
                                <div class="col-sm-2">
                                    <input type="folio" class="form-control" id="folio" name="folio" placeholder="Folio" readonly value="<%=folio_gnk%>"/>
                                </div>
                                <label for="fecha" class="col-sm-1 control-label">Fecha</label>
                                <div class="col-sm-2">
                                    <input type="fecha" class="form-control" id="fecha" name="fecha" placeholder="Fecha" readonly value="<%=df3.format(new java.util.Date())%>">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="fol_rem" class="col-sm-2 control-label">Folio Remisión</label>
                                <div class="col-sm-3">
                                    <input type="fol_rem" class="form-control" id="folio_remi" name="folio_remi" placeholder="Folio Remisión" onKeyPress="return tabular(event, this)" autofocus value="<%=folio_remi%>">
                                </div>
                                <label for="orden" class="col-sm-2 control-label">Orden de Compra</label>
                                <div class="col-sm-3">
                                    <input type="orden" class="form-control" id="orden" name="orden" placeholder="Orden de Compra" onKeyPress="return tabular(event, this)" value="<%=orden%>"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="prov" class="col-sm-2 control-label">Proveedor</label>
                                <div class="col-sm-3">
                                    <input type="prov" class="form-control" id="provee" name="provee" placeholder="Proveedor" readonly onKeyPress="return tabular(event, this)" value="<%=provee%>" />
                                </div>
                                <div class="col-sm-3">
                                    <select class="form-control" name="list_provee" onKeyPress="return tabular(event, this)" id="list_provee" onchange="proveedor();">
                                        <option value="">Seleccione un Proveedor</option>
                                        <%
                                            try {
                                                con.conectar();
                                                ResultSet rset = con.consulta("select f_nomprov from provee_all");
                                                while (rset.next()) {
                                                    out.println("<option value = '" + rset.getString("f_nomprov") + "'>" + rset.getString("f_nomprov") + "</option>");
                                                }
                                                con.cierraConexion();
                                            } catch (Exception e) {
                                            }
                                        %>
                                    </select>
                                </div>
                                <label for="prov" class="col-sm-2 control-label"><a href="catalogo.jsp" target="_blank">Proveedor Nuevo</a></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="recib" class="col-sm-2 control-label">Recibido por</label>
                                <div class="col-sm-3">
                                    <input type="recib" class="form-control" id="recib" name="recib" placeholder="Recibe" onKeyPress="return tabular(event, this)" value = "<%=usua%>" readonly>
                                </div>
                                <label for="entrega" class="col-sm-2 control-label">Entregado por</label>
                                <div class="col-sm-3">
                                    <input type="entrega" class="form-control" id="entrega" name="entrega" placeholder="Entrega" onKeyPress="return tabular(event, this)"  value="<%=entrega%>">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="origen" class="col-sm-2 control-label">Origen</label>
                                <%
                                    if (origen.equals("")) {
                                %>
                                <div class="col-sm-2 control-label">
                                    <input type="radio" name="origen" value="1" onKeyPress="return tabular(event, this)" > SSD
                                    <input type="radio" name="origen" value="2" checked onKeyPress="return tabular(event, this)"> Soriana
                                </div>                
                                <%
                                } else {
                                %>
                                <div class="col-sm-2 control-label">
                                    <input type="radio" name="origen" value="1" <% if (origen.equals("1")) {
                                            out.print("checked='checked'");
                                        } %> onKeyPress="return tabular(event, this)" > SSD
                                    <input type="radio" name="origen" value="2" <% if (origen.equals("2")) {
                                            out.print("checked='checked'");
                                        } %>  onkeypress="return tabular(event, this)"> Soriana
                                </div>  
                                <%
                                    }
                                %>
                                <label for="coincide" class="col-sm-4 control-label">Coincide el Documento con la Remisión</label>
                                <%
                                    if (coincide.equals("")) {
                                %>
                                <div class="col-sm-1 control-label">
                                    <input type="radio" name="coincide" value="Si" checked onKeyPress="return tabular(event, this)"> Si
                                    <input type="radio" name="coincide" value="No"  onkeypress="return tabular(event, this)"> No
                                </div>
                                <%
                                } else {
                                %>
                                <div class="col-sm-1 control-label">
                                    <input type="radio" name="coincide" value="Si" <% if (coincide.equals("Si")) {
                                            out.print("checked='checked'");
                                        } %> onKeyPress="return tabular(event, this)"> Si
                                    <input type="radio" name="coincide" value="No" <% if (coincide.equals("No")) {
                                            out.print("checked='checked'");
                                        } %> onKeyPress="return tabular(event, this)"> No
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="origen" class="col-sm-2 control-label">Observaciones</label>
                                <div class="col-sm-8">
                                    <textarea class="form-control" name ="observaciones" id ="observaciones" placeholder="Observaciones" onKeyPress="return tabular(event, this)"><%=observaciones%></textarea>
                                </div>
                            </div>
                        </div>
                        <!-- En duda -->
                        <!--button class="btn btn-block btn-info">Guardar</button-->
                        <!-- En duda -->
                    </div>
                    <div class="panel-footer">
                        <div class="form-group">
                            <div class="form-group">
                                <label for="clave" class="col-sm-1 control-label">Clave</label>
                                <div class="col-sm-2">
                                    <input type="clave" class="form-control" id="clave" name="clave" placeholder="Clave" onKeyPress="return tabular(event, this)">
                                </div>
                                <div class="col-sm-1">
                                    <button class="btn btn-block btn-primary" type = "submit" value = "clave" name = "accion" >Clave</button>
                                </div>
                                <label for="descr" class="col-sm-1 control-label">Descripción</label>
                                <div class="col-sm-4">
                                    <input type="descr" class="form-control" id="descr" name="descr" placeholder="Descripción" onKeyPress="return tabular(event, this)">
                                </div>
                                <div class="col-sm-2">
                                    <button class="btn btn-block btn-primary"  type = "submit" value = "descripcion" name = "accion" >Descripción</button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="clave1" class="col-sm-1 control-label">Clave</label>
                                <div class="col-sm-2">
                                    <input type="clave1" class="form-control" id="clave1" name="clave1" placeholder="Clave" value="<%=clave%>" readonly onKeyPress="return tabular(event, this)">
                                </div>
                                <label for="descr1" class="col-sm-1 control-label">Descripción</label>
                                <div class="col-sm-3">
                                    <textarea class="form-control" name="descripci" id="descripci" readonly onKeyPress="return tabular(event, this)"><%=descrip%></textarea>
                                </div>
                                <label for="cb" class="col-sm-2 control-label">Código de Barras</label>
                                <div class="col-sm-2">
                                    <input type="cb" class="form-control" id="cb" name="cb" placeholder="C. B." onKeyPress="return tabular(event, this)" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="Marca" class="col-sm-1 control-label">Marca</label>
                                <div class="col-sm-2">
                                    <input type="Marca" class="form-control" id="Marca" name="Marca" placeholder="Marca" onKeyPress="return tabular(event, this)" />
                                </div>
                                <label for="pres" class="col-sm-1 control-label">Presentación</label>
                                <div class="col-sm-2">
                                    <textarea class="form-control" placeholder="Presentación" name="pres" onKeyPress="return tabular(event, this)" ></textarea>
                                </div>
                                <label for="Lote" class="col-sm-1 control-label">Lote</label>
                                <div class="col-sm-2">
                                    <input type="Lote" class="form-control" id="Lote" name="Lote" placeholder="Lote" onKeyPress="return tabular(event, this)" />
                                </div>
                                <label for="FecFab" class="col-sm-1 control-label">Fec Fab</label>
                                <div class="col-sm-2">
                                    <input data-date-format="dd/mm/yyyy" type="text" class="form-control" id="FecFab" name="FecFab" placeholder="FecFab" onKeyPress="LP_data();anade(this);return tabular(event, this)" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="Caducidad" class="col-sm-1 control-label">Cadu</label>
                                <div class="col-sm-2">
                                    <input data-date-format="dd/mm/yyyy" type="text" class="form-control" id="Caducidad" name="Caducidad" placeholder="Caducidad" onKeyPress="LP_data();anade(this);return tabular(event, this)" />
                                </div>
                                <label for="Cajas" class="col-sm-1 control-label">Cajas</label>
                                <div class="col-sm-1">
                                    <input type="Cajas" class="form-control" id="Cajas" name="Cajas" placeholder="Cajas" onKeyPress="return justNumbers(event);" value="0" />
                                </div>
                                <label for="pzsxcaja" class="col-sm-2 control-label">Pzs x Caja</label>
                                <div class="col-sm-2">
                                    <input type="pzsxcaja" class="form-control" id="pzsxcaja" name="pzsxcaja" placeholder="Pzs x Caja" onKeyPress="return justNumbers(event);" value="0" />
                                </div>
                                <label for="Resto" class="col-sm-1 control-label">Resto</label>
                                <div class="col-sm-1">
                                    <input type="Resto" class="form-control" id="Resto" name="Resto" placeholder="Resto" onKeyPress="return justNumbers(event);" value="0" />
                                </div>
                            </div>
                        </div>
                        <!-- En duda -->
                        <button class="btn btn-block btn-primary" type="submit" name="accion" value="capturar" onclick="return (validaCapturaVacios());">Capturar</button>
                        <!-- En duda -->
                    </div>
                </form>
            </div>
            <div class="panel-body panel-default">
                <table class="table table-bordered table-striped">
                    <tr>
                        <td><a name="ancla"></a>Código de Barras</td>
                        <td>Clave</td>
                        <td>Descripción</td>
                        <td>UM</td>
                        <td>Lote</td>
                        <td>Caducidad</td>
                        <td>Cajas</td>
                        <td>No. de Piezas</td>
                        <td>Resto</td>
                        <td>Existencia</td>
                        <td></td>
                    </tr>
                    <%
                        int banCompra = 0;
                        String obser = "";
                        try {
                            con.conectar();
                            ResultSet rset = con.consulta("select cod_bar, clave, descr, um, lote, cadu, piezas, resto, cant, id_cap_inv, observaciones, cajas from datos_inv_cod where folio_gnk = '" + folio_gnk + "'");
                            while (rset.next()) {
                                banCompra = 1;
                                obser = rset.getString("observaciones");
                    %>
                    <tr>
                        <td><%=rset.getString(1)%></td>
                        <td><%=rset.getString(2)%></td>
                        <td><%=rset.getString(3)%></td>
                        <td><%=rset.getString(4)%></td>
                        <td><%=rset.getString(5)%></td>
                        <td><%=rset.getString(6)%></td>
                        <td><%=rset.getString(12)%></td>
                        <td><%=rset.getString(7)%></td>
                        <td><%=rset.getString(8)%></td>
                        <td><%=rset.getString(9)%></td>
                        <td>

                            <form method="get" action="Modificaciones">
                                <input name="id" type="text" style="" class="hidden" value="<%=rset.getString(10)%>" />
                                <button class="btn btn-warning" name="accion" value="modificar"><span class="glyphicon glyphicon-pencil" ></span></button>
                                <button class="btn btn-danger" onclick="return confirm('¿Seguro de que desea eliminar?');" name="accion" value="eliminar"><span class="glyphicon glyphicon-remove"></span></button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                            con.cierraConexion();
                        } catch (Exception e) {

                        }
                    %>
                    <%
                        if (banCompra == 1) {
                    %>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td colspan="2"><form action="Nuevo" method="post">
                                <input name="fol_gnkl" type="text" style="" class="hidden" value="<%=folio_gnk%>" />
                                <input type="text" value="<%=obser%>" name="observaciones" class="hidden" />
                                <button  value="Eliminar" name="accion" class="btn btn-danger btn-block" onclick="return confirm('Seguro que desea eliminar la compra?');">Cancelar Compra</button>
                            </form></td>
                        <td colspan="2"><form action="Nuevo" method="post">
                                <input name="fol_gnkl" type="text" style="" class="hidden" value="<%=folio_gnk%>" />
                                <input type="text" value="<%=obser%>" name="observaciones" class="hidden" />
                                <button  value="Guardar" name="accion" class="btn btn-warning btn-block" onclick="return confirm('Seguro que desea realizar la compra?');
                                        return validaCompra();">Confirmar Compra</button></form></td>
                        <td colspan="2"><a href="Reporte.jsp" class="btn btn-success btn-block">Imprimir</a></td>
                    </tr>
                    <%
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
<script src="js/bootstrap-datepicker.js"></script>
<script>
                                    $(function() {
                                        $("#Caducidad").datepicker();
                                        $("#Caducidad").datepicker('option', {dateFormat: 'dd/mm/yy'});
                                    });
                                    $(function() {
                                        $("#FecFab").datepicker();
                                        $("#FecFab").datepicker('option', {dateFormat: 'dd/mm/yy'});
                                    });
</script>
<script>
    $(function() {
        var availableTags = [
    <%
        try {
            con.conectar();
            ResultSet rset = con.consulta("select descrip from clave_med");
            while (rset.next()) {
                out.println("\'" + rset.getString("descrip") + "\',");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
    %>
        ];
        $("#descr").autocomplete({
            source: availableTags
        });
    });
</script>
<script>
    $(function() {
        var availableTags = [
    <%
        try {
            con.conectar();
            ResultSet rset = con.consulta("select f_nomprov from provee_all");
            while (rset.next()) {
                out.println("\'" + rset.getString("f_nomprov") + "\',");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
    %>
        ];
        $("#provee").autocomplete({
            source: availableTags
        });
    });
</script>
<script>
    function ubi() {
        var ubi = document.formulario1.ubica.value;
        document.formulario1.ubicacion.value = ubi;
    }
    function proveedor() {
        var proveedor = document.formulario1.list_provee.value;
        document.formulario1.provee.value = proveedor;
    }
    function orig() {
        var origen = document.formulario1.ori.value;
        document.formulario1.origen.value = origen;
    }
</script>
<script languaje="Javascript"> // este script hace que tabule el enter !!!
    function tabular(e, obj)
    {
        tecla = (document.all) ? e.keyCode : e.which;
        if (tecla != 13)
            return;
        frm = obj.form;
        for (i = 0; i < frm.elements.length; i++)
            if (frm.elements[i] == obj)
            {
                if (i == frm.elements.length - 1)
                    i = -1;
                break
            }
        /*ACA ESTA EL CAMBIO*/
        if (frm.elements[i + 1].disabled == true)
            tabular(e, frm.elements[i + 1]);
        else
            frm.elements[i + 1].focus();
        return false;
    }

    function foco() {
        if (document.formulario1.folio_remi.value !== "") {
            document.formulario1.clave.focus();
        }
        if (document.formulario1.clave1.value !== "") {
            document.formulario1.cb.focus();
            document.location.href = "#ancla";
        }
    }


    function validaCapturaVacios() {
        var RegExPattern = /^\d{1,2}\/\d{1,2}\/\d{2,4}$/;
        var folio_remi = document.formulario1.folio_remi.value;
        var orden = document.formulario1.orden.value;
        var provee = document.formulario1.provee.value;
        var recib = document.formulario1.recib.value;
        var entrega = document.formulario1.entrega.value;
        var clave1 = document.formulario1.clave1.value;
        var descripci = document.formulario1.descripci.value;
        var cb = document.formulario1.cb.value;
        var Caducidad = document.formulario1.Caducidad.value;
        var Cajas = document.formulario1.Cajas.value;
        var pzsxcaja = document.formulario1.pzsxcaja.value;
        var Resto = document.formulario1.Resto.value;
        var Obser = document.formulario1.observaciones.value;
        if (folio_remi === "" || orden === "" || provee === "" || recib === "" || entrega === "" || clave1 === "" || descripci === "" || cb === "" || Caducidad === "" || Cajas === "" || pzsxcaja === "" || Resto === "" || Obser === "") {
            alert("Tiene campos vacíos, verifique.");
            return false;
        }
        if ((Caducidad.match(RegExPattern)) && (Caducidad != '')) {
            return true;
        } else {
            alert("Caducidad Incorrecta, verifique.");
            return false;
        }
    }


    function validaCompra() {
        var RegExPattern = /^\d{1,2}\/\d{1,2}\/\d{2,4}$/;
        var folio_remi = document.formulario1.folio_remi.value;
        var orden = document.formulario1.orden.value;
        var provee = document.formulario1.provee.value;
        var recib = document.formulario1.recib.value;
        var entrega = document.formulario1.entrega.value;
        var Obser = document.formulario1.observaciones.value;
        if (folio_remi === "" || orden === "" || provee === "" || recib === "" || entrega === "" || clave1 === "" || descripci === "" || cb === "" || Caducidad === "" || Cajas === "" || pzsxcaja === "" || Resto === "" || Obser === "") {
            alert("Tiene campos vacíos, verifique.");
            return false;
        }
        if ((Caducidad.match(RegExPattern)) && (Caducidad != '')) {
            return true;
        } else {
            alert("Caducidad Incorrecta, verifique.");
            return false;
        }
    }
</script>
<script type="text/javascript">
    function justNumbers(e)
    {
        var keynum = window.event ? window.event.keyCode : e.which;
        if ((keynum == 8) || (keynum == 46))
            return true;

        return /\d/.test(String.fromCharCode(keynum));
    }
</script>

<script language="javascript">
    otro = 0;
    function LP_data() {
        var key = window.event.keyCode;//codigo de tecla. 
        if (key < 48 || key > 57) {//si no es numero 
            window.event.keyCode = 0;//anula la entrada de texto. 
        }
    }
    function anade(esto) {
        if (esto.value.length > otro) {
            if (esto.value.length == 2 ) {
                esto.value += "/";
            }
        }
        if (esto.value.length > otro) {
            if (esto.value.length == 5) {
                esto.value += "/";
            }
        }
        if (esto.value.length < otro) {
            if (esto.value.length == 2 || esto.value.length == 5) {
                esto.value = esto.value.substring(0, esto.value.length - 1);
            }
        }
        otro = esto.value.length
    }

</script> 