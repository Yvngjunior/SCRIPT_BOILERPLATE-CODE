#!/bin/bash
# =====================================
# 🔥 Universal Project Boilerplate Generator + GitHub Init
# Supports: HTML/CSS/JS, Python, Bash
# =====================================

clear
figlet -f slant "Loading..." | lolcat
echo "🚀 Universal Project Boilerplate Setup" | lolcat
echo "----------------------------------------"

# Ask for project name
read -p "Enter your project name: " PROJECT_NAME
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# Ask what stacks to include
echo ""
echo "Select what to include:"
echo "1) Web (HTML/CSS/JS)"
echo "2) Python"
echo "3) Bash"
echo "4) All of the above"
read -p "Enter your choice (1-4): " CHOICE

# -------------------------------
# 🕸️ WEB STACK
# -------------------------------
if [[ "$CHOICE" == "1" || "$CHOICE" == "4" ]]; then
    echo "Creating web project structure..."
    mkdir -p web/{css,js,assets}

    cat > web/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Cool Project</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
    <div class="wrapper">
        <h1>🚀 Welcome to My Project</h1>
        <p>This is a centered page powered by your boilerplate.</p>
        <button onclick="sayHello()">Click Me</button>
    </div>
    <script src="js/app.js"></script>
</body>
</html>
EOF

    cat > web/css/style.css <<'EOF'
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: "Poppins", sans-serif;
}
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background: linear-gradient(135deg, #1e1e2f, #3a3a6a);
    color: white;
}
.wrapper {
    text-align: center;
    background: rgba(255,255,255,0.1);
    padding: 2rem 3rem;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
}
button {
    background: #00bcd4;
    border: none;
    color: white;
    padding: 10px 20px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1rem;
    transition: 0.3s;
}
button:hover {
    background: #0097a7;
}
EOF

    cat > web/js/app.js <<'EOF'
function sayHello() {
    alert("Hello from your boilerplate setup!");
}
EOF
fi

# -------------------------------
# 🐍 PYTHON STACK
# -------------------------------
if [[ "$CHOICE" == "2" || "$CHOICE" == "4" ]]; then
    echo "Creating Python project structure..."
    mkdir -p python
    cat > python/main.py <<'EOF'
def main():
    print("🚀 Hello from your Python boilerplate!")

if __name__ == "__main__":
    main()
EOF
fi

# -------------------------------
# 🐚 BASH STACK
# -------------------------------
if [[ "$CHOICE" == "3" || "$CHOICE" == "4" ]]; then
    echo "Creating Bash script..."
    mkdir -p bash
    cat > bash/run.sh <<'EOF'
#!/bin/bash
echo "🚀 Hello from your Bash boilerplate!"
EOF
    chmod +x bash/run.sh
fi

# -------------------------------
# 📦 Local Git Setup
# -------------------------------
git init -q
echo "# $PROJECT_NAME" > README.md
echo "node_modules/" > .gitignore
git add .
git commit -m "Initial boilerplate setup" -q

# -------------------------------
# 🧠 Optional GitHub Setup
# -------------------------------
echo ""
read -p "Do you want to create and push this to GitHub? (y/n): " PUSH_GH

if [ "$PUSH_GH" = "y" ]; then
    if ! command -v gh &> /dev/null; then
        echo "Installing GitHub CLI (gh)..."
        sudo apt-get update -y && sudo apt-get install gh -y
    fi

    echo "Authenticating with GitHub..."
    gh auth status || gh auth login

    echo "Creating GitHub repo '$PROJECT_NAME'..."
    gh repo create "$PROJECT_NAME" --public --source=. --remote=origin --push
fi

# -------------------------------
# ⚡ Optional Live Server
# -------------------------------
if [[ "$CHOICE" == "1" || "$CHOICE" == "4" ]]; then
    echo ""
    read -p "Do you want to start a live server for your web project? (y/n): " RUN_SERVER
    if [ "$RUN_SERVER" = "y" ]; then
        if ! command -v live-server &> /dev/null; then
            echo "Installing live-server..."
            npm install -g live-server
        fi
        echo "Starting live-server on http://localhost:5500 ..."
        cd web && live-server --port=5500
    fi
fi

echo ""
echo "✅ Setup complete! Your project '$PROJECT_NAME' is ready."

