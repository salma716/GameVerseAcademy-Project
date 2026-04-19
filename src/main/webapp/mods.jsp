
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Mod" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>GameVerse Academy — Mods</title>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --bg:          #0f0d17;
            --surface:     #1a1729;
            --surface2:    #201d30;
            --border:      rgba(167,139,250,.12);
            --border-hi:   rgba(167,139,250,.35);
            --lav:         #a78bfa;
            --lav-light:   #c4b5fd;
            --lav-dim:     #6d5ca8;
            --rose:        #f472b6;
            --teal:        #34d399;
            --text:        #ede9fe;
            --text-mid:    #9585c8;
            --text-lo:     #4a4068;
            --glow:        0 0 24px rgba(167,139,250,.3);
        }

        html, body { min-height:100vh;background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;overflow-x:hidden; }

        /* ── AMBIENT ────────────────────────────────── */
        .orb { position:fixed;pointer-events:none;z-index:0;border-radius:50%;filter:blur(90px); }
        .orb-1 { width:600px;height:600px;top:-200px;left:-150px;
                 background:radial-gradient(circle,rgba(109,92,168,.22) 0%,transparent 70%);
                 animation:dA 18s ease-in-out infinite alternate; }
        .orb-2 { width:500px;height:500px;bottom:-100px;right:-100px;
                 background:radial-gradient(circle,rgba(167,139,250,.15) 0%,transparent 70%);
                 animation:dB 22s ease-in-out infinite alternate; }
        @keyframes dA { from{transform:translate(0,0)} to{transform:translate(40px,30px)} }
        @keyframes dB { from{transform:translate(0,0)} to{transform:translate(-30px,-40px)} }
        body::before {
            content:'';position:fixed;inset:0;z-index:0;pointer-events:none;
            background-image:radial-gradient(circle,rgba(167,139,250,.05) 1px,transparent 1px);
            background-size:32px 32px;
        }

        /* ── SIDEBAR ────────────────────────────────── */
        .sidebar {
            position:fixed;left:0;top:0;bottom:0;width:220px;
            background:rgba(13,11,21,.95);backdrop-filter:blur(20px);
            border-right:1px solid var(--border);
            display:flex;flex-direction:column;padding:2rem 0;z-index:100;
        }
        .s-logo { padding:0 1.6rem 1.8rem;border-bottom:1px solid var(--border);margin-bottom:1.5rem; }
        .s-logo .mark {
            font-family:'Cinzel',serif;font-size:1.05rem;font-weight:700;letter-spacing:.06em;
            background:linear-gradient(135deg,var(--lav-light),var(--lav));
            -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;line-height:1.25;
        }
        .s-logo .sub { font-size:.6rem;letter-spacing:.22em;text-transform:uppercase;color:var(--text-lo);margin-top:.3rem; }
        .nav-sec { padding:0 .8rem;flex:1; }
        .nav-lbl { font-size:.58rem;letter-spacing:.2em;text-transform:uppercase;color:var(--text-lo);padding:.4rem .8rem .7rem; }
        .nav-a {
            display:flex;align-items:center;gap:.75rem;padding:.65rem .8rem;border-radius:8px;
            text-decoration:none;color:var(--text-mid);font-size:.82rem;letter-spacing:.01em;
            transition:all .2s;margin-bottom:.12rem;position:relative;
        }
        .nav-a svg { width:15px;height:15px;flex-shrink:0;opacity:.65; }
        .nav-a:hover { background:rgba(167,139,250,.08);color:var(--lav-light); }
        .nav-a:hover svg,.nav-a.active svg { opacity:1; }
        .nav-a.active { background:rgba(167,139,250,.14);color:var(--lav-light); }
        .nav-a.active::before {
            content:'';position:absolute;left:0;top:22%;bottom:22%;
            width:2px;background:var(--lav);border-radius:2px;box-shadow:var(--glow);
        }
        .s-foot { padding:1rem 1.6rem 0;border-top:1px solid var(--border);margin-top:auto; }
        .u-chip { display:flex;align-items:center;gap:.7rem; }
        .u-av {
            width:30px;height:30px;border-radius:50%;
            background:linear-gradient(135deg,var(--lav),var(--lav-dim));
            display:flex;align-items:center;justify-content:center;
            font-size:.62rem;font-weight:700;color:var(--bg);flex-shrink:0;box-shadow:var(--glow);
        }
        .u-name { font-size:.78rem;font-weight:500;color:var(--text); }
        .u-role { font-size:.62rem;color:var(--text-lo);letter-spacing:.04em; }

        /* ── MAIN ───────────────────────────────────── */
        .main { margin-left:220px;position:relative;z-index:1;padding:2.5rem 2.5rem 4rem; }

        /* ── PAGE HEADER ────────────────────────────── */
        .ph { display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:2rem; }
        .ph-left .ey {
            font-size:.62rem;letter-spacing:.25em;text-transform:uppercase;color:var(--lav);
            margin-bottom:.4rem;display:flex;align-items:center;gap:.5rem;
        }
        .ph-left .ey::before { content:'';display:inline-block;width:18px;height:1px;background:var(--lav);box-shadow:var(--glow); }
        .ph-left h1 {
            font-family:'Cinzel',serif;font-size:2.4rem;font-weight:700;letter-spacing:.04em;
            background:linear-gradient(135deg,#fff 0%,var(--lav-light) 55%,var(--lav) 100%);
            -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;line-height:1.1;
        }
        .ph-left .sub2 { font-size:.78rem;color:var(--text-lo);margin-top:.4rem;letter-spacing:.04em; }
        .btn-add {
            display:inline-flex;align-items:center;gap:.6rem;
            background:linear-gradient(135deg,var(--lav-dim),#4c3d8f);
            border:1px solid var(--lav);border-radius:10px;
            color:var(--lav-light);font-family:'Cinzel',serif;
            font-size:.75rem;font-weight:600;letter-spacing:.1em;
            padding:.75rem 1.5rem;cursor:pointer;text-decoration:none;text-transform:uppercase;
            box-shadow:var(--glow),inset 0 1px 0 rgba(255,255,255,.08);
            transition:all .25s;white-space:nowrap;
        }
        .btn-add:hover { background:linear-gradient(135deg,#7c5cd6,#5a47a8);box-shadow:0 0 36px rgba(167,139,250,.45);transform:translateY(-2px); }
        .btn-add svg { width:14px;height:14px; }

        /* ── CONTROLS ───────────────────────────────── */
        .ctrl { display:flex;align-items:center;gap:.75rem;margin-bottom:1.8rem;flex-wrap:wrap; }
        .srch { position:relative;flex:1;min-width:220px; }
        .srch svg { position:absolute;left:.9rem;top:50%;transform:translateY(-50%);width:14px;height:14px;stroke:var(--text-lo);pointer-events:none; }
        .srch input {
            width:100%;background:var(--surface);border:1px solid var(--border);border-radius:10px;
            color:var(--text);font-family:'DM Sans',sans-serif;font-size:.85rem;
            padding:.7rem 1rem .7rem 2.4rem;outline:none;transition:border-color .2s,box-shadow .2s;
        }
        .srch input::placeholder { color:var(--text-lo); }
        .srch input:focus { border-color:var(--lav-dim);box-shadow:0 0 0 3px rgba(167,139,250,.12); }
        .pills { display:flex;gap:.5rem;flex-wrap:wrap; }
        .pill {
            padding:.45rem 1rem;border-radius:20px;border:1px solid var(--border);
            background:transparent;color:var(--text-mid);font-family:'DM Sans',sans-serif;
            font-size:.72rem;letter-spacing:.06em;text-transform:uppercase;cursor:pointer;transition:all .2s;
        }
        .pill:hover { border-color:var(--lav-dim);color:var(--lav-light); }
        .pill.active { background:rgba(167,139,250,.15);border-color:var(--lav);color:var(--lav-light);box-shadow:0 0 12px rgba(167,139,250,.2); }

        /* ── CARDS GRID ─────────────────────────────── */
        .cards-grid {
            display:grid;
            grid-template-columns:repeat(auto-fill,minmax(340px,1fr));
            gap:1.25rem;
        }

        .mod-card {
            background:var(--surface);border:1px solid var(--border);border-radius:14px;
    overflow:hidden;display:flex;flex-direction:column;align-items:stretch;
            transition:border-color .25s,box-shadow .25s,transform .2s;
            animation:fadeUp .5s ease both;position:relative;
        }
        .mod-card::after {
            content:'';position:absolute;top:0;left:0;right:0;height:1px;
            background:linear-gradient(90deg,transparent,var(--lav),transparent);
            opacity:0;transition:opacity .3s;
        }
        .mod-card:hover { border-color:var(--border-hi);box-shadow:var(--glow);transform:translateY(-3px); }
        .mod-card:hover::after { opacity:1; }

        @keyframes fadeUp { from{opacity:0;transform:translateY(16px)} to{opacity:1;transform:translateY(0)} }
        .mod-card:nth-child(1){animation-delay:.05s}.mod-card:nth-child(2){animation-delay:.10s}
        .mod-card:nth-child(3){animation-delay:.15s}.mod-card:nth-child(4){animation-delay:.20s}
        .mod-card:nth-child(5){animation-delay:.25s}.mod-card:nth-child(6){animation-delay:.30s}

        /* Image */
        .card-img {
           width:100%;min-width:unset;height:160px;background:var(--surface2);
    	overflow:hidden;flex-shrink:0;position:relative;
        }
        .card-img img { width:100%;height:100%;object-fit:cover;object-position:center top;display:block;transition:transform .4s ease; }
        .mod-card:hover .card-img img { transform:scale(1.08); }
        .id-badge {
            position:absolute;top:.5rem;left:.5rem;
            background:rgba(10,8,20,.75);backdrop-filter:blur(6px);
            border:1px solid var(--border);border-radius:5px;
            font-family:'Cinzel',serif;font-size:.58rem;color:var(--text-lo);padding:.15rem .4rem;
        }

        /* Body */
        .card-body { padding:1rem 1.1rem;display:flex;flex-direction:column;justify-content:space-between;flex:1;min-width:0; }
        .card-title { font-weight:500;font-size:.95rem;color:var(--text);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;margin-bottom:.4rem; }

        /* Badge */
        .badge {
            display:inline-flex;align-items:center;gap:.3rem;
            font-size:.6rem;font-weight:500;letter-spacing:.1em;
            text-transform:uppercase;border-radius:20px;padding:.25rem .65rem;
        }
        .badge::before { content:'';width:5px;height:5px;border-radius:50%;flex-shrink:0; }
        .badge-Gameplay  { background:rgba(167,139,250,.12);color:var(--lav-light);border:1px solid rgba(167,139,250,.25); }
        .badge-Gameplay::before  { background:var(--lav);box-shadow:0 0 6px var(--lav); }
        .badge-Graphisme { background:rgba(244,114,182,.1);color:#f9a8d4;border:1px solid rgba(244,114,182,.22); }
        .badge-Graphisme::before { background:var(--rose);box-shadow:0 0 6px var(--rose); }
        .badge-Contenu   { background:rgba(52,211,153,.1);color:#6ee7b7;border:1px solid rgba(52,211,153,.2); }
        .badge-Contenu::before   { background:var(--teal);box-shadow:0 0 6px var(--teal); }
        .badge-default   { background:rgba(255,255,255,.05);color:var(--text-mid);border:1px solid var(--border); }
        .badge-default::before { background:var(--text-lo); }

        /* Author */
        .card-author { display:flex;align-items:center;gap:.45rem;font-size:.78rem;color:var(--text-mid);margin-top:.5rem; }
        .author-av {
            width:20px;height:20px;border-radius:50%;
            background:linear-gradient(135deg,var(--lav),var(--lav-dim));
            display:flex;align-items:center;justify-content:center;
            font-size:.52rem;font-weight:700;color:var(--bg);flex-shrink:0;
        }

        /* Downloads */
        .card-dl { margin-top:.7rem; }
        .dl-row { display:flex;justify-content:space-between;align-items:baseline;margin-bottom:.3rem; }
        .dl-num { font-family:'Cinzel',serif;font-size:.8rem;font-weight:600;color:var(--text); }
        .dl-lbl { font-size:.6rem;color:var(--text-lo);letter-spacing:.06em;text-transform:uppercase; }
        .dl-track { height:3px;background:rgba(255,255,255,.06);border-radius:3px;overflow:hidden; }
        .dl-fill { height:100%;border-radius:3px;transition:width .8s cubic-bezier(.4,0,.2,1); }
        .fill-lav  { background:linear-gradient(90deg,var(--lav-dim),var(--lav-light)); }
        .fill-rose { background:linear-gradient(90deg,#be185d,var(--rose)); }
        .fill-teal { background:linear-gradient(90deg,#059669,var(--teal)); }

        /* Actions */
        .card-actions {
            display:flex;gap:.4rem;margin-top:.8rem;padding-top:.75rem;border-top:1px solid var(--border);
        }
        .ibtn {
            flex:1;display:flex;align-items:center;justify-content:center;gap:.4rem;
            padding:.45rem;border-radius:7px;border:1px solid var(--border);
            background:transparent;text-decoration:none;
            font-family:'DM Sans',sans-serif;font-size:.7rem;letter-spacing:.06em;text-transform:uppercase;
            cursor:pointer;transition:all .2s;
        }
        .ibtn svg { width:12px;height:12px; }
        .ibtn.ed { color:var(--lav); } .ibtn.ed svg { stroke:var(--lav); }
        .ibtn.ed:hover { background:rgba(167,139,250,.12);border-color:var(--lav);box-shadow:var(--glow); }
        .ibtn.dl { color:#f4a0a0; } .ibtn.dl svg { stroke:#f4a0a0; }
        .ibtn.dl:hover { background:rgba(244,114,182,.1);border-color:var(--rose);box-shadow:0 0 20px rgba(244,114,182,.28); }

        /* Empty state */
        .empty { text-align:center;padding:5rem 2rem;color:var(--text-lo);grid-column:1/-1; }
        .empty svg { width:48px;height:48px;stroke:var(--text-lo);margin-bottom:1rem;opacity:.4;display:block;margin-left:auto;margin-right:auto; }
        .empty p { font-size:.9rem;letter-spacing:.06em; }

        /* Footer */
        .bar {
            margin-top:2rem;display:flex;align-items:center;justify-content:space-between;
            padding-top:1rem;border-top:1px solid var(--border);
        }
        .bar span { font-size:.68rem;letter-spacing:.1em;text-transform:uppercase;color:var(--text-lo); }
        .live { display:inline-flex;align-items:center;gap:.4rem; }
        .live::before { content:'';width:6px;height:6px;border-radius:50%;background:var(--teal);box-shadow:0 0 8px var(--teal);animation:pl 2s infinite; }
        @keyframes pl { 0%,100%{opacity:1}50%{opacity:.3} }
		.logout-btn {
    width:100%;display:flex;align-items:center;gap:.5rem;justify-content:center;
    padding:.5rem .8rem;border-radius:8px;border:1px solid var(--border);
    background:transparent;color:var(--text-mid);font-family:'DM Sans',sans-serif;
    font-size:.72rem;letter-spacing:.06em;text-transform:uppercase;
    cursor:pointer;transition:all .2s;
}
.logout-btn:hover {
    background:rgba(244,114,182,.08);border-color:var(--rose);
    color:#f9a8d4;box-shadow:0 0 14px rgba(244,114,182,.2);
}
        @media(max-width:900px){
            .sidebar{display:none}.main{margin-left:0;padding:1.5rem 1rem 3rem}
            .cards-grid{grid-template-columns:1fr}.card-img{width:90px;min-width:90px}
        }
    </style>
</head>
<body>

<div class="orb orb-1"></div>
<div class="orb orb-2"></div>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="s-logo">
        <div class="mark">GameVerse<br>Academy</div>
        <div class="sub">Admin Panel</div>
    </div>
    <nav class="nav-sec">
        <div class="nav-lbl">Navigation</div>
        <a href="home.jsp" class="nav-a">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>Accueil
        </a>
        <a href="<%= request.getContextPath() %>/games" class="nav-a">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>Jeux
        </a>
        <a href="mods.jsp" class="nav-a active">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>Mods
        </a>
        <a href="utilisateurs.jsp" class="nav-a">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>Utilisateurs
        </a>
        <div class="nav-lbl" style="margin-top:1rem">Compte</div>
    </nav>
    <div class="s-foot">
    <div class="u-chip">
        <div class="u-av">
            <%
                String sessionUser = (String) session.getAttribute("email");
                String av = (sessionUser != null && sessionUser.length() >= 2)
                    ? sessionUser.substring(0,2).toUpperCase()
                    : (sessionUser != null ? sessionUser.toUpperCase() : "?");
            %>
            <%= av %>
        </div>
        <div>
            <div class="u-name"><%= sessionUser != null ? sessionUser : "Visiteur" %></div>
            <div class="u-role">Super Admin</div>
        </div>
    </div>
    <form action="<%= request.getContextPath() %>/logout" method="post" style="margin-top:.75rem;">
        <button type="submit" class="logout-btn">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"
                 style="width:13px;height:13px;">
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                <polyline points="16 17 21 12 16 7"/>
                <line x1="21" y1="12" x2="9" y2="12"/>
            </svg>
            Déconnexion
        </button>
    </form>
</div>
    
</aside>

<!-- MAIN -->
<main class="main">

    <div class="ph">
        <div class="ph-left">
            <div class="ey">GameVerse Academy</div>
            <h1>Bibliothèque Mods</h1>
            <p class="sub2">Gestion et supervision des modifications de </p>
        </div>
        <a href="<%= request.getContextPath() %>/submitMod" class="btn-add">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            Ajouter un mod
        </a>
    </div>
    

    <div class="ctrl">
        <div class="srch">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            <input type="text" id="searchInput" placeholder="Rechercher par titre, auteur…" oninput="filterCards()">
        </div>
        <div class="pills">
            <button class="pill active" onclick="setFilter('all',this)">Tous</button>
            <button class="pill" onclick="setFilter('Gameplay',this)">Gameplay</button>
            <button class="pill" onclick="setFilter('Graphisme',this)">Graphisme</button>
            <button class="pill" onclick="setFilter('Contenu',this)">Contenu</button>
        </div>
    </div>

    <div class="cards-grid" id="grid">
<%
    List<Mod> mods = (List<Mod>) request.getAttribute("mods");
    int MAX_DL = 100000;

    java.util.Map<String,String> imgMap = new java.util.HashMap<>();
    imgMap.put("dark souls", "https://cdn.akamai.steamstatic.com/steam/apps/570940/capsule_231x87.jpg");
    imgMap.put("skyrim",     "https://cdn.akamai.steamstatic.com/steam/apps/489830/capsule_231x87.jpg");
    imgMap.put("minecraft",  "https://cdn.akamai.steamstatic.com/steam/apps/1672970/capsule_231x87.jpg");
    imgMap.put("gta",        "https://cdn.akamai.steamstatic.com/steam/apps/271590/capsule_231x87.jpg");
    imgMap.put("cyberpunk",  "https://cdn.akamai.steamstatic.com/steam/apps/1091500/capsule_231x87.jpg");

    java.util.Map<String,String> fillMap = new java.util.HashMap<>();
    fillMap.put("Gameplay",  "fill-lav");
    fillMap.put("Graphisme", "fill-rose");
    fillMap.put("Contenu",   "fill-teal");

    if (mods != null && !mods.isEmpty()) {
        int idx = 0;
        for (Mod mod : mods) {
            idx++;
            String title     = mod.getTitle()    != null ? mod.getTitle()    : "";
            String category  = mod.getCategory() != null ? mod.getCategory() : "";
            String author    = mod.getAuthor()   != null ? mod.getAuthor()   : "";
            int    downloads = mod.getDownloads();
            int    pct       = Math.min(downloads * 100 / MAX_DL, 100);

            String imgSrc = "https://placehold.co/110x130/1a1729/a78bfa?text=MOD";
            String tl = title.toLowerCase();
            for (java.util.Map.Entry<String,String> e : imgMap.entrySet()) {
                if (tl.contains(e.getKey())) { imgSrc = e.getValue(); break; }
            }

            String badgeClass = fillMap.containsKey(category) ? "badge-" + category : "badge-default";
            String fillClass  = fillMap.getOrDefault(category, "fill-lav");
            String initials   = author.length() >= 2 ? author.substring(0,2).toUpperCase() : author.toUpperCase();
%>
        <div class="mod-card" data-category="<%= category %>">
            <div class="card-img">
                <img src="<%= imgSrc %>" alt="<%= title %>"
                     onerror="this.src='https://placehold.co/110x130/1a1729/a78bfa?text=MOD'"/>
                <div class="id-badge">#<%= String.format("%02d", mod.getId()) %></div>
            </div>
            <div class="card-body">
                <div>
                    <div class="card-title"><%= title %></div>
                    <span class="badge <%= badgeClass %>"><%= category.isEmpty() ? "—" : category %></span>
                    <div class="card-author">
                        <div class="author-av"><%= initials %></div>
                        <%= author %>
                    </div>
                    <div class="card-dl">
                        <div class="dl-row">
                            <span class="dl-num"><%= String.format("%,d", downloads).replace(',', ' ') %></span>
                            <span class="dl-lbl">téléchargements</span>
                        </div>
                        <div class="dl-track">
                            <div class="dl-fill <%= fillClass %>" style="width:0" data-pct="<%= pct %>"></div>
                        </div>
                    </div>
                </div>
                <div class="card-actions">
                    <a href="<%= request.getContextPath() %>/updateMod?id=<%= mod.getId() %>" class="ibtn ed">
                        Modifier
                    </a>
				    <a href="<%= request.getContextPath() %>/deleteMod?id=<%= mod.getId() %>" class="ibtn dl">
				    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
				        <polyline points="3 6 5 6 21 6"/>
				        <path d="M19 6l-1 14H6L5 6"/>
				        <path d="M10 11v6M14 11v6"/>
				        <path d="M9 6V4h6v2"/>
				    </svg>
				    Supprimer
				</a>
                </div>
            </div>
        </div>
<%
        }
    } else {
%>
        <div class="empty">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
            <p>Aucun mod trouvé.</p>
        </div>
<%
    }
%>
    </div>

    <div class="bar">
        <span class="live" id="countLabel"></span>
        <span>GameVerse Academy — Admin Panel</span>
    </div>

</main>

<script>
    document.querySelectorAll('.dl-fill').forEach(el => {
        const pct = parseInt(el.dataset.pct) || 0;
        setTimeout(() => el.style.width = pct + '%', 400);
    });

    function updateCount() {
        const cards = [...document.querySelectorAll('#grid .mod-card')];
        const n = cards.filter(c => c.style.display !== 'none').length;
        document.getElementById('countLabel').textContent =
            n + ' mod' + (n > 1 ? 's' : '') + ' affiché' + (n > 1 ? 's' : '');
    }
    updateCount();

    let af = 'all';
    function filterCards() {
        const q = document.getElementById('searchInput').value.toLowerCase();
        document.querySelectorAll('#grid .mod-card').forEach(card => {
            const ok = (af === 'all' || card.dataset.category === af) && card.textContent.toLowerCase().includes(q);
            card.style.display = ok ? '' : 'none';
        });
        updateCount();
    }
    function setFilter(cat, btn) {
        af = cat;
        document.querySelectorAll('.pill').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        filterCards();
    }
</script>
</body>
</html>
