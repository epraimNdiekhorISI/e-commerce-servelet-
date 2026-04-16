<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>EcomPro — ${empty user ? 'Nouvel Utilisateur' : 'Modifier Utilisateur'}</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet"/>
    <style>
        :root { --primary:#6366f1; --slate:#475569; --danger:#ef4444; --dark:#0f172a; --text-muted:#94a3b8; --border:#e2e8f0; --bg:#f8fafc; }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Plus Jakarta Sans',sans-serif; background:var(--bg); display:flex; min-height:100vh; }
        .sidebar { width:260px; background:#0f172a; min-height:100vh; position:fixed; top:0; left:0; display:flex; flex-direction:column; z-index:100; }
        .sidebar-brand { padding:28px 24px; border-bottom:1px solid #1e293b; }
        .sidebar-brand h1 { font-family:'Space Grotesk',sans-serif; font-size:1.4rem; font-weight:700; color:white; }
        .sidebar-brand h1 span { color:var(--primary); }
        .sidebar-brand p { font-size:0.7rem; color:var(--text-muted); text-transform:uppercase; letter-spacing:1px; margin-top:3px; }
        .sidebar-nav { padding:20px 12px; flex:1; }
        .nav-section-title { font-size:0.65rem; text-transform:uppercase; letter-spacing:1.5px; color:var(--text-muted); padding:12px 12px 8px; font-weight:600; }
        .nav-link { display:flex; align-items:center; gap:12px; padding:10px 14px; border-radius:8px; color:#94a3b8; text-decoration:none; font-size:0.875rem; font-weight:500; transition:all 0.2s; margin-bottom:2px; }
        .nav-link:hover { background:#1e293b; color:white; }
        .nav-link.active { background:var(--primary); color:white; }
        .nav-link i { width:18px; text-align:center; }
        .sidebar-user { padding:16px; border-top:1px solid #1e293b; display:flex; align-items:center; gap:12px; }
        .user-avatar { width:38px; height:38px; background:var(--primary); border-radius:10px; display:flex; align-items:center; justify-content:center; color:white; font-weight:700; font-size:0.85rem; }
        .user-info p { font-size:0.8rem; color:white; font-weight:600; }
        .user-info span { font-size:0.7rem; color:var(--text-muted); }
        .btn-logout { margin-left:auto; background:none; border:none; color:var(--text-muted); cursor:pointer; font-size:1rem; text-decoration:none; transition:color 0.2s; }
        .btn-logout:hover { color:var(--danger); }
        .main-content { margin-left:260px; flex:1; display:flex; flex-direction:column; }
        .topbar { background:white; border-bottom:1px solid var(--border); padding:16px 32px; display:flex; align-items:center; position:sticky; top:0; z-index:50; }
        .topbar h2 { font-size:1.1rem; font-weight:700; color:var(--dark); }
        .topbar p { font-size:0.78rem; color:var(--text-muted); margin-top:1px; }
        .page-content { padding:28px 32px; }
        .form-card { background:white; border-radius:14px; border:1px solid var(--border); padding:32px; max-width:580px; }
        .form-card h3 { font-size:1rem; font-weight:700; color:var(--dark); margin-bottom:24px; padding-bottom:16px; border-bottom:1px solid var(--border); }
        .form-label { font-size:0.82rem; font-weight:600; color:#374151; margin-bottom:6px; display:block; }
        .input-wrapper { position:relative; }
        .input-wrapper i { position:absolute; left:14px; top:50%; transform:translateY(-50%); color:#94a3b8; font-size:0.85rem; }
        .form-control { width:100%; padding:10px 14px 10px 38px; border:1.5px solid var(--border); border-radius:9px; font-size:0.875rem; font-family:'Plus Jakarta Sans',sans-serif; transition:all 0.2s; outline:none; color:var(--dark); }
        .form-control:focus { border-color:var(--slate); box-shadow:0 0 0 3px rgba(71,85,105,0.1); }
        .form-actions { display:flex; gap:12px; margin-top:28px; padding-top:24px; border-top:1px solid var(--border); }
        .btn-save { background:var(--slate); color:white; border:none; padding:10px 24px; border-radius:8px; font-size:0.875rem; font-weight:600; cursor:pointer; display:inline-flex; align-items:center; gap:8px; transition:all 0.2s; font-family:'Plus Jakarta Sans',sans-serif; }
        .btn-save:hover { background:#334155; box-shadow:0 4px 12px rgba(71,85,105,0.3); }
        .btn-cancel { background:white; color:#374151; border:1.5px solid var(--border); padding:10px 20px; border-radius:8px; font-size:0.875rem; font-weight:600; cursor:pointer; display:inline-flex; align-items:center; gap:8px; text-decoration:none; transition:all 0.2s; }
        .btn-cancel:hover { background:var(--bg); }
        .breadcrumb-nav { display:flex; align-items:center; gap:8px; font-size:0.82rem; color:var(--text-muted); margin-bottom:20px; }
        .breadcrumb-nav a { color:var(--slate); text-decoration:none; }
        .info-box { background:#f8fafc; border:1px solid var(--border); border-radius:8px; padding:12px 16px; font-size:0.82rem; color:#64748b; margin-bottom:20px; display:flex; align-items:center; gap:8px; }
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-brand">
        <h1>Ecom<span>Pro</span></h1>
        <p>Gestion commerciale</p>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section-title">Principal</div>
        <a href="${pageContext.request.contextPath}/produits" class="nav-link"><i class="fa-solid fa-box"></i> Produits</a>
        <a href="${pageContext.request.contextPath}/achats" class="nav-link"><i class="fa-solid fa-cart-shopping"></i> Achats</a>
        <a href="${pageContext.request.contextPath}/ventes" class="nav-link"><i class="fa-solid fa-chart-line"></i> Ventes</a>
        <div class="nav-section-title" style="margin-top:16px;">Administration</div>
        <a href="${pageContext.request.contextPath}/users" class="nav-link active"><i class="fa-solid fa-users"></i> Utilisateurs</a>
    </nav>
    <div class="sidebar-user">
        <div class="user-avatar">${not empty userConnecte ? userConnecte.email.substring(0,1).toUpperCase() : 'U'}</div>
        <div class="user-info">
            <p>${not empty userConnecte ? userConnecte.email : 'Utilisateur'}</p>
            <span>Administrateur</span>
        </div>
        <a href="${pageContext.request.contextPath}/auth" class="btn-logout"><i class="fa-solid fa-right-from-bracket"></i></a>
    </div>
</aside>

<div class="main-content">
    <div class="topbar">
        <div>
            <h2><i class="fa-solid fa-users" style="color:#475569;margin-right:8px;"></i>
                ${empty user ? 'Nouvel Utilisateur' : 'Modifier Utilisateur'}</h2>
            <p>${empty user ? 'Créer un nouveau compte utilisateur' : 'Modifier les informations du compte'}</p>
        </div>
    </div>

    <div class="page-content">
        <div class="breadcrumb-nav">
            <a href="${pageContext.request.contextPath}/users"><i class="fa-solid fa-users"></i> Utilisateurs</a>
            <i class="fa-solid fa-chevron-right" style="font-size:0.7rem;"></i>
            <span>${empty user ? 'Nouveau' : 'Modifier'}</span>
        </div>

        <div class="form-card">
            <h3><i class="fa-solid fa-user-gear" style="color:#475569;margin-right:8px;"></i>
                Informations du compte</h3>

            <c:if test="${not empty user}">
                <div class="info-box">
                    <i class="fa-solid fa-circle-info" style="color:#6366f1;"></i>
                    Le mot de passe ne peut être modifié que depuis la page de connexion
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/users" method="post">
                <c:if test="${not empty user}">
                    <input type="hidden" name="id" value="${user.id}"/>
                    <input type="hidden" name="action" value="update"/>
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Adresse email</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-envelope"></i>
                        <input type="email" name="email" class="form-control"
                               placeholder="utilisateur@email.com" value="${user.email}" required/>
                    </div>
                </div>

                <c:if test="${empty user}">
                    <div class="mb-3">
                        <label class="form-label">Mot de passe</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-lock"></i>
                            <input type="password" name="password" class="form-control"
                                   placeholder="Minimum 6 caractères" required/>
                        </div>
                    </div>
                </c:if>

                <div class="form-actions">
                    <button type="submit" class="btn-save">
                        <i class="fa-solid fa-floppy-disk"></i>
                        ${empty user ? 'Créer le compte' : 'Enregistrer les modifications'}
                    </button>
                    <a href="${pageContext.request.contextPath}/users" class="btn-cancel">
                        <i class="fa-solid fa-xmark"></i> Annuler
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>