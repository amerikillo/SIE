/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import conn.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class Proveedores extends HttpServlet {

    ConectionDB con = new ConectionDB();
    ConectionDB_SQLServer consql = new ConectionDB_SQLServer();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession(true);
        try {
            /*
             *Para actualizar Registros
             */
            if (request.getParameter("accion").equals("actualizar")) {
                consql.conectar();
                con.conectar();
                try {
                    String clave = request.getParameter("Clave");
                    try {
                        int largoClave = request.getParameter("Clave").length();
                        int espacios = 5 - largoClave;
                        for (int i = 1; i <= espacios; i++) {
                            clave = " " + clave;
                        }
                    } catch (Exception e) {
                    }
                    consql.actualizar("update TB_Provee set F_ClaPrv='" + clave + "', F_NomPrv='" + request.getParameter("Nombre").toUpperCase() + "', F_Dir='" + request.getParameter("Direccion").toUpperCase() + "', F_Col='" + request.getParameter("Colonia").toUpperCase() + "', F_Pob='" + request.getParameter("Poblacion").toUpperCase() + "', F_CP='" + request.getParameter("CP").toUpperCase() + "', F_RFC='" + request.getParameter("RFC").toUpperCase() + "', F_Con='" + request.getParameter("CON").toUpperCase() + "', F_Cls='" + request.getParameter("CLS").toUpperCase() + "', F_Tel='" + request.getParameter("Telefono").toUpperCase() + "', F_Fax='" + request.getParameter("FAX").toUpperCase() + "', F_Mail='" + request.getParameter("Mail").toUpperCase() + "', F_Obs='" + request.getParameter("Observaciones").toUpperCase() + "' where F_ClaPrv='" + request.getParameter("id").toUpperCase() + "';");

                    con.actualizar("update provee_all set F_ClaPrv='" + clave + "', F_nomprov='" + request.getParameter("Nombre").toUpperCase() + "', F_Dir='" + request.getParameter("Direccion").toUpperCase() + "', F_Col='" + request.getParameter("Colonia").toUpperCase() + "', F_Pob='" + request.getParameter("Poblacion").toUpperCase() + "', F_CP='" + request.getParameter("CP").toUpperCase() + "', F_RFC='" + request.getParameter("RFC").toUpperCase() + "', F_Con='" + request.getParameter("CON").toUpperCase() + "', F_Cls='" + request.getParameter("CLS").toUpperCase() + "', F_Tel='" + request.getParameter("Telefono").toUpperCase() + "', F_Fax='" + request.getParameter("FAX").toUpperCase() + "', F_Mail='" + request.getParameter("Mail").toUpperCase() + "', F_Obs='" + request.getParameter("Observaciones").toUpperCase() + "' where F_ClaPrv='" + request.getParameter("id").toUpperCase() + "';");

                } catch (Exception e) {
                    System.out.println(e.getMessage());

                    out.println("<script>alert('Ya esta registrado ese proveedor')</script>");
                    out.println("<script>window.location='editar_proveedor.jsp'</script>");
                }
                con.cierraConexion();
                consql.cierraConexion();

                out.println("<script>alert('Proveedor actualizado correctamente.')</script>");
                out.println("<script>window.location='editar_proveedor.jsp'</script>");
            }
            /*
             *Manda al jsp el id del registro a editar
             */
            if (request.getParameter("accion").equals("editar")) {
                request.getSession().setAttribute("id", request.getParameter("id"));
                response.sendRedirect("editar_proveedor.jsp");
            }
            /*
             *Para eliminar registro
             */
            if (request.getParameter("accion").equals("eliminar")) {
                consql.conectar();
                con.conectar();
                try {
                    consql.insertar("delete from TB_Provee where F_ClaPrv = '" + request.getParameter("id") + "' ");
                    con.insertar("delete from provee_all where F_ClaPrv = '" + request.getParameter("id") + "' ");
                } catch (SQLException e) {
                    System.out.println(e.getMessage());

                    out.println("<script>alert('Error al eliminar')</script>");
                    out.println("<script>window.location='catalogo.jsp'</script>");
                }
                con.cierraConexion();
                consql.cierraConexion();

                out.println("<script>alert('Se elimino el proveedor correctamente')</script>");
                out.println("<script>window.location='catalogo.jsp'</script>");
            }
            /*
             *Guarda Registros
             */
            if (request.getParameter("accion").equals("guardar")) {
                try {
                    consql.conectar();
                    con.conectar();
                    try {
                        String clave = "";
                        ResultSet rset = con.consulta("select MAX(F_ClaPrv) from provee_all");
                        while (rset.next()) {
                            try {
                                clave = "" + ((Integer.parseInt(rset.getString(1).trim())) + 1);
                            } catch (Exception e) {
                            }
                        }
                        System.out.println("***" + clave + "---");
                        if (clave.equals("")) {
                            clave = "1";
                        }
                        try {
                            int largoClave = clave.length();
                            int espacios = 5 - largoClave;
                            for (int i = 1; i <= espacios; i++) {
                                clave = " " + clave;
                            }
                        } catch (Exception e) {
                        }
                        consql.insertar("insert into TB_Provee values ('" + clave + "', '" + request.getParameter("Nombre").toUpperCase() + "', '" + request.getParameter("Direccion").toUpperCase() + "', '" + request.getParameter("Colonia").toUpperCase() + "', '" + request.getParameter("Poblacion").toUpperCase() + "', '" + request.getParameter("CP").toUpperCase() + "', '" + request.getParameter("RFC").toUpperCase() + "', '" + request.getParameter("CON").toUpperCase() + "', '" + request.getParameter("CLS").toUpperCase() + "', '" + request.getParameter("Telefono").toUpperCase() + "', '" + request.getParameter("FAX").toUpperCase() + "', '" + request.getParameter("Mail").toUpperCase() + "', '" + request.getParameter("Observaciones").toUpperCase() + "');");

                        con.insertar("insert into provee_all values ('" + clave + "', '" + request.getParameter("Nombre").toUpperCase() + "', '" + request.getParameter("Direccion").toUpperCase() + "', '" + request.getParameter("Colonia").toUpperCase() + "', '" + request.getParameter("Poblacion").toUpperCase() + "', '" + request.getParameter("CP").toUpperCase() + "', '" + request.getParameter("RFC").toUpperCase() + "', '" + request.getParameter("CON").toUpperCase() + "', '" + request.getParameter("CLS").toUpperCase() + "', '" + request.getParameter("Telefono").toUpperCase() + "', '" + request.getParameter("FAX").toUpperCase() + "', '" + request.getParameter("Mail").toUpperCase() + "', '" + request.getParameter("Observaciones").toUpperCase() + "');");

                    } catch (SQLException e) {
                        System.out.println(e.getMessage());

                        out.println("<script>alert('Ya esta registrado ese proveedor')</script>");
                        out.println("<script>window.location='catalogo.jsp'</script>");
                    }
                    con.cierraConexion();
                    consql.cierraConexion();

                    out.println("<script>alert('Proveedor capturado correctamente.')</script>");
                    out.println("<script>window.location='catalogo.jsp'</script>");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

            }
        } catch (SQLException e) {

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
