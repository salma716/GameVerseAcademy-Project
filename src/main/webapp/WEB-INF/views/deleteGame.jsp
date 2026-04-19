<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ma.ac.esi.gameverseacademy.model.Game" %>
<% Game game = (Game) request.getAttribute("game"); %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>GameVerse Academy — Supprimer un Jeu</title>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --bg:#0f0d17;--surface:#1a1729;--surface2:#201d30;
            --border:rgba(167,139,250,.12);--lav:#a78bfa;--lav-light:#c4b5fd;
            --lav-dim:#6d5ca8;--rose:#f472b6;--teal:#34d399;--text:#ede9fe;
            --text-mid:#9585c8;--text-lo:#4a4068;--glow:0 0 24px rgba(167,139,250,.3);
        }
        html,body{min-height:100vh;background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;overflow-x:hidden;}
        .orb{position:fixed;pointer-events:none;z-index:0;border-radius:50%;filter:blur(90px);}
        .orb-1{width:600px;height:600px;top:-200px;left:-150px;background:radial-gradient(circle,rgba(109,92,168,.22) 0%,transparent 70%);}
        .orb-2{width:500px;height:500px;bottom:-100px;right:-100px;background:radial-gradient(circle,rgba(167,139,250,.15) 0%,transparent 70%);}
        body::before{content:'';position:fixed;inset:0;z-index:0;pointer-events:none;background-image:radial-gradient(circle,rgba(167,139,250,.05) 1px,transparent 1px);background-size:32px 32px;}
        .sidebar{position:fixed;left:0;top:0;bottom:0;width:220px;background:rgba(13,11,21,.95);backdrop-filter:blur(20px);border-right:1px solid var(--border);display:flex;flex-direction:column;padding:2rem 0;z-index:100;}
        .s-logo{padding:0 1.6rem 1.8rem;border-bottom:1px solid var(--border);margin-bottom:1.5rem;}
        .s-logo .mark{font-family:'Cinzel',serif;font-size:1.05rem;font-weight:700;background:linear-gradient(135deg,var(--lav-light),var(--lav));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;line-height:1.25;}
        .s-logo .sub{font-size:.6rem;letter-spacing:.22em;text-transform:uppercase;color:var(--text-lo);margin-top:.3rem;}
        .nav-sec{padding:0 .8rem;flex:1;}
        .nav-lbl{font-size:.58rem;letter-spacing:.2em;text-transform:uppercase;color:var(--text-lo);padding:.4rem .8rem .7rem;}
        .nav-a{display:flex;align-items:center;gap:.75rem;padding:.65rem .8rem;border-radius:8px;text-decoration:none;color:var(--text-mid);font-size:.82rem;transition:all .2s;margin-bottom:.12rem;position:relative;}
        .nav-a svg{width:15px;height:15px;flex-shrink:0;opacity:.65;}
        .nav-a:hover{background:rgba(167,139,250,.08);color:var(--lav-light);}
        .nav-a.active{background:rgba(167,139,250,.14);color:var(--lav-light);}
        .nav-a.active::before{content:'';position:absolute;left:0;top:22%;bottom:22%;width:2px;background:var(--lav);border-radius:2px;}
        .s-foot{padding:1rem 1.6rem 0;border-top:1px solid var(--border);margin-top:auto;}
        .u-chip{display:flex;align-items:center;gap:.7rem;}
        .u-av{width:30px;height:30px;border-radius:50%;background:linear-gradient(135deg,var(--lav),var(--lav-dim));display:flex;align-items:center;justify-content:center;font-size:.62rem;font-weight:700;color:var(--bg);flex-shrink:0;}
        .u-name{font-size:.78rem;font-weight:500;color:var(--text);}
        .u-role{font-size:.62rem;color:var(--text-lo);}
        .logout-btn{width:100%;display:flex;align-items:center;gap:.5rem;justify-content:center;padding:.5rem .8rem;border-radius:8px;border:1px solid var(--border);background:transparent;color:var(--text-mid);font-family:'DM Sans',sans-serif;font-size:.72rem;text-transform:uppercase;cursor:pointer;transition:all .2s;margin-top:.75rem;}
        .logout-btn:hover{background:rgba(244,114,182,.08);border-color:var(--rose);color:#f9a8d4;}
        .main{margin-left:220px;position:relative;z-index:1;padding:2.5rem 2.5rem 4rem;}
        .ph{margin-bottom:2rem;}
        .ph .ey{font-size:.62rem;letter-spacing:.25em;text-transform:uppercase;color:var(--rose);margin-bottom:.4rem;display:flex;align-items:center;gap:.5rem;}
        .ph .ey::before{content:'';display:inline-block;width:18px;height:1px;background:var(--rose);}
        .ph h1{font-family:'Cinzel',serif;font-size:2rem;font-weight:700;background:linear-gradient(135deg,#fff 0%,#f9a8d4 55%,var(--rose) 100%);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}
        .ph .sub2{font-size:.78rem;color:var(--text-lo);margin-top:.4rem;}
        .confirm-card{background:var(--surface);border:1px solid rgba(244,114,182,.2);border-radius:16px;padding:2.5rem;max-width:560px;position:relative;overflow:hidden;animation:fadeUp .5s ease both;}
        .confirm-card::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,var(--rose),transparent);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:translateY(0)}}
        .warn-icon{width:56px;height:56px;border-radius:50%;background:rgba(244,114,182,.1);border:1px solid rgba(244,114,182,.25);display:flex;align-items:center;justify-content:center;margin-bottom:1.5rem;}
        .warn-icon svg{width:26px;height:26px;stroke:var(--rose);}
        .warn-text{font-size:.88rem;color:var(--text-mid);line-height:1.6;}
        .warn-text strong{color:#f9a8d4;}
        .mod-info{background:var(--surface2);border:1px solid var(--border);border-radius:10px;padding:1rem 1.2rem;margin:1.5rem 0;}
        .mod-info-row{display:flex;justify-content:space-between;align-items:center;padding:.3rem 0;}
        .mod-info-row:not(:last-child){border-bottom:1px solid var(--border);}
        .mod-info-label{font-size:.65rem;letter-spacing:.1em;text-transform:uppercase;color:var(--text-lo);}
        .mod-info-value{font-size:.82rem;color:var(--text);font-weight:500;}
        .confirm-actions{display:flex;gap:.75rem;margin-top:2rem;}
        .btn-confirm-delete{flex:1;display:flex;align-items:center;justify-content:center;gap:.6rem;background:linear-gradient(135deg,#9f1239,#be185d);border:1px solid var(--rose);border-radius:10px;color:#fce7f3;font-family:'Cinzel',serif;font-size:.75rem;font-weight:600;letter-spacing:.1em;text-transform:uppercase;padding:.75rem 1.5rem;cursor:pointer;transition:all .25s;}
        .btn-confirm-delete:hover{background:linear-gradient(135deg,#be185d,#ec4899);transform:translateY(-2px);}
        .btn-cancel{display:flex;align-items:center;justify-content:center;gap:.6rem;padding:.75rem 1.5rem;border-radius:10px;border:1px solid var(--border);background:transparent;color:var(--text-mid);font-family:'DM Sans',sans-serif;font-size:.75rem;text-transform:uppercase;text-decoration:none;transition:all .2s;}
        .btn-cancel:hover{border-color:var(--lav);color:var(--lav-light);}
    </style>
</head>
<body>
<div class="orb orb-1"></div>
<div class="orb orb-2"></div>

<aside class="sidebar">
    <div class="s-logo">
        <div class="mark">GameVerse<br>Academy</div>
        <div class="sub">Admin Panel</div>
    </div>
    <nav class="nav-sec">
        <div class="nav-lbl">Navigation</div>
        <a href="<%= request.getContextPath() %>/mods" class="nav-a">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>Mods
        </a>
        <a href="<%= request.getContextPath() %>/games" class="nav-a active">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>Jeux
        </a>
    </nav>
    <div class="s-foot">
        <div class="u-chip">
            <div class="u-av">
                <% String su = (String) session.getAttribute("email");
                   String av = (su != null && su.length() >= 2) ? su.substring(0,2).toUpperCase() : "?"; %>
                <%= av %>
            </div>
            <div>
                <div class="u-name"><%= su != null ? su : "Visiteur" %></div>
                <div class="u-role">Super Admin</div>
            </div>
        </div>
        <form action="<%= request.getContextPath() %>/logout" method="post">
            <button type="submit" class="logout-btn">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" style="width:13px;height:13px;"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                Déconnexion
            </button>
        </form>
    </div>
</aside>

<main class="main">
    <div class="ph">
        <div class="ey">Action irréversible</div>
        <h1>Supprimer le Jeu</h1>
        <p class="sub2">Cette action est permanente et ne peut pas être annulée</p>
    </div>

    <div class="confirm-card">
        <div class="warn-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/><path d="M10 11v6M14 11v6"/><path d="M9 6V4h6v2"/></svg>
        </div>
        <p class="warn-text">
            Vous êtes sur le point de supprimer définitivement le jeu
            <strong>« <%= game.getTitle() %> »</strong>.
            Cette action est <strong>irréversible</strong>.
        </p>
        <div class="mod-info">
            <div class="mod-info-row">
                <span class="mod-info-label">ID</span>
                <span class="mod-info-value">#<%= String.format("%02d", game.getId()) %></span>
            </div>
            <div class="mod-info-row">
                <span class="mod-info-label">Titre</span>
                <span class="mod-info-value"><%= game.getTitle() %></span>
            </div>
            <div class="mod-info-row">
                <span class="mod-info-label">Genre</span>
                <span class="mod-info-value"><%= game.getGenre() != null ? game.getGenre() : "—" %></span>
            </div>
            <div class="mod-info-row">
                <span class="mod-info-label">Plateforme</span>
                <span class="mod-info-value"><%= game.getPlatform() != null ? game.getPlatform() : "—" %></span>
            </div>
        </div>
        <div class="confirm-actions">
            <form method="post" action="<%= request.getContextPath() %>/deleteGame">
                <input type="hidden" name="id" value="<%= game.getId() %>"/>
                <button type="submit" class="btn-confirm-delete">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:14px;height:14px;"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/></svg>
                    Confirmer la suppression
                </button>
            </form>
            <a href="<%= request.getContextPath() %>/games" class="btn-cancel">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:14px;height:14px;"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                Annuler
            </a>
        </div>
    </div>
</main>
</body>
</html>