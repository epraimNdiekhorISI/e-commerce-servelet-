package com.groupeisi.company.servlet;

import com.groupeisi.company.dto.AchatsDto;
import com.groupeisi.company.dto.ProduitsDto;
import com.groupeisi.company.service.AchatsService;
import com.groupeisi.company.service.ProduitsService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.List;

public class AchatsServlet extends HttpServlet {

    private AchatsService achatsService = new AchatsService();
    private ProduitsService produitsService = new ProduitsService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                List<AchatsDto> achats = achatsService.findAll();
                req.setAttribute("achats", achats);
                req.getRequestDispatcher("/WEB-INF/views/achats/list.jsp")
                        .forward(req, resp);
                break;

            case "form":
                // On passe la liste des produits pour le select
                List<ProduitsDto> produits = produitsService.findAll();
                req.setAttribute("produits", produits);
                String id = req.getParameter("id");
                if (id != null) {
                    AchatsDto achat = achatsService.findById(Long.parseLong(id));
                    req.setAttribute("achat", achat);
                }
                req.getRequestDispatcher("/WEB-INF/views/achats/form.jsp")
                        .forward(req, resp);
                break;

            case "delete":
                achatsService.delete(Long.parseLong(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/achats?action=list");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/achats?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String idParam = req.getParameter("id");

        // Récupère le user connecté depuis la session
        HttpSession session = req.getSession();
        com.groupeisi.company.entities.Users userConnecte =
                (com.groupeisi.company.entities.Users) session.getAttribute("userConnecte");

        AchatsDto dto = new AchatsDto();
        dto.setDateP(new Date());
        dto.setQuantity(Double.parseDouble(req.getParameter("quantity")));
        dto.setProduitId(Long.parseLong(req.getParameter("produitId")));
        dto.setUserId(userConnecte.getId());

        if ("update".equals(action) && idParam != null) {
            dto.setId(Long.parseLong(idParam));
            achatsService.update(dto);
        } else {
            achatsService.save(dto);
        }
        resp.sendRedirect(req.getContextPath() + "/achats?action=list");
    }
}