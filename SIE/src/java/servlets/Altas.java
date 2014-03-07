/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import conn.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class Altas extends HttpServlet {

    ConectionDB con = new ConectionDB();
    ConectionDB_SQLServer consql = new ConectionDB_SQLServer();
    java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy");
    java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

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
        String clave = "", descr = "";
        int ban1 = 0;
        try {
            if (request.getParameter("accion").equals("clave")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select clave, descrip from clave_med where clave='" + request.getParameter("clave") + "'");
                    while (rset.next()) {
                        ban1 = 1;
                        clave = rset.getString("clave");
                        descr = rset.getString("descrip");
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("descripcion")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select clave, descrip from clave_med where descrip='" + request.getParameter("descr") + "'");
                    while (rset.next()) {
                        ban1 = 1;
                        clave = rset.getString("clave");
                        descr = rset.getString("descrip");
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("capturar")) {
                ban1 = 1;
                String cla_pro = request.getParameter("clave1");
                /*if (Float.parseFloat(request.getParameter("clave1")) < 1000) {
                    cla_pro = "0" + request.getParameter("clave1");
                } else {
                    cla_pro = request.getParameter("clave1");
                }*/
                String lot_pro = dameLote(cla_pro, request.getParameter("Lote"), request.getParameter("Caducidad"));
                try {
                    int cajas = 0;
                    int piezas = 0;
                    int resto = 0;
                    try {
                        cajas = Integer.parseInt(request.getParameter("Cajas"));
                    } catch (Exception e) {
                        cajas = 0;
                    }
                    try {
                        piezas = Integer.parseInt(request.getParameter("pzsxcaja"));
                    } catch (Exception e) {
                        piezas = 0;
                    }
                    try {
                        resto = Integer.parseInt(request.getParameter("Resto"));
                    } catch (Exception e) {
                        resto = 0;
                    }
                    int cantidad = (cajas * piezas) + resto;
                    con.conectar();
                    byte[] a = request.getParameter("observaciones").getBytes("ISO-8859-1");
                    String value = new String(a, "UTF-8");
                    a = request.getParameter("pres").getBytes("ISO-8859-1");
                    String pres= new String(a, "UTF-8");
                    a = request.getParameter("Marca").getBytes("ISO-8859-1");
                    String marca= new String(a, "UTF-8");
                    con.insertar("insert into datos_inv_cod values ('" + request.getParameter("cb").toUpperCase() + "', '" + cla_pro.toUpperCase() + "', '" + lot_pro.toUpperCase() + "', '" + request.getParameter("descripci").toUpperCase() + "', '" + request.getParameter("Caducidad").toUpperCase() + "' ,'NUEVO', '" + cantidad + "', '" + request.getParameter("provee").toUpperCase() + "', '" + sesion.getAttribute("nombre") + "', CURDATE(), 'BODEGA EDO DURANGO', '0', '" + cajas + "', '" + piezas + "', '" + resto + "', '" + marca.toUpperCase() + "', '" + pres.toUpperCase() + "', '" + request.getParameter("origen") + "', '" + request.getParameter("coincide") + "', '" + request.getParameter("folio") + "', '" + request.getParameter("folio_remi") + "', '" + request.getParameter("orden") + "', '" + request.getParameter("FecFab") + "', '" + value.toUpperCase() + "') ");
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
        } catch (Exception e) {
        }
        request.getSession().setAttribute("folio", request.getParameter("folio"));
        request.getSession().setAttribute("fecha", request.getParameter("fecha"));
        request.getSession().setAttribute("folio_remi", request.getParameter("folio_remi"));
        request.getSession().setAttribute("orden", request.getParameter("orden"));
        request.getSession().setAttribute("provee", request.getParameter("provee"));
        request.getSession().setAttribute("recib", request.getParameter("recib"));
        request.getSession().setAttribute("entrega", request.getParameter("entrega"));
        request.getSession().setAttribute("origen", request.getParameter("origen"));
        request.getSession().setAttribute("coincide", request.getParameter("coincide"));
        //para que acepte acentos en el request
        byte[] a = request.getParameter("observaciones").getBytes("ISO-8859-1");
        String value = new String(a, "UTF-8");
        //
        request.getSession().setAttribute("observaciones", value);
        request.getSession().setAttribute("clave", clave);
        request.getSession().setAttribute("descrip", descr);

        //String original = "hello world";
        //byte[] utf8Bytes = original.getBytes("UTF8");
        //String value = new String(utf8Bytes, "UTF-8"); 
        //out.println(value);
        if (ban1 == 0) {
            out.println("<script>alert('Clave Inexistente')</script>");
            out.println("<script>window.location='captura.jsp'</script>");
        } else {
            out.println("<script>window.location='captura.jsp'</script>");
        }
        //response.sendRedirect("captura.jsp");
    }

    public String dameLote(String cla_pro, String lot_pro, String fec_cad) throws ParseException {
        String lote = lot_pro;
        try {
            consql.conectar();
            ResultSet rset = consql.consulta("select F_FecCad from TB_Lote where F_ClaPro = '" + cla_pro + "' and F_ClaLot = '" + lote + "'  group by F_FecCad");
            while (rset.next()) {
                System.out.println(rset.getString("F_FecCad"));
                if (!(fec_cad).equals(df2.format(df.parse(rset.getString("F_FecCad"))))) {
                    lote = lote + "*";
                    rset.first();
                }

            }
            consql.cierraConexion();
        } catch (SQLException e) {
        }

        return lote;
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
