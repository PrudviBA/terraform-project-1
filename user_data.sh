#!/bin/bash
sudo apt update
sudo apt install -y apache2

# Start and enable Apache service
sudo systemctl start apache2
sudo systemctl enable apache2

# Create HTML file
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Hello from Terraform</title>
  <style>
    body {
      background: linear-gradient(to right, #667eea, #764ba2);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: white;
      text-align: center;
      padding-top: 100px;
      animation: fadeIn 2s ease-in-out;
    }
    h1 { font-size: 4em; margin-bottom: 10px; }
    p { font-size: 1.5em; margin-bottom: 30px; }
    .button {
      background-color: #ffffff;
      border: none;
      color: #764ba2;
      padding: 15px 30px;
      text-decoration: none;
      font-size: 1em;
      border-radius: 30px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    .button:hover { background-color: #ddd; }
    @keyframes fadeIn {
      0% { opacity: 0; transform: translateY(-20px); }
      100% { opacity: 1; transform: translateY(0); }
    }
    footer {
      position: fixed;
      bottom: 10px;
      width: 100%;
      font-size: 0.9em;
      color: #e0e0e0;
    }
  </style>
</head>
<body>
  <h1>Hello from Terraform!</h1>
  <p>🚀 Deployed on an Ubuntu EC2 Instance using Terraform</p>
  <a href="#" class="button">Explore More</a>
  <footer>
    Made with ❤️ by Prudvi | Project for DevOps Internship
  </footer>
</body>
</html>
EOF
