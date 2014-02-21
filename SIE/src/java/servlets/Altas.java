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
import conn.ConectionDB;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class Altas extends HttpServlet {

    ConectionDB con = new ConectionDB();

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
        String clave="", descr="";
        try {
            if (request.getParameter("accion").equals("clave")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select clave, descrip from clave_med where clave='"+request.getParameter("clave")+"'");
                    while(rset.next()){
                        clave=rset.getString("clave");
                        descr=rset.getString("descrip");
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("descripcion")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select clave, descrip from clave_med where descrip='"+request.getParameter("descr")+"'");
                    while(rset.next()){
                        clave=rset.getString("clave");
                        descr=rset.getString("descrip");
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("capturar")) {
                try {
                    int cajas=0;int piezas=0;int resto=0;
                    try{
                    cajas=Integer.parseInt(request.getParameter("Cajas"));
                    }catch (Exception e) {cajas=0;}
                    try{
                    piezas=Integer.parseInt(request.getParameter("pzsxcaja"));
                     }catch (Exception e) {piezas=0;}
                    try{
                    resto=Integer.parseInt(request.getParameter("Resto"));
                     }catch (Exception e) {resto=0;}
                    int cantidad= (cajas*piezas)+resto;
                    con.conectar();
                    con.insertar("insert into datos_inv_cod values ('"+request.getParameter("cb")+"', '"+request.getParameter("clave1")+"', '"+request.getParameter("Lote")+"', '"+request.getParameter("descripci")+"', '"+request.getParameter("Caducidad")+"' ,'NUEVO', '"+cantidad+"', '"+request.getParameter("provee")+"', '"+sesion.getAttribute("nombre")+"', CURDATE(), 'BODEGA EDO DURANGO', '0', '"+cajas+"', '"+piezas+"', '"+resto+"', '"+request.getParameter("Marca")+"', '"+request.getParameter("pres")+"', '"+request.getParameter("origen")+"', '"+request.getParameter("coincide")+"', '"+request.getParameter("folio")+"', '"+request.getParameter("folio_remi")+"', '"+request.getParameter("orden")+"') ");
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
        request.getSession().setAttribute("observaciones", request.getParameter("observaciones"));
        request.getSession().setAttribute("clave", clave);
        request.getSession().setAttribute("descrip", descr);
        response.sendRedirect("captura.jsp");
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
