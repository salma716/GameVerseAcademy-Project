<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ma.ac.esi.gameverseacademy.model.Game" %>
<% Game game = (Game) request.getAttribute("game"); %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>GameVerse Academy — Modifier un Jeu</title>
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
        .ph .ey{font-size:.62rem;letter-spacing:.25em;text-transform:uppercase;color:var(--lav);margin-bottom:.4rem;display:flex;align-items:center;gap:.5rem;}
        .ph .ey::before{content:'';display:inline-block;width:18px;height:1px;background:var(--lav);}
        .ph h1{font-family:'Cinzel',serif;font-size:2rem;font-weight:700;background:linear-gradient(135deg,#fff 0%,var(--lav-light) 55%,var(--lav) 100%);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}
        .ph .sub2{font-size:.78rem;color:var(--text-lo);margin-top:.4rem;}
        .form-card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:2rem;max-width:680px;position:relative;overflow:hidden;animation:fadeUp .5s ease both;}
        .form-card::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,var(--lav),transparent);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:translateY(0)}}
        .id-row{display:flex;align-items:center;gap:.6rem;margin-bottom:1.6rem;padding-bottom:1.2rem;border-bottom:1px solid var(--border);}
        .id-badge{font-family:'Cinzel',serif;font-size:.75rem;color:var(--lav);background:rgba(167,139,250,.1);border:1px solid rgba(167,139,250,.25);border-radius:6px;padding:.3rem .7rem;}
        .id-label{font-size:.72rem;color:var(--text-lo);letter-spacing:.1em;text-transform:uppercase;}
        .form-grid{display:grid;grid-template-columns:1fr 1fr;gap:1.2rem;}
        .form-group{margin-bottom:1.2rem;}
        .form-group.full{grid-column:1/-1;}
        .form-group label{display:block;font-size:.72rem;letter-spacing:.12em;text-transform:uppercase;color:var(--text-mid);margin-bottom:.5rem;}
        .form-group input,.form-group select,.form-group textarea{width:100%;background:var(--surface2);border:1px solid var(--border);border-radius:10px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:.88rem;padding:.75rem 1rem;outline:none;transition:border-color .2s,box-shadow .2s;}
        .form-group input:focus,.form-group select:focus,.form-group textarea:focus{border-color:var(--lav-dim);box-shadow:0 0 0 3px rgba(167,139,250,.12);}
        .form-group textarea{resize:vertical;min-height:100px;}
        .form-group select option{background:var(--surface2);}
        .form-actions{display:flex;gap:.75rem;margin-top:1.8rem;padding-top:1.4rem;border-top:1px solid var(--border);}
        .btn-save{flex:1;display:flex;align-items:center;justify-content:center;gap:.6rem;background:linear-gradient(135deg,var(--lav-dim),#4c3d8f);border:1px solid var(--lav);border-radius:10px;color:var(--lav-light);font-family:'Cinzel',serif;font-size:.75rem;font-weight:600;letter-spacing:.1em;text-transform:uppercase;padding:.75rem 1.5rem;cursor:pointer;transition:all .25s;}
        .btn-save:hover{background:linear-gradient(135deg,#7c5cd6,#5a47a8);transform:translateY(-2px);}
        .btn-cancel{display:flex;align-items:center;justify-content:center;gap:.6rem;padding:.75rem 1.5rem;border-radius:10px;border:1px solid var(--border);background:transparent;color:var(--text-mid);font-family:'DM Sans',sans-serif;font-size:.75rem;text-transform:uppercase;text-decoration:none;transition:all .2s;}
        .btn-cancel:hover{border-color:var(--rose);color:#f9a8d4;}
        .alert-error{background:rgba(244,114,182,.1);border:1px solid rgba(244,114,182,.3);border-radius:10px;padding:.85rem 1rem;margin-bottom:1.4rem;color:#f9a8d4;font-size:.82rem;}
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
        <div class="ey">GameVerse Academy</div>
        <h1>Modifier le Jeu</h1>
        <p class="sub2">Mise à jour des informations du jeu</p>
    </div>

    <div class="form-card">
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <div class="id-row">
            <span class="id-label">ID du jeu</span>
            <span class="id-badge">#<%= String.format("%02d", game.getId()) %></span>
        </div>

        <form action="<%= request.getContextPath() %>/updateGame" method="post">
            <input type="hidden" name="id" value="<%= game.getId() %>"/>
            <div class="form-grid">
                <div class="form-group">
                    <label>Titre *</label>
                    <input type="text" name="title" value="<%= game.getTitle() != null ? game.getTitle() : "" %>" required/>
                </div>
                <div class="form-group">
                    <label>Genre</label>
                    <select name="genre">
                        <option value="">— Choisir —</option>
                        <option value="RPG" <%= "RPG".equals(game.getGenre()) ? "selected" : "" %>>RPG</option>
                        <option value="Action" <%= "Action".equals(game.getGenre()) ? "selected" : "" %>>Action</option>
                        <option value="Sandbox" <%= "Sandbox".equals(game.getGenre()) ? "selected" : "" %>>Sandbox</option>
                        <option value="FPS" <%= "FPS".equals(game.getGenre()) ? "selected" : "" %>>FPS</option>
                        <option value="Simulation" <%= "Simulation".equals(game.getGenre()) ? "selected" : "" %>>Simulation</option>
                        <option value="Sport" <%= "Sport".equals(game.getGenre()) ? "selected" : "" %>>Sport</option>
                        <option value="Stratégie" <%= "Stratégie".equals(game.getGenre()) ? "selected" : "" %>>Stratégie</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Plateforme</label>
                    <select name="platform">
                        <option value="">— Choisir —</option>
                        <option value="PC" <%= "PC".equals(game.getPlatform()) ? "selected" : "" %>>PC</option>
                        <option value="PlayStation" <%= "PlayStation".equals(game.getPlatform()) ? "selected" : "" %>>PlayStation</option>
                        <option value="Xbox" <%= "Xbox".equals(game.getPlatform()) ? "selected" : "" %>>Xbox</option>
                        <option value="Nintendo Switch" <%= "Nintendo Switch".equals(game.getPlatform()) ? "selected" : "" %>>Nintendo Switch</option>
                        <option value="Multi-plateforme" <%= "Multi-plateforme".equals(game.getPlatform()) ? "selected" : "" %>>Multi-plateforme</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Date de sortie</label>
                    <input type="date" name="release_date" value="<%= game.getReleaseDate() != null ? game.getReleaseDate() : "" %>"/>
                </div>
                <div class="form-group">
                    <label>Développeur</label>
                    <input type="text" name="developer" value="<%= game.getDeveloper() != null ? game.getDeveloper() : "" %>"/>
                </div>
                <div class="form-group">
                    <label>Éditeur</label>
                    <input type="text" name="publisher" value="<%= game.getPublisher() != null ? game.getPublisher() : "" %>"/>
                </div>
                <div class="form-group full">
                    <label>Description</label>
                    <textarea name="description"><%= game.getDescription() != null ? game.getDescription() : "" %></textarea>
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-save">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:14px;height:14px;"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/></svg>
                    Sauvegarder
                </button>
                <a href="<%= request.getContextPath() %>/games" class="btn-cancel">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:14px;height:14px;"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                    Annuler
                </a>
            </div>
        </form>
    </div>
</main>
</body>
</html>