<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html data-theme="light">

<head>

    <title>Login</title>

    <style>

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

        }

        

        h1 {

            text-align: center;

            margin-bottom: 24px;

            font-weight: 700;

            font-size: 28px;

            color: var(--primary-color);

        }

        

        form {

            display: flex;

            flex-direction: column;

            gap: 16px;

        }

        

        .form-group {

            position: relative;

        }

        

        label {

            display: block;

            margin-bottom: 8px;

            font-weight: 500;

            font-size: 14px;

        }

        

        input {

            width: 100%;

            padding: 12px 16px;

            border: 1px solid rgba(148, 163, 184, 0.2);

            border-radius: 8px;

            background: var(--input-bg);

            color: var(--text-color);

            font-size: 16px;

            transition: all 0.3s;

        }

        

        input:focus {

            outline: none;

            border-color: var(--primary-color);

            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.3);

        }

        

        button {

            background: var(--primary-color);

            color: white;

            padding: 12px;

            border: none;

            border-radius: 8px;

            cursor: pointer;

            font-weight: 600;

            font-size: 16px;

            transition: background 0.3s;

            margin-top: 8px;

        }

        

        button:hover {

            background: var(--primary-hover);

        }

        

        .error-messages {

            background-color: rgba(239, 68, 68, 0.1);

            border-left: 4px solid var(--error-color);

            padding: 12px;

            border-radius: 4px;

            margin-bottom: 16px;

        }

        

        .error-messages p {

            color: var(--error-color);

            font-size: 14px;

            margin: 0;

        }

        

        .login-link {

            text-align: center;

            margin-top: 24px;

            font-size: 14px;

        }

        

        .login-link a {

            color: var(--primary-color);

            text-decoration: none;

            font-weight: 500;

        }

        

        .login-link a:hover {

            text-decoration: underline;

        }

    </style>

</head>

<body>

    <!-- Starry background -->

    <div id="stars-container"></div>



    <!-- Theme toggle button -->

    <button class="theme-toggle" onclick="toggleTheme()">

        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"

             stroke-width="2" stroke-linecap="round" stroke-linejoin="round">

            <circle cx="12" cy="12" r="5"></circle>

            <line x1="12" y1="1"  x2="12" y2="3"></line>

            <line x1="12" y1="21" x2="12" y2="23"></line>

            <line x1="4.22" y1="4.22"   x2="5.64" y2="5.64"></line>

            <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>

            <line x1="1"     y1="12"    x2="3"    y2="12"></line>

            <line x1="21"    y1="12"    x2="23"   y2="12"></line>

            <line x1="4.22"  y1="19.78" x2="5.64" y2="18.36"></line>

            <line x1="18.36" y1="5.64"  x2="19.78" y2="4.22"></line>

        </svg>

    </button>



    <div class="card">

        <h1>Login</h1>



        <c:if test="${not empty error}">

            <div class="error-messages">

                <p>${error}</p>

            </div>

        </c:if>

        

        <!-- Login form -->

        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="form-group">

                <label for="username">Username</label>

                <input type="text" id="username" name="username" required />

            </div>

            

            <div class="form-group">

                <label for="password">Password</label>

                <input type="password" id="password" name="password" required />

            </div>

            

            <button type="submit">Login</button>

        </form>

        

        <div class="login-link">

            Don't have an account?

            <a href="${pageContext.request.contextPath}/register">Register here</a>

        </div>

    </div>

    

    <script>

        // Theme toggling

        function toggleTheme() {

            const html = document.documentElement;

            const theme = html.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';

            html.setAttribute('data-theme', theme);

            localStorage.setItem('theme', theme);

            updateStarColors();

        }



        // Initialize theme from localStorage

        const savedTheme = localStorage.getItem('theme') || 'dark';

        document.documentElement.setAttribute('data-theme', savedTheme);



        // Create stars

        const starsContainer = document.getElementById('stars-container');

        const numStars = 150;

        

        function createStars() {

            for (let i = 0; i < numStars; i++) {

                const star = document.createElement('div');

                star.className = 'star';

                

                // Random position

                const x = Math.random() * 100;

                const y = Math.random() * 100;

                

                // Random size

                const size = Math.random() * 3;

                

                star.style.left = `${x}%`;

                star.style.top = `${y}%`;

                star.style.width = `${size}px`;

                star.style.height = `${size}px`;

                

                // Random twinkle

                const duration = 2 + Math.random() * 3;

                const delay = Math.random() * 5;

                star.style.animation = `twinkle ${duration}s ${delay}s infinite`;

                

                starsContainer.appendChild(star);

            }

        }



        // Update star color based on theme

        function updateStarColors() {

            const stars = document.querySelectorAll('.star');

            const theme = document.documentElement.getAttribute('data-theme');

            const color = theme === 'dark' ? 'white' : '#3b82f6';

            

            stars.forEach(star => {

                star.style.backgroundColor = color;

            });

        }



        // Parallax star movement

        document.addEventListener('mousemove', (e) => {

            const mouseX = e.clientX / window.innerWidth;

            const mouseY = e.clientY / window.innerHeight;

            

            const stars = document.querySelectorAll('.star');

            stars.forEach((star, index) => {

                // Different factor => subtle parallax

                const factor = 0.01 + (index % 5) * 0.005;

                star.style.transform = `translate(${(mouseX - 0.5) * factor * 100}px, 

                                                  ${(mouseY - 0.5) * factor * 100}px)`;

            });

        });



        // Twinkle keyframe

        const style = document.createElement('style');

        style.textContent = `

            @keyframes twinkle {

                0%   { opacity: 0.3; }

                50%  { opacity: 1;   }

                100% { opacity: 0.3; }

            }

        `;

        document.head.appendChild(style);

        

        // Init stars

        createStars();

        updateStarColors();

    </script>

</body>

</html>
