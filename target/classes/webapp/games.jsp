<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Game" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>GameVerse Academy — Jeux</title>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --bg:#0f0d17;--surface:#1a1729;--surface2:#201d30;
            --border:rgba(167,139,250,.12);--border-hi:rgba(167,139,250,.35);
            --lav:#a78bfa;--lav-light:#c4b5fd;--lav-dim:#6d5ca8;
            --rose:#f472b6;--teal:#34d399;--text:#ede9fe;
            --text-mid:#9585c8;--text-lo:#4a4068;--glow:0 0 24px rgba(167,139,250,.3);
        }
        html,body{min-height:100vh;background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;overflow-x:hidden;}
        .orb{position:fixed;pointer-events:none;z-index:0;border-radius:50%;filter:blur(90px);}
        .orb-1{width:600px;height:600px;top:-200px;left:-150px;background:radial-gradient(circle,rgba(109,92,168,.22) 0%,transparent 70%);animation:dA 18s ease-in-out infinite alternate;}
        .orb-2{width:500px;height:500px;bottom:-100px;right:-100px;background:radial-gradient(circle,rgba(167,139,250,.15) 0%,transparent 70%);animation:dB 22s ease-in-out infinite alternate;}
        @keyframes dA{from{transform:translate(0,0)}to{transform:translate(40px,30px)}}
        @keyframes dB{from{transform:translate(0,0)}to{transform:translate(-30px,-40px)}}
        body::before{content:'';position:fixed;inset:0;z-index:0;pointer-events:none;background-image:radial-gradient(circle,rgba(167,139,250,.05) 1px,transparent 1px);background-size:32px 32px;}
        .sidebar{position:fixed;left:0;top:0;bottom:0;width:220px;background:rgba(13,11,21,.95);backdrop-filter:blur(20px);border-right:1px solid var(--border);display:flex;flex-direction:column;padding:2rem 0;z-index:100;}
        .s-logo{padding:0 1.6rem 1.8rem;border-bottom:1px solid var(--border);margin-bottom:1.5rem;}
        .s-logo .mark{font-family:'Cinzel',serif;font-size:1.05rem;font-weight:700;letter-spacing:.06em;background:linear-gradient(135deg,var(--lav-light),var(--lav));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;line-height:1.25;}
        .s-logo .sub{font-size:.6rem;letter-spacing:.22em;text-transform:uppercase;color:var(--text-lo);margin-top:.3rem;}
        .nav-sec{padding:0 .8rem;flex:1;}
        .nav-lbl{font-size:.58rem;letter-spacing:.2em;text-transform:uppercase;color:var(--text-lo);padding:.4rem .8rem .7rem;}
        .nav-a{display:flex;align-items:center;gap:.75rem;padding:.65rem .8rem;border-radius:8px;text-decoration:none;color:var(--text-mid);font-size:.82rem;transition:all .2s;margin-bottom:.12rem;position:relative;}
        .nav-a svg{width:15px;height:15px;flex-shrink:0;opacity:.65;}
        .nav-a:hover{background:rgba(167,139,250,.08);color:var(--lav-light);}
        .nav-a:hover svg,.nav-a.active svg{opacity:1;}
        .nav-a.active{background:rgba(167,139,250,.14);color:var(--lav-light);}
        .nav-a.active::before{content:'';position:absolute;left:0;top:22%;bottom:22%;width:2px;background:var(--lav);border-radius:2px;box-shadow:var(--glow);}
        .s-foot{padding:1rem 1.6rem 0;border-top:1px solid var(--border);margin-top:auto;}
        .u-chip{display:flex;align-items:center;gap:.7rem;}
        .u-av{width:30px;height:30px;border-radius:50%;background:linear-gradient(135deg,var(--lav),var(--lav-dim));display:flex;align-items:center;justify-content:center;font-size:.62rem;font-weight:700;color:var(--bg);flex-shrink:0;box-shadow:var(--glow);}
        .u-name{font-size:.78rem;font-weight:500;color:var(--text);}
        .u-role{font-size:.62rem;color:var(--text-lo);letter-spacing:.04em;}
        .logout-btn{width:100%;display:flex;align-items:center;gap:.5rem;justify-content:center;padding:.5rem .8rem;border-radius:8px;border:1px solid var(--border);background:transparent;color:var(--text-mid);font-family:'DM Sans',sans-serif;font-size:.72rem;letter-spacing:.06em;text-transform:uppercase;cursor:pointer;transition:all .2s;margin-top:.75rem;}
        .logout-btn:hover{background:rgba(244,114,182,.08);border-color:var(--rose);color:#f9a8d4;}
        .main{margin-left:220px;position:relative;z-index:1;padding:2.5rem 2.5rem 4rem;}
        .ph{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:2rem;}
        .ph-left .ey{font-size:.62rem;letter-spacing:.25em;text-transform:uppercase;color:var(--lav);margin-bottom:.4rem;display:flex;align-items:center;gap:.5rem;}
        .ph-left .ey::before{content:'';display:inline-block;width:18px;height:1px;background:var(--lav);box-shadow:var(--glow);}
        .ph-left h1{font-family:'Cinzel',serif;font-size:2.4rem;font-weight:700;letter-spacing:.04em;background:linear-gradient(135deg,#fff 0%,var(--lav-light) 55%,var(--lav) 100%);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;line-height:1.1;}
        .ph-left .sub2{font-size:.78rem;color:var(--text-lo);margin-top:.4rem;}
        .btn-add{display:inline-flex;align-items:center;gap:.6rem;background:linear-gradient(135deg,var(--lav-dim),#4c3d8f);border:1px solid var(--lav);border-radius:10px;color:var(--lav-light);font-family:'Cinzel',serif;font-size:.75rem;font-weight:600;letter-spacing:.1em;padding:.75rem 1.5rem;cursor:pointer;text-decoration:none;text-transform:uppercase;box-shadow:var(--glow),inset 0 1px 0 rgba(255,255,255,.08);transition:all .25s;white-space:nowrap;}
        .btn-add:hover{background:linear-gradient(135deg,#7c5cd6,#5a47a8);transform:translateY(-2px);}
        .ctrl{display:flex;align-items:center;gap:.75rem;margin-bottom:1.8rem;flex-wrap:wrap;}
        .srch{position:relative;flex:1;min-width:220px;}
        .srch svg{position:absolute;left:.9rem;top:50%;transform:translateY(-50%);width:14px;height:14px;stroke:var(--text-lo);pointer-events:none;}
        .srch input{width:100%;background:var(--surface);border:1px solid var(--border);border-radius:10px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:.85rem;padding:.7rem 1rem .7rem 2.4rem;outline:none;transition:border-color .2s;}
        .srch input::placeholder{color:var(--text-lo);}
        .srch input:focus{border-color:var(--lav-dim);}
        .cards-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(320px,1fr));gap:1.25rem;}
        .game-card{background:var(--surface);border:1px solid var(--border);border-radius:14px;overflow:hidden;display:flex;flex-direction:column;transition:border-color .25s,box-shadow .25s,transform .2s;animation:fadeUp .5s ease both;position:relative;}
        .game-card::after{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,var(--lav),transparent);opacity:0;transition:opacity .3s;}
        .game-card:hover{border-color:var(--border-hi);box-shadow:var(--glow);transform:translateY(-3px);}
        .game-card:hover::after{opacity:1;}
        @keyframes fadeUp{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:translateY(0)}}
        .card-header{padding:1.2rem 1.2rem .8rem;border-bottom:1px solid var(--border);}
        .card-title{font-family:'Cinzel',serif;font-size:1rem;font-weight:600;color:var(--text);margin-bottom:.5rem;}
        .badge{display:inline-flex;align-items:center;gap:.3rem;font-size:.6rem;font-weight:500;letter-spacing:.1em;text-transform:uppercase;border-radius:20px;padding:.25rem .65rem;background:rgba(167,139,250,.12);color:var(--lav-light);border:1px solid rgba(167,139,250,.25);}
        .card-body{padding:1rem 1.2rem;flex:1;}
        .info-row{display:flex;justify-content:space-between;align-items:center;padding:.35rem 0;font-size:.78rem;}
        .info-row:not(:last-child){border-bottom:1px solid rgba(167,139,250,.06);}
        .info-label{color:var(--text-lo);letter-spacing:.06em;text-transform:uppercase;font-size:.65rem;}
        .info-value{color:var(--text-mid);}
        .card-actions{display:flex;gap:.4rem;padding:.8rem 1.2rem;border-top:1px solid var(--border);}
        .ibtn{flex:1;display:flex;align-items:center;justify-content:center;gap:.4rem;padding:.45rem;border-radius:7px;border:1px solid var(--border);background:transparent;text-decoration:none;font-family:'DM Sans',sans-serif;font-size:.7rem;letter-spacing:.06em;text-transform:uppercase;cursor:pointer;transition:all .2s;}
        .ibtn svg{width:12px;height:12px;}
        .ibtn.ed{color:var(--lav);}.ibtn.ed svg{stroke:var(--lav);}
        .ibtn.ed:hover{background:rgba(167,139,250,.12);border-color:var(--lav);}
        .ibtn.dl{color:#f4a0a0;}.ibtn.dl svg{stroke:#f4a0a0;}
        .ibtn.dl:hover{background:rgba(244,114,182,.1);border-color:var(--rose);}
        .empty{text-align:center;padding:5rem 2rem;color:var(--text-lo);grid-column:1/-1;}
        .empty svg{width:48px;height:48px;stroke:var(--text-lo);margin-bottom:1rem;opacity:.4;display:block;margin-left:auto;margin-right:auto;}
        .bar{margin-top:2rem;display:flex;align-items:center;justify-content:space-between;padding-top:1rem;border-top:1px solid var(--border);}
        .bar span{font-size:.68rem;letter-spacing:.1em;text-transform:uppercase;color:var(--text-lo);}
        .live{display:inline-flex;align-items:center;gap:.4rem;}
        .live::before{content:'';width:6px;height:6px;border-radius:50%;background:var(--teal);box-shadow:0 0 8px var(--teal);animation:pl 2s infinite;}
        @keyframes pl{0%,100%{opacity:1}50%{opacity:.3}}
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
        <div class="nav-lbl" style="margin-top:1rem">Compte</div>
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
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" style="width:13px;height:13px;">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                    <polyline points="16 17 21 12 16 7"/>
                    <line x1="21" y1="12" x2="9" y2="12"/>
                </svg>Déconnexion
            </button>
        </form>
    </div>
</aside>

<main class="main">
    <div class="ph">
        <div class="ph-left">
            <div class="ey">GameVerse Academy</div>
            <h1>Bibliothèque Jeux</h1>
            <p class="sub2">Gestion des jeux de la plateforme</p>
        </div>
        <a href="<%= request.getContextPath() %>/submitGame" class="btn-add">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            Ajouter un jeu
        </a>
    </div>

    <div class="ctrl">
        <div class="srch">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            <input type="text" id="searchInput" placeholder="Rechercher par titre, développeur…" oninput="filterCards()">
        </div>
    </div>

    <div class="cards-grid" id="grid">
<%
    List<Game> games = (List<Game>) request.getAttribute("games");
    if (games != null && !games.isEmpty()) {
        for (Game game : games) {
            String title     = game.getTitle()     != null ? game.getTitle()     : "";
            String genre     = game.getGenre()     != null ? game.getGenre()     : "—";
            String platform  = game.getPlatform()  != null ? game.getPlatform()  : "—";
            String developer = game.getDeveloper() != null ? game.getDeveloper() : "—";
            String publisher = game.getPublisher() != null ? game.getPublisher() : "—";
%>
        <div class="game-card">
            <div class="card-header">
                <div class="card-title"><%= title %></div>
                <span class="badge"><%= genre %></span>
            </div>
            <div class="card-body">
                <div class="info-row">
                    <span class="info-label">Plateforme</span>
                    <span class="info-value"><%= platform %></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Développeur</span>
                    <span class="info-value"><%= developer %></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Éditeur</span>
                    <span class="info-value"><%= publisher %></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Date sortie</span>
                    <span class="info-value"><%= game.getReleaseDate() != null ? game.getReleaseDate() : "—" %></span>
                </div>
            </div>
            <div class="card-actions">
                <a href="<%= request.getContextPath() %>/updateGame?id=<%= game.getId() %>" class="ibtn ed">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                    Modifier
                </a>
                <a href="<%= request.getContextPath() %>/deleteGame?id=<%= game.getId() %>" class="ibtn dl">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/><path d="M10 11v6M14 11v6"/><path d="M9 6V4h6v2"/></svg>
                    Supprimer
                </a>
            </div>
        </div>
<%
        }
    } else {
%>
        <div class="empty">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><rect x="2" y="3" width="20" height="14" rx="2"/></svg>
            <p>Aucun jeu trouvé.</p>
        </div>
<% } %>
    </div>

    <div class="bar">
        <span class="live" id="countLabel"></span>
        <span>GameVerse Academy — Admin Panel</span>
    </div>
</main>

<script>
    function updateCount() {
        const n = document.querySelectorAll('#grid .game-card').length;
        document.getElementById('countLabel').textContent = n + ' jeu' + (n > 1 ? 'x' : '') + ' affiché' + (n > 1 ? 's' : '');
    }
    updateCount();
    function filterCards() {
        const q = document.getElementById('searchInput').value.toLowerCase();
        document.querySelectorAll('#grid .game-card').forEach(card => {
            card.style.display = card.textContent.toLowerCase().includes(q) ? '' : 'none';
        });
    }
</script>
</body>
</html>