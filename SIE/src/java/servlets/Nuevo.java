/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import conn.ConectionDB;
import conn.ConectionDB_SQLServer;
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
public class Nuevo extends HttpServlet {

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
        java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
        java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy");
        HttpSession sesion = request.getSession(true);
        try {
            if (request.getParameter("accion").equals("Eliminar")) {

                try {
                    con.conectar();
                    try {
                        con.insertar("delete from datos_inv_cod where folio_gnk = '" + request.getParameter("fol_gnkl") + "' ");
                    } catch (Exception e) {

                    }
                    con.cierraConexion();
                    request.getSession().setAttribute("folio", "");
                    request.getSession().setAttribute("fecha", "");
                    request.getSession().setAttribute("folio_remi", "");
                    request.getSession().setAttribute("orden", "");
                    request.getSession().setAttribute("provee", "");
                    request.getSession().setAttribute("recib", "");
                    request.getSession().setAttribute("entrega", "");
                    request.getSession().setAttribute("origen", "");
                    request.getSession().setAttribute("coincide", "");
                    request.getSession().setAttribute("observaciones", "");
                    request.getSession().setAttribute("clave", "");
                    request.getSession().setAttribute("descrip", "");
                } catch (Exception e) {
                }

                out.println("<script>alert('Compra cancelada')</script>");
            }
            if (request.getParameter("accion").equals("Guardar")) {
                System.out.println(request.getParameter("observaciones"));
                if (!request.getParameter("observaciones").equals("")) {
                    String idObser = insertaObservacionesCompra(request.getParameter("observaciones"));
                    try {
                        con.conectar();
                        String Cla_Doc = "";
                        try {
                            consql.conectar();
                            ResultSet rset = consql.consulta("select F_IC from TB_Indice");
                            while (rset.next()) {
                                Cla_Doc = rset.getString("F_IC");
                                consql.actualizar("update TB_Indice set F_IC= ' " + (rset.getInt("F_IC") + 1) + " '");
                            }
                            consql.cierraConexion();
                        } catch (Exception e) {
                        }
                        ResultSet rsetm = con.consulta("select * from datos_inv_cod where folio_gnk = '" + request.getParameter("fol_gnkl") + "' ");
                        while (rsetm.next()) {
                            String Precio = "", idLote = "", Cla_Prv = "";
                            double PreCant = 0.0;
                            double Impuesto = 0.0, CompraTotal = 0.0;
                            consql.conectar();
                            try {

                                ResultSet rset = consql.consulta("select F_ClaPrv from TB_Provee where F_NomPrv = '" + rsetm.getString("equipo") + "' ");
                                while (rset.next()) {
                                    Cla_Prv = rset.getString("F_ClaPrv");
                                }

                                rset = consql.consulta("select F_Precio from TB_Medica where F_ClaPro = '" + rsetm.getString("clave") + "' ");
                                while (rset.next()) {
                                    Precio = rset.getString("F_Precio");
                                }
                                try {
                                    PreCant = Double.parseDouble(Precio) * Double.parseDouble(rsetm.getString("cant"));
                                } catch (Exception e) {
                                    System.out.println(e.getMessage());
                                    PreCant = 0;
                                }

                                if (Float.parseFloat(rsetm.getString("clave")) > 9999) {
                                    Impuesto = PreCant * 0.16;
                                }

                                CompraTotal = Impuesto + PreCant;

                                idLote = idLote(rsetm.getString("clave"), rsetm.getString("lote"), rsetm.getString("cadu"), rsetm.getString("cant"), CompraTotal, dame5car(rsetm.getString("origen")), rsetm.getString("fec_fab"));
                                consql.conectar();
                                sumaCompraInventario(rsetm.getString("clave"), rsetm.getString("cant"));
                                consql.conectar();
                                consql.insertar("insert into TB_Compra values ('C', '" + dame7car(Cla_Doc) + "', '" + Cla_Prv + "', 'A',  '  000', '" + df2.format(df.parse(rsetm.getString("date"))) + " 00:00:00', NULL, '" + rsetm.getString("clave") + "', '', NULL, '1', '" + rsetm.getString("cant") + "', '0', '" + PreCant + "', '0', '" + PreCant + "', '" + PreCant + "', '0', '" + Impuesto + "', '" + CompraTotal + "', '" + Precio + "', '" + idLote + "', 'D', '" + df2.format(df.parse(rsetm.getString("date"))) + " 00:00:00', '" + sesion.getAttribute("nombre") + "', '" + idObser + "', '" + idObser + "', '', '" + rsetm.getString("folio_remi") + "') ");
                                consql.conectar();
                                insertaMovimiento(Cla_Doc, rsetm.getString("clave"), rsetm.getString("cant"), Precio, CompraTotal, idLote, idObser, Cla_Prv);
                                consql.conectar();
                                insertaCompraBitacora(sesion.getAttribute("nombre").toString(), "COMPRA-MANUAL", "REGISTRAR", Cla_Doc, "1", "COMPRAS");
                                consql.cierraConexion();
                            } catch (Exception e) {
                                System.out.println(e.getMessage());
                            }
                            consql.cierraConexion();
                        }
                        con.cierraConexion();
                    } catch (Exception e) {
                    }
                }

                request.getSession().setAttribute("folio", "");
                request.getSession().setAttribute("fecha", "");
                request.getSession().setAttribute("folio_remi", "");
                request.getSession().setAttribute("orden", "");
                request.getSession().setAttribute("provee", "");
                request.getSession().setAttribute("recib", "");
                request.getSession().setAttribute("entrega", "");
                request.getSession().setAttribute("origen", "");
                request.getSession().setAttribute("coincide", "");
                request.getSession().setAttribute("observaciones", "");
                request.getSession().setAttribute("clave", "");
                request.getSession().setAttribute("descrip", "");

                out.println("<script>alert('Compra realizada, datos transferidos correctamente')</script>");
            }
        } catch (Exception e) {
        }
        out.println("<script>window.location='captura.jsp'</script>");
        //response.sendRedirect("captura.jsp");
    }

    public String insertaObservacionesCompra(String obser) {
        String id = dameIdObser();

        try {
            consql.conectar();
            try {
                consql.insertar("insert into TB_Obser values ('" + id + "', '" + obser + "')");
            } catch (Exception e) {
            }
            consql.cierraConexion();
        } catch (Exception e) {
        }
        return id;
    }

    public void insertaCompraBitacora(String usuario, String modulo, String boton, String folio, String concepto, String obser) {
        try {
            consql.conectar();
            try {
                consql.insertar(" INSERT INTO TB_Bitacora(F_BitUsu, F_BitFec, F_BitMod, F_BitAcc, F_BitFol, F_BitCon, F_BitObs) VALUES('" + usuario + "', getdate(), '" + modulo + "', '" + boton + "', '    " + folio + "', '" + concepto + "', '" + obser + "')");
            } catch (Exception e) {
            }
            consql.cierraConexion();
        } catch (Exception e) {
        }
    }

    public String dameIdObser() {
        String idIO = "";
        try {
            consql.conectar();
            try {
                ResultSet rset = consql.consulta("select F_IO from TB_Indice");
                while (rset.next()) {
                    idIO = rset.getString("F_IO");
                    consql.actualizar("update TB_Indice set F_IO = '" + (Integer.parseInt(idIO) + 1) + "' ");
                }
            } catch (Exception e) {
            }
            consql.cierraConexion();
        } catch (Exception e) {
        }
        return idIO;
    }

    public void sumaCompraInventario(String clave, String cant) {
        try {
            consql.conectar();
            try {
                ResultSet rset = consql.consulta("select F_ClaPro, F_Existen, F_Precio from TB_Medica where F_ClaPro = '" + clave + "' ");
                while (rset.next()) {
                    double costo = Double.parseDouble(rset.getString("F_Precio"));
                    String exsiten=rset.getString("F_Existen");
                    int n_cant = Integer.parseInt(cant) + (int)Double.parseDouble(exsiten);
                    double cos_pro = ((costo * n_cant) + (costo * Integer.parseInt(cant))) / (n_cant);
                    consql.actualizar("update TB_Medica set F_Existen = '" + n_cant + "', F_CosPro = '" + cos_pro + "' where F_ClaPro = '" + clave + "' ");
                }
            } catch (Exception e) {
            }
            consql.cierraConexion();
        } catch (Exception e) {
        }
    }

    public void insertaMovimiento(String cladoc, String clapro, String cant, String costo, double cantcosto, String idLote, String observaciones, String codprov) {
        try {
            consql.conectar();
            try {
                consql.insertar("insert into TB_MovInv values (GETDATE(), '" + dame7car(cladoc) + "', '" + codprov + "', '1', '" + clapro + "', '" + cant + "', '" + costo + "', '" + costo + "', '" + cantcosto + "', '1', '" + idLote + "', '" + dameidMov() + "', 'M', '" + observaciones + "') ");
            } catch (Exception e) {
            }
            consql.cierraConexion();
        } catch (Exception e) {
        }
    }

    public String dameidMov() {
        String idMov = "";
        try {
            ResultSet rset = consql.consulta("select F_IM from TB_Indice");
            while (rset.next()) {
                idMov = rset.getString("F_IM");
                consql.actualizar("update TB_Indice set F_IM = '" + (Integer.parseInt(idMov) + 1) + "' ");
            }
        } catch (Exception e) {
        }
        return idMov;
    }

    public String dame7car(String clave) {
        try {
            int largoClave = clave.length();
            int espacios = 7 - largoClave;
            for (int i = 1; i <= espacios; i++) {
                clave = " " + clave;
            }
        } catch (Exception e) {
        }
        return clave;
    }

    public String dame5car(String clave) {
        try {
            int largoClave = clave.length();
            int espacios = 5 - largoClave;
            for (int i = 1; i <= espacios; i++) {
                clave = " " + clave;
            }
        } catch (Exception e) {
        }
        return clave;
    }

    public String idLote(String clave, String lote, String fec_cad, String cant, double costo, String origen, String fec_fab) {
        String idLote = "";
        int exi = 0;
        double cos = 0;
        int ban = 0;
        try {
            consql.conectar();
            try {
                ResultSet rset = consql.consulta("select F_FolLot, F_ExiLot, F_CosLot from TB_Lote where F_ClaPro = '" + clave + "' and F_ClaLot = '" + lote + "' ");
                while (rset.next()) {
                    idLote = rset.getString("F_FolLot");
                    exi = rset.getInt("F_ExiLot");
                    cos = rset.getDouble("F_CosLot");
                    ban = 1;
                }
            } catch (SQLException e) {
            }
            if (ban == 0) {
                ResultSet rset = consql.consulta("select F_IL from TB_Indice ");
                while (rset.next()) {
                    idLote = rset.getString("F_IL");
                    consql.actualizar("update TB_Indice set F_IL = '" + (Integer.parseInt(idLote) + 1) + "' ");
                }
                consql.insertar("insert into TB_Lote values ('" + lote + "', '" + clave + "', '" + fec_cad + "', '" + cant + "', '" + costo + "', '" + idLote + "', '" + origen + "', '0000', '" + fec_fab + "') ");
            } else {
                int texi = exi + Integer.parseInt(cant);
                double totcos = cos + costo;
                consql.actualizar("update TB_Lote set F_ExiLot = '" + texi + "', F_CosLot = '" + totcos + "' where F_FolLot = '" + idLote + "' ");
            }
            consql.cierraConexion();
        } catch (SQLException e) {
        }
        return idLote;
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
