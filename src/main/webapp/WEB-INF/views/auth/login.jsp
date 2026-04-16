<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>EcomPro — Connexion</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --dark: #0f172a;
            --dark-2: #1e293b;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            min-height: 100vh;
            display: flex;
            background: #0f172a;
        }

        /* Panneau gauche décoratif */
        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, #1e1b4b 0%, #312e81 50%, #4c1d95 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px;
            position: relative;
            overflow: hidden;
        }

        .left-panel::before {
            content: '';
            position: absolute;
            width: 400px; height: 400px;
            background: rgba(99,102,241,0.2);
            border-radius: 50%;
            top: -100px; right: -100px;
        }

        .left-panel::after {
            content: '';
            position: absolute;
            width: 300px; height: 300px;
            background: rgba(139,92,246,0.15);
            border-radius: 50%;
            bottom: -80px; left: -80px;
        }

        .left-content { position: relative; z-index: 1; text-align: center; }

        .brand-logo {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
            letter-spacing: -1px;
            margin-bottom: 16px;
        }

        .brand-logo span { color: #a5b4fc; }

        .brand-desc {
            color: #a5b4fc;
            font-size: 1rem;
            line-height: 1.6;
            max-width: 320px;
        }

        .features {
            margin-top: 48px;
            display: flex;
            flex-direction: column;
            gap: 16px;
            text-align: left;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #c7d2fe;
            font-size: 0.9rem;
        }

        .feature-item i {
            width: 32px; height: 32px;
            background: rgba(99,102,241,0.3);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
            flex-shrink: 0;
        }

        /* Panneau droit — formulaires */
        .right-panel {
            width: 520px;
            background: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 60px 52px;
            overflow-y: auto;
        }

        .form-header { margin-bottom: 32px; }

        .form-header h2 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 6px;
        }

        .form-header p { color: #64748b; font-size: 0.88rem; }

        /* Tabs */
        .auth-tabs {
            display: flex;
            background: #f1f5f9;
            border-radius: 10px;
            padding: 4px;
            margin-bottom: 28px;
        }

        .auth-tab {
            flex: 1;
            padding: 9px;
            text-align: center;
            border-radius: 7px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            border: none;
            background: none;
            color: #64748b;
            transition: all 0.2s;
        }

        .auth-tab.active {
            background: white;
            color: var(--dark);
            box-shadow: 0 1px 4px rgba(0,0,0,0.1);
        }

        .tab-content { display: none; }
        .tab-content.active { display: block; }

        .form-group { margin-bottom: 18px; }

        .form-label {
            display: block;
            font-size: 0.82rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 7px;
        }

        .input-wrapper { position: relative; }

        .input-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 0.85rem;
        }

        .form-control {
            width: 100%;
            padding: 11px 14px 11px 38px;
            border: 1.5px solid #e2e8f0;
            border-radius: 9px;
            font-size: 0.875rem;
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: all 0.2s;
            outline: none;
            color: var(--dark);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.1);
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 9px;
            font-size: 0.9rem;
            font-weight: 700;
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: all 0.2s;
            margin-top: 8px;
        }

        .btn-submit:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(99,102,241,0.35);
        }

        .alert-msg {
            padding: 11px 14px;
            border-radius: 8px;
            font-size: 0.83rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 9px;
            margin-bottom: 18px;
        }

        .alert-error { background: #fee2e2; color: #991b1b; }
        .alert-success { background: #d1fae5; color: #065f46; }
    </style>
</head>
<body>

<!-- Panneau gauche -->
<div class="left-panel">
    <div class="left-content">
        <div class="brand-logo">Ecom<span>Pro</span></div>
        <p class="brand-desc">Plateforme de gestion commerciale complète pour suivre vos achats, ventes et stocks.</p>

        <div class="features">
            <div class="feature-item">
                <i class="fa-solid fa-box"></i>
                <span>Gestion des produits et stocks en temps réel</span>
            </div>
            <div class="feature-item">
                <i class="fa-solid fa-chart-line"></i>
                <span>Suivi des ventes et achats</span>
            </div>
            <div class="feature-item">
                <i class="fa-solid fa-users"></i>
                <span>Gestion multi-utilisateurs</span>
            </div>
            <div class="feature-item">
                <i class="fa-solid fa-shield-halved"></i>
                <span>Accès sécurisé et authentifié</span>
            </div>
        </div>
    </div>
</div>

<!-- Panneau droit -->
<div class="right-panel">
    <div class="form-header">
        <h2>Bienvenue</h2>
        <p>Connectez-vous ou créez un compte pour continuer</p>
    </div>

    <!-- Tabs -->
    <div class="auth-tabs">
        <button class="auth-tab ${empty activeTab || activeTab == 'login' ? 'active' : ''}"
                onclick="switchTab('login')">
            <i class="fa-solid fa-right-to-bracket"></i> Connexion
        </button>
        <button class="auth-tab ${activeTab == 'register' ? 'active' : ''}"
                onclick="switchTab('register')">
            <i class="fa-solid fa-user-plus"></i> Inscription
        </button>
    </div>

    <!-- Tab Connexion -->
    <div class="tab-content ${empty activeTab || activeTab == 'login' ? 'active' : ''}" id="tab-login">

        <c:if test="${not empty erreurLogin}">
            <div class="alert-msg alert-error">
                <i class="fa-solid fa-circle-exclamation"></i> ${erreurLogin}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth" method="post">
            <input type="hidden" name="action" value="login"/>

            <div class="form-group">
                <label class="form-label">Adresse email</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" name="email" class="form-control"
                           placeholder="votre@email.com" required/>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Mot de passe</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" class="form-control"
                           placeholder="••••••••" required/>
                </div>
            </div>

            <button type="submit" class="btn-submit">
                Se connecter <i class="fa-solid fa-arrow-right"></i>
            </button>
        </form>
    </div>

    <!-- Tab Inscription -->
    <div class="tab-content ${activeTab == 'register' ? 'active' : ''}" id="tab-register">

        <c:if test="${not empty erreurRegister}">
            <div class="alert-msg alert-error">
                <i class="fa-solid fa-circle-exclamation"></i> ${erreurRegister}
            </div>
        </c:if>

        <c:if test="${not empty succes}">
            <div class="alert-msg alert-success">
                <i class="fa-solid fa-circle-check"></i> ${succes}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth" method="post">
            <input type="hidden" name="action" value="register"/>

            <div class="form-group">
                <label class="form-label">Adresse email</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" name="email" class="form-control"
                           placeholder="votre@email.com" required/>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Mot de passe</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" class="form-control"
                           placeholder="Minimum 6 caractères" required/>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Confirmer le mot de passe</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="confirmPassword" class="form-control"
                           placeholder="••••••••" required/>
                </div>
            </div>

            <button type="submit" class="btn-submit">
                Créer mon compte <i class="fa-solid fa-arrow-right"></i>
            </button>
        </form>
    </div>
</div>

<script>
    function switchTab(tab) {
        document.querySelectorAll('.auth-tab').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
        document.getElementById('tab-' + tab).classList.add('active');
        event.target.classList.add('active');
    }
</script>

</body>
</html>