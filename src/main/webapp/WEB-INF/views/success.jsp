<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <title>Registration Successful</title>
    <style>
        /* Same CSS variables and base styles as register.jsp */
        :root {
            --bg-color: #0f172a;
            --text-color: #f8fafc;
            --primary-color: #3b82f6;
            --primary-hover: #2563eb;
            --input-bg: rgba(30, 41, 59, 0.8);
            --card-bg: rgba(15, 23, 42, 0.8);
            --error-color: #ef4444;
            --success-color: #10b981;
        }
        
        [data-theme="light"] {
            --bg-color: #f1f5f9;
            --text-color: #1e293b;
            --input-bg: rgba(255, 255, 255, 0.8);
            --card-bg: rgba(255, 255, 255, 0.9);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.3s, color 0.3s;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }
        
        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
        }
        
        #stars-container {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            overflow: hidden;
        }
        
        .star {
            position: absolute;
            background-color: #fff;
            border-radius: 50%;
            filter: blur(1px);
            opacity: 0.7;
            transition: transform 1s ease-out;
        }
        
        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--input-bg);
            color: var(--text-color);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 10;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 40px;
            width: 90%;
            max-width: 440px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            z-index: 5;
            position: relative;
            text-align: center;
        }
        
        h1 {
            text-align: center;
            margin-bottom: 24px;
            font-weight: 700;
            font-size: 28px;
            color: var(--primary-color);
        }
        
        .success-message {
            margin: 20px 0;
            font-size: 16px;
        }
        
        .btn-primary {
            background: var(--primary-color);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
            transition: background 0.3s;
            text-decoration: none;
            display: inline-block;
            margin: 8px;
        }
        
        .btn-primary:hover {
            background: var(--primary-hover);
        }
        
        .links-container {
            margin-top: 24px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
    </style>
</head>
<body>
    <div id="stars-container"></div>
    
    <button class="theme-toggle" onclick="toggleTheme()">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="5"></circle>
            <line x1="12" y1="1" x2="12" y2="3"></line>
            <line x1="12" y1="21" x2="12" y2="23"></line>
            <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
            <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
            <line x1="1" y1="12" x2="3" y2="12"></line>
            <line x1="21" y1="12" x2="23" y2="12"></line>
            <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
            <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
        </svg>
    </button>
    
    <div class="card">
        <h1>Registration Successful! 🎉</h1>
        
        <div class="success-message">
            <p>Welcome, <strong>${user.username}</strong>!</p>
            <p>Your email: <strong>${user.email}</strong> is now registered.</p>
        </div>
        
        <div class="links-container">
            <a href="${pageContext.request.contextPath}/home" class="btn-primary">
                Go to Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/register" class="btn-primary" style="background: transparent; color: var(--primary-color); border: 2px solid var(--primary-color);">
                Back to Registration
            </a>
        </div>
    </div>

    <script>
        // Same interactive scripts as register.jsp
        function toggleTheme() {
            const html = document.documentElement;
            const theme = html.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
            html.setAttribute('data-theme', theme);
            localStorage.setItem('theme', theme);
            updateStarColors();
        }
        
        // Initialize theme
        const savedTheme = localStorage.getItem('theme') || 'dark';
        document.documentElement.setAttribute('data-theme', savedTheme);
        
        // Starfield animation
        const starsContainer = document.getElementById('stars-container');
        const numStars = 150;
        
        function createStars() {
            for (let i = 0; i < numStars; i++) {
                const star = document.createElement('div');
                star.className = 'star';
                star.style.left = `${Math.random() * 100}%`;
                star.style.top = `${Math.random() * 100}%`;
                star.style.width = `${Math.random() * 3}px`;
                star.style.height = star.style.width;
                star.style.animation = `twinkle ${2 + Math.random() * 3}s ${Math.random() * 5}s infinite`;
                starsContainer.appendChild(star);
            }
        }
        
        function updateStarColors() {
            document.querySelectorAll('.star').forEach(star => {
                star.style.backgroundColor = document.documentElement.getAttribute('data-theme') === 'dark' ? 'white' : '#3b82f6';
            });
        }
        
        document.addEventListener('mousemove', (e) => {
            const stars = document.querySelectorAll('.star');
            stars.forEach((star, index) => {
                const factor = 0.01 + (index % 5) * 0.005;
                star.style.transform = `translate(
                    ${(e.clientX/window.innerWidth - 0.5) * factor * 100}px, 
                    ${(e.clientY/window.innerHeight - 0.5) * factor * 100}px
                )`;
            });
        });
        
        // Add twinkle animation
        const style = document.createElement('style');
        style.textContent = `@keyframes twinkle {
            0%, 100% { opacity: 0.3; }
            50% { opacity: 1; }
        }`;
        document.head.appendChild(style);
        
        // Initialize
        createStars();
        updateStarColors();
    </script>
</body>
</html>