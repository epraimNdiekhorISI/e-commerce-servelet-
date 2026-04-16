<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcomPro — ${pageTitle}</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&family=Space+Grotesk:wght@400;500;600&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --sidebar-width: 260px;
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --primary-light: #e0e7ff;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --dark: #0f172a;
            --dark-2: #1e293b;
            --dark-3: #334155;
            --text-muted: #94a3b8;
            --border: #e2e8f0;
            --bg: #f8fafc;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--bg);
            color: var(--dark);
            display: flex;
            min-height: 100vh;
        }

        /* ===== SIDEBAR ===== */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--dark);
            min-height: 100vh;
            position: fixed;
            top: 0; left: 0;
            display: flex;
            flex-direction: column;
            z-index: 100;
            transition: all 0.3s ease;
        }

        .sidebar-brand {
            padding: 28px 24px;
            border-bottom: 1px solid var(--dark-3);
        }

        .sidebar-brand h1 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.4rem;
            font-weight: 600;
            color: white;
            letter-spacing: -0.5px;
        }

        .sidebar-brand h1 span {
            color: var(--primary);
        }

        .sidebar-brand p {
            font-size: 0.72rem;
            color: var(--text-muted);
            margin-top: 3px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .sidebar-nav {
            padding: 20px 12px;
            flex: 1;
        }

        .nav-section-title {
            font-size: 0.65rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--text-muted);
            padding: 12px 12px 8px;
            font-weight: 600;
        }

        .nav-item { margin-bottom: 2px; }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 14px;
            border-radius: 8px;
            color: #94a3b8;
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .nav-link:hover {
            background: var(--dark-2);
            color: white;
        }

        .nav-link.active {
            background: var(--primary);
            color: white;
        }

        .nav-link i {
            width: 18px;
            text-align: center;
            font-size: 0.9rem;
        }

        .nav-link .badge-count {
            margin-left: auto;
            background: var(--dark-3);
            color: var(--text-muted);
            font-size: 0.7rem;
            padding: 2px 7px;
            border-radius: 20px;
        }

        .nav-link.active .badge-count {
            background: rgba(255,255,255,0.2);
            color: white;
        }

        /* User card in sidebar */
        .sidebar-user {
            padding: 16px;
            border-top: 1px solid var(--dark-3);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 38px; height: 38px;
            background: var(--primary);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 0.85rem;
        }

        .user-info p { font-size: 0.8rem; color: white; font-weight: 600; }
        .user-info span { font-size: 0.7rem; color: var(--text-muted); }

        .btn-logout {
            margin-left: auto;
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            font-size: 1rem;
            transition: color 0.2s;
        }
        .btn-logout:hover { color: var(--danger); }

        /* ===== MAIN CONTENT ===== */
        .main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        /* ===== TOP BAR ===== */
        .topbar {
            background: white;
            border-bottom: 1px solid var(--border);
            padding: 16px 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .topbar-title h2 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--dark);
        }

        .topbar-title p {
            font-size: 0.78rem;
            color: var(--text-muted);
            margin-top: 1px;
        }

        .topbar-actions { display: flex; align-items: center; gap: 12px; }

        /* ===== PAGE CONTENT ===== */
        .page-content { padding: 28px 32px; flex: 1; }

        /* ===== STATS CARDS ===== */
        .stat-card {
            background: white;
            border-radius: 14px;
            padding: 22px 24px;
            border: 1px solid var(--border);
            transition: all 0.2s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0; right: 0;
            width: 80px; height: 80px;
            border-radius: 50%;
            opacity: 0.08;
            transform: translate(20px, -20px);
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .stat-card .icon {
            width: 44px; height: 44px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            margin-bottom: 14px;
        }

        .stat-card .value {
            font-size: 1.7rem;
            font-weight: 700;
            color: var(--dark);
            line-height: 1;
        }

        .stat-card .label {
            font-size: 0.78rem;
            color: var(--text-muted);
            margin-top: 4px;
            font-weight: 500;
        }

        /* ===== DATA TABLE ===== */
        .data-card {
            background: white;
            border-radius: 14px;
            border: 1px solid var(--border);
            overflow: hidden;
        }

        .data-card-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .data-card-header h3 {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--dark);
        }

        .data-card-header p {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-top: 2px;
        }

        .table { margin: 0; }

        .table thead th {
            background: #f8fafc;
            color: var(--text-muted);
            font-size: 0.72rem;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            font-weight: 600;
            padding: 12px 20px;
            border-bottom: 1px solid var(--border);
            border-top: none;
        }

        .table tbody td {
            padding: 14px 20px;
            font-size: 0.875rem;
            color: var(--dark);
            vertical-align: middle;
            border-color: var(--border);
        }

        .table tbody tr:hover { background: #fafbff; }
        .table tbody tr:last-child td { border-bottom: none; }

        /* ===== BADGES ===== */
        .badge-stock {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .badge-stock.high { background: #d1fae5; color: #065f46; }
        .badge-stock.medium { background: #fef3c7; color: #92400e; }
        .badge-stock.low { background: #fee2e2; color: #991b1b; }

        /* ===== BUTTONS ===== */
        .btn-primary-custom {
            background: var(--primary);
            color: white;
            border: none;
            padding: 9px 18px;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-primary-custom:hover {
            background: var(--primary-dark);
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(99,102,241,0.3);
        }

        .btn-icon {
            width: 32px; height: 32px;
            border-radius: 7px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            text-decoration: none;
            transition: all 0.2s ease;
            border: none;
            cursor: pointer;
        }

        .btn-icon.edit { background: #e0e7ff; color: var(--primary); }
        .btn-icon.edit:hover { background: var(--primary); color: white; }
        .btn-icon.delete { background: #fee2e2; color: var(--danger); }
        .btn-icon.delete:hover { background: var(--danger); color: white; }

        /* ===== FORM STYLES ===== */
        .form-card {
            background: white;
            border-radius: 14px;
            border: 1px solid var(--border);
            padding: 32px;
            max-width: 600px;
        }

        .form-label {
            font-size: 0.82rem;
            font-weight: 600;
            color: var(--dark-3);
            margin-bottom: 6px;
        }

        .form-control, .form-select {
            border: 1.5px solid var(--border);
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 0.875rem;
            transition: all 0.2s ease;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.1);
            outline: none;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 28px;
            padding-top: 24px;
            border-top: 1px solid var(--border);
        }

        .btn-cancel {
            background: white;
            color: var(--dark-3);
            border: 1.5px solid var(--border);
            padding: 9px 18px;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            background: var(--bg);
            color: var(--dark);
        }

        /* ===== ALERTS ===== */
        .alert-custom {
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .alert-danger-custom { background: #fee2e2; color: #991b1b; }
        .alert-success-custom { background: #d1fae5; color: #065f46; }

        /* ===== EMPTY STATE ===== */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }

        .empty-state i { font-size: 2.5rem; margin-bottom: 16px; opacity: 0.4; }
        .empty-state p { font-size: 0.9rem; }
    </style>
</head>
<body>

<!-- ===== SIDEBAR ===== -->
<aside class="sidebar">
    <div class="sidebar-brand">
        <h1>Ecom<span>Pro</span></h1>
        <p>Gestion commerciale</p>
    </div>

    <nav class="sidebar-nav">
        <div class="nav-section-title">Principal</div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/produits"
               class="nav-link ${currentPage == 'produits' ? 'active' : ''}">
                <i class="fa-solid fa-box"></i> Produits
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/achats"
               class="nav-link ${currentPage == 'achats' ? 'active' : ''}">
                <i class="fa-solid fa-cart-shopping"></i> Achats
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/ventes"
               class="nav-link ${currentPage == 'ventes' ? 'active' : ''}">
                <i class="fa-solid fa-chart-line"></i> Ventes
            </a>
        </div>

        <div class="nav-section-title" style="margin-top:16px;">Administration</div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/users"
               class="nav-link ${currentPage == 'users' ? 'active' : ''}">
                <i class="fa-solid fa-users"></i> Utilisateurs
            </a>
        </div>
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

<!-- ===== MAIN CONTENT ===== -->
<div class="main-content">
    <div class="topbar">
        <div class="topbar-title">
            <h2>${pageTitle}</h2>
            <p>${pageSubtitle}</p>
        </div>
        <div class="topbar-actions">
            <jsp:include page="${topbarAction}"/>
        </div>
    </div>
    <div class="page-content">
        <jsp:include page="${pageContent}"/>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>