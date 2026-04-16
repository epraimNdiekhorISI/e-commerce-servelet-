package com.groupeisi.company.servlet;

import com.groupeisi.company.dto.ProduitsDto;
import com.groupeisi.company.dto.VentesDto;
import com.groupeisi.company.service.ProduitsService;
import com.groupeisi.company.service.VentesService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.List;

public class VentesServlet extends HttpServlet {

    private VentesService ventesService = new VentesService();
    private ProduitsService produitsService = new ProduitsService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                List<VentesDto> ventes = ventesService.findAll();
                req.setAttribute("ventes", ventes);
                req.getRequestDispatcher("/WEB-INF/views/ventes/list.jsp")
                        .forward(req, resp);
                break;

            case "form":
                List<ProduitsDto> produits = produitsService.findAll();
                req.setAttribute("produits", produits);
                String id = req.getParameter("id");
                if (id != null) {
                    VentesDto vente = ventesService.findById(Long.parseLong(id));
                    req.setAttribute("vente", vente);
                }
                req.getRequestDispatcher("/WEB-INF/views/ventes/form.jsp")
                        .forward(req, resp);
                break;

            case "delete":
                ventesService.delete(Long.parseLong(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/ventes?action=list");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/ventes?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String idParam = req.getParameter("id");

        HttpSession session = req.getSession();
        com.groupeisi.company.entities.Users userConnecte =
                (com.groupeisi.company.entities.Users) session.getAttribute("userConnecte");

        VentesDto dto = new VentesDto();
        dto.setDateP(new Date());
        dto.setQuantity(Double.parseDouble(req.getParameter("quantity")));
        dto.setProduitId(Long.parseLong(req.getParameter("produitId")));
        dto.setUserId(userConnecte.getId());

        if ("update".equals(action) && idParam != null) {
            dto.setId(Long.parseLong(idParam));
            ventesService.update(dto);
        } else {
            ventesService.save(dto);
        }
        resp.sendRedirect(req.getContextPath() + "/ventes?action=list");
    }
}