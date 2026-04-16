package com.groupeisi.company.servlet;

import com.groupeisi.company.dto.ProduitsDto;
import com.groupeisi.company.service.ProduitsService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ProduitsServlet extends HttpServlet {

    private ProduitsService produitsService = new ProduitsService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                List<ProduitsDto> produits = produitsService.findAll();
                req.setAttribute("produits", produits);
                req.getRequestDispatcher("/WEB-INF/views/produits/list.jsp")
                        .forward(req, resp);
                break;

            case "form":
                String id = req.getParameter("id");
                if (id != null) {
                    ProduitsDto produit = produitsService.findById(Long.parseLong(id));
                    req.setAttribute("produit", produit);
                }
                req.getRequestDispatcher("/WEB-INF/views/produits/form.jsp")
                        .forward(req, resp);
                break;

            case "delete":
                produitsService.delete(Long.parseLong(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/produits?action=list");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/produits?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String idParam = req.getParameter("id");

        ProduitsDto dto = new ProduitsDto();
        dto.setRef(req.getParameter("ref"));
        dto.setName(req.getParameter("name"));
        dto.setStock(Double.parseDouble(req.getParameter("stock")));
        dto.setUserId(Long.parseLong(req.getParameter("userId")));

        if ("update".equals(action) && idParam != null) {
            dto.setId(Long.parseLong(idParam));
            produitsService.update(dto);
        } else {
            produitsService.save(dto);
        }
        resp.sendRedirect(req.getContextPath() + "/produits?action=list");
    }
}