package com.groupeisi.company.servlet;

import com.groupeisi.company.entities.Users;
import com.groupeisi.company.service.UsersService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class AuthServlet extends HttpServlet {

    private static final Logger log = LoggerFactory.getLogger(AuthServlet.class);
    private UsersService usersService = new UsersService();

    // GET → affiche le formulaire login/inscription
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                .forward(req, resp);
    }

    // POST → login OU inscription selon l'action
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("register".equals(action)) {
            handleRegister(req, resp);
        } else {
            handleLogin(req, resp);
        }
    }

    // 🔐 Gestion de la CONNEXION
    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Users user = usersService.authenticate(email, password);

        if (user != null) {
            // ✅ Connexion réussie → session
            HttpSession session = req.getSession();
            session.setAttribute("userConnecte", user);
            log.info("Connexion réussie : {}", email);
            resp.sendRedirect(req.getContextPath() + "/produits");
        } else {
            // ❌ Échec connexion
            req.setAttribute("erreurLogin", "Email ou mot de passe incorrect");
            log.warn("Connexion échouée : {}", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                    .forward(req, resp);
        }
    }

    // 📝 Gestion de l'INSCRIPTION
    private void handleRegister(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // Règle 1 : les mots de passe doivent correspondre
        if (!password.equals(confirmPassword)) {
            req.setAttribute("erreurRegister", "Les mots de passe ne correspondent pas");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                    .forward(req, resp);
            return;
        }

        // Règle 2 : mot de passe minimum 6 caractères
        if (password.length() < 6) {
            req.setAttribute("erreurRegister", "Le mot de passe doit contenir au moins 6 caractères");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                    .forward(req, resp);
            return;
        }

        // Création du nouvel utilisateur
        Users newUser = new Users();
        newUser.setEmail(email);
        newUser.setPassword(password);

        Users saved = usersService.saveWithPassword(newUser);

        if (saved != null) {
            // ✅ Inscription réussie
            req.setAttribute("succes", "Compte créé avec succès ! Vous pouvez vous connecter.");
            log.info("Nouvel utilisateur inscrit : {}", email);
        } else {
            // ❌ Email déjà utilisé
            req.setAttribute("erreurRegister", "Cet email est déjà utilisé");
            log.warn("Tentative d'inscription avec email existant : {}", email);
        }

        req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                .forward(req, resp);
    }
}