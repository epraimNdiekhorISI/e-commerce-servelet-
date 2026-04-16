<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>EcomPro — Produits</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --primary: #6366f1; --primary-dark: #4f46e5;
            --success: #10b981; --warning: #f59e0b;
            --danger: #ef4444; --dark: #0f172a;
            --text-muted: #94a3b8; --border: #e2e8f0; --bg: #f8fafc;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--bg); display: flex; min-height: 100vh; }

        /* SIDEBAR */
        .sidebar { width: 260px; background: #0f172a; min-height: 100vh; position: fixed;
                   top: 0; left: 0; display: flex; flex-direction: column; z-index: 100; }
        .sidebar-brand { padding: 28px 24px; border-bottom: 1px solid #1e293b; }
        .sidebar-brand h1 { font-family: 'Space Grotesk', sans-serif; font-size: 1.4rem;
                            font-weight: 700; color: white; }
        .sidebar-brand h1 span { color: var(--primary); }
        .sidebar-brand p { font-size: 0.7rem; color: var(--text-muted);
                           text-transform: uppercase; letter-spacing: 1px; margin-top: 3px; }
        .sidebar-nav { padding: 20px 12px; flex: 1; }
        .nav-section-title { font-size: 0.65rem; text-transform: uppercase; letter-spacing: 1.5px;
                             color: var(--text-muted); padding: 12px 12px 8px; font-weight: 600; }
        .nav-link { display: flex; align-items: center; gap: 12px; padding: 10px 14px;
                    border-radius: 8px; color: #94a3b8; text-decoration: none;
                    font-size: 0.875rem; font-weight: 500; transition: all 0.2s; margin-bottom: 2px; }
        .nav-link:hover { background: #1e293b; color: white; }
        .nav-link.active { background: var(--primary); color: white; }
        .nav-link i { width: 18px; text-align: center; }
        .sidebar-user { padding: 16px; border-top: 1px solid #1e293b;
                        display: flex; align-items: center; gap: 12px; }
        .user-avatar { width: 38px; height: 38px; background: var(--primary); border-radius: 10px;
                       display: flex; align-items: center; justify-content: center;
                       color: white; font-weight: 700; font-size: 0.85rem; flex-shrink: 0; }
        .user-info p { font-size: 0.8rem; color: white; font-weight: 600; }
        .user-info span { font-size: 0.7rem; color: var(--text-muted); }
        .btn-logout { margin-left: auto; background: none; border: none;
                      color: var(--text-muted); cursor: pointer; font-size: 1rem;
                      text-decoration: none; transition: color 0.2s; }
        .btn-logout:hover { color: var(--danger); }

        /* MAIN */
        .main-content { margin-left: 260px; flex: 1; display: flex; flex-direction: column; }
        .topbar { background: white; border-bottom: 1px solid var(--border);
                  padding: 16px 32px; display: flex; align-items: center;
                  justify-content: space-between; position: sticky; top: 0; z-index: 50; }
        .topbar h2 { font-size: 1.1rem; font-weight: 700; color: var(--dark); }
        .topbar p { font-size: 0.78rem; color: var(--text-muted); margin-top: 1px; }
        .page-content { padding: 28px 32px; }

        /* STAT CARDS */
        .stat-card { background: white; border-radius: 14px; padding: 22px 24px;
                     border: 1px solid var(--border); transition: all 0.2s; }
        .stat-card:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(0,0,0,0.08); }
        .stat-card .icon { width: 44px; height: 44px; border-radius: 10px;
                           display: flex; align-items: center; justify-content: center;
                           font-size: 1.1rem; margin-bottom: 14px; }
        .stat-card .value { font-size: 1.7rem; font-weight: 700; color: var(--dark); line-height: 1; }
        .stat-card .label { font-size: 0.78rem; color: var(--text-muted); margin-top: 4px; font-weight: 500; }

        /* DATA CARD */
        .data-card { background: white; border-radius: 14px; border: 1px solid var(--border); overflow: hidden; }
        .data-card-header { padding: 20px 24px; border-bottom: 1px solid var(--border);
                            display: flex; align-items: center; justify-content: space-between; }
        .data-card-header h3 { font-size: 0.95rem; font-weight: 700; color: var(--dark); }
        .data-card-header p { font-size: 0.75rem; color: var(--text-muted); margin-top: 2px; }

        /* TABLE */
        .table { margin: 0; }
        .table thead th { background: #f8fafc; color: var(--text-muted); font-size: 0.72rem;
                          text-transform: uppercase; letter-spacing: 0.8px; font-weight: 600;
                          padding: 12px 20px; border-bottom: 1px solid var(--border); border-top: none; }
        .table tbody td { padding: 14px 20px; font-size: 0.875rem; color: var(--dark);
                          vertical-align: middle; border-color: var(--border); }
        .table tbody tr:hover { background: #fafbff; }
        .table tbody tr:last-child td { border-bottom: none; }

        /* BADGES */
        .badge-stock { padding: 4px 10px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; }
        .badge-high { background: #d1fae5; color: #065f46; }
        .badge-medium { background: #fef3c7; color: #92400e; }
        .badge-low { background: #fee2e2; color: #991b1b; }

        /* BUTTONS */
        .btn-primary-custom { background: var(--primary); color: white; border: none;
                              padding: 9px 18px; border-radius: 8px; font-size: 0.85rem;
                              font-weight: 600; cursor: pointer; display: inline-flex;
                              align-items: center; gap: 7px; text-decoration: none; transition: all 0.2s; }
        .btn-primary-custom:hover { background: var(--primary-dark); color: white;
                                    box-shadow: 0 4px 12px rgba(99,102,241,0.3); }
        .btn-icon { width: 32px; height: 32px; border-radius: 7px; display: inline-flex;
                    align-items: center; justify-content: center; font-size: 0.8rem;
                    text-decoration: none; transition: all 0.2s; border: none; cursor: pointer; }
        .btn-icon.edit { background: #e0e7ff; color: var(--primary); }
        .btn-icon.edit:hover { background: var(--primary); color: white; }
        .btn-icon.delete { background: #fee2e2; color: var(--danger); }
        .btn-icon.delete:hover { background: var(--danger); color: white; }

        .empty-state { text-align: center; padding: 60px 20px; color: var(--text-muted); }
        .empty-state i { font-size: 2.5rem; margin-bottom: 16px; opacity: 0.4; display: block; }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-brand">
        <h1>Ecom<span>Pro</span></h1>
        <p>Gestion commerciale</p>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section-title">Principal</div>
        <a href="${pageContext.request.contextPath}/produits" class="nav-link active">
            <i class="fa-solid fa-box"></i> Produits
        </a>
        <a href="${pageContext.request.contextPath}/achats" class="nav-link">
            <i class="fa-solid fa-cart-shopping"></i> Achats
        </a>
        <a href="${pageContext.request.contextPath}/ventes" class="nav-link">
            <i class="fa-solid fa-chart-line"></i> Ventes
        </a>
        <div class="nav-section-title" style="margin-top:16px;">Administration</div>
        <a href="${pageContext.request.contextPath}/users" class="nav-link">
            <i class="fa-solid fa-users"></i> Utilisateurs
        </a>
    </nav>
    <div class="sidebar-user">
        <div class="user-avatar">
            ${not empty userConnecte ? userConnecte.email.substring(0,1).toUpperCase() : 'U'}
        </div>
        <div class="user-info">
            <p>${not empty userConnecte ? userConnecte.email : 'Utilisateur'}</p>
            <span>Administrateur</span>
        </div>
        <a href="${pageContext.request.contextPath}/auth" class="btn-logout" title="Déconnexion">
            <i class="fa-solid fa-right-from-bracket"></i>
        </a>
    </div>
</aside>

<!-- MAIN -->
<div class="main-content">
    <div class="topbar">
        <div>
            <h2><i class="fa-solid fa-box" style="color:var(--primary);margin-right:8px;"></i>Produits</h2>
            <p>Gérez votre catalogue de produits et stocks</p>
        </div>
        <a href="${pageContext.request.contextPath}/produits?action=form" class="btn-primary-custom">
            <i class="fa-solid fa-plus"></i> Nouveau produit
        </a>
    </div>

    <div class="page-content">

        <!-- Stats -->
        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="icon" style="background:#e0e7ff;color:#6366f1;">
                        <i class="fa-solid fa-box"></i>
                    </div>
                    <div class="value">${produits.size()}</div>
                    <div class="label">Total produits</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="icon" style="background:#d1fae5;color:#10b981;">
                        <i class="fa-solid fa-circle-check"></i>
                    </div>
                    <div class="value">
                        <c:set var="enStock" value="0"/>
                        <c:forEach items="${produits}" var="p">
                            <c:if test="${p.stock > 10}"><c:set var="enStock" value="${enStock + 1}"/></c:if>
                        </c:forEach>
                        ${enStock}
                    </div>
                    <div class="label">En stock (> 10)</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="icon" style="background:#fef3c7;color:#f59e0b;">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                    </div>
                    <div class="value">
                        <c:set var="stockFaible" value="0"/>
                        <c:forEach items="${produits}" var="p">
                            <c:if test="${p.stock > 0 && p.stock <= 10}">
                                <c:set var="stockFaible" value="${stockFaible + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${stockFaible}
                    </div>
                    <div class="label">Stock faible (≤ 10)</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="icon" style="background:#fee2e2;color:#ef4444;">
                        <i class="fa-solid fa-ban"></i>
                    </div>
                    <div class="value">
                        <c:set var="rupture" value="0"/>
                        <c:forEach items="${produits}" var="p">
                            <c:if test="${p.stock <= 0}"><c:set var="rupture" value="${rupture + 1}"/></c:if>
                        </c:forEach>
                        ${rupture}
                    </div>
                    <div class="label">Rupture de stock</div>
                </div>
            </div>
        </div>

        <!-- Table -->
        <div class="data-card">
            <div class="data-card-header">
                <div>
                    <h3>Catalogue produits</h3>
                    <p>${produits.size()} produit(s) enregistré(s)</p>
                </div>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>#</th><th>Référence</th><th>Nom</th>
                        <th>Stock</th><th>Responsable</th><th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty produits}">
                            <tr><td colspan="6">
                                <div class="empty-state">
                                    <i class="fa-solid fa-box-open"></i>
                                    <p>Aucun produit enregistré</p>
                                </div>
                            </td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${produits}" var="p">
                                <tr>
                                    <td style="color:#94a3b8;font-size:0.8rem;">#${p.id}</td>
                                    <td>
                                        <span style="font-family:monospace;background:#f1f5f9;
                                              padding:3px 8px;border-radius:5px;font-size:0.82rem;color:#475569;">
                                            ${p.ref}
                                        </span>
                                    </td>
                                    <td style="font-weight:600;">${p.name}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.stock > 10}">
                                                <span class="badge-stock badge-high">${p.stock} unités</span>
                                            </c:when>
                                            <c:when test="${p.stock > 0}">
                                                <span class="badge-stock badge-medium">${p.stock} unités</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-stock badge-low">Rupture</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="color:#64748b;font-size:0.85rem;">${p.userEmail}</td>
                                    <td>
                                        <div style="display:flex;gap:6px;">
                                            <a href="${pageContext.request.contextPath}/produits?action=form&id=${p.id}"
                                               class="btn-icon edit" title="Modifier">
                                                <i class="fa-solid fa-pen"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/produits?action=delete&id=${p.id}"
                                               class="btn-icon delete" title="Supprimer"
                                               onclick="return confirm('Supprimer ce produit ?')">
                                                <i class="fa-solid fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>