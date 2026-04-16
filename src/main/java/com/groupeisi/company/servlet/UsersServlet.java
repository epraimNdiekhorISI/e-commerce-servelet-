package com.groupeisi.company.servlet;

import com.groupeisi.company.dto.UsersDto;
import com.groupeisi.company.service.UsersService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

public class UsersServlet extends HttpServlet {

    private static final Logger log = LoggerFactory.getLogger(UsersServlet.class);
    private UsersService usersService = new UsersService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                // 📋 Liste tous les users
                List<UsersDto> users = usersService.findAll();
                req.setAttribute("users", users);
                req.getRequestDispatcher("/WEB-INF/views/users/list.jsp")
                        .forward(req, resp);
                break;

            case "form":
                // ➕ Formulaire de création
                String id = req.getParameter("id");
                if (id != null) {
                    // ✏️ Mode édition — on charge le user existant
                    UsersDto user = usersService.findById(Long.parseLong(id));
                    req.setAttribute("user", user);
                }
                req.getRequestDispatcher("/WEB-INF/views/users/form.jsp")
                        .forward(req, resp);
                break;

            case "delete":
                // 🗑️ Supprimer
                Long deleteId = Long.parseLong(req.getParameter("id"));
                usersService.delete(deleteId);
                resp.sendRedirect(req.getContextPath() + "/users?action=list");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/users?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String idParam = req.getParameter("id");

        UsersDto usersDto = new UsersDto();
        usersDto.setEmail(email);

        if ("update".equals(action) && idParam != null) {
            // Mise à jour
            usersDto.setId(Long.parseLong(idParam));
            usersService.update(usersDto);
        } else {
            // Création — le password est nécessaire
            // On passe par l'entité directement pour inclure le password
            com.groupeisi.company.entities.Users newUser =
                    new com.groupeisi.company.entities.Users();
            newUser.setEmail(email);
            newUser.setPassword(password);
            usersService.saveWithPassword(newUser);
        }
        resp.sendRedirect(req.getContextPath() + "/users?action=list");
    }
}