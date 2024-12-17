---

# **Born2beroot Project**

## **Project Overview**
This repository contains scripts and configurations for setting up a secure and functional Debian-based virtual machine for server management. The project includes services that support WordPress and a bonus service for easier system administration:
- **Lighttpd**: A lightweight web server for serving WordPress.  
- **MariaDB**: A database server for managing WordPress data.  
- **Webmin**: A web-based system administration tool (bonus service).  

---

## **Table of Contents**
1. [About Born2beroot](#about-born2beroot)  
2. [Project Goals](#project-goals)  
3. [System Requirements](#system-requirements)  
4. [Setup Instructions](#setup-instructions)  
5. [WordPress Deployment](#wordpress-deployment)  
6. [Webmin Configuration](#webmin-configuration)  
7. [Testing and Access](#testing-and-access)  
8. [Security Considerations](#security-considerations)  
9. [Resources](#resources)  

---

## **About Born2beroot**
Born2beroot is a system administration project designed to teach you how to:
- Set up a secure virtual machine with essential services.  
- Deploy WordPress using **Lighttpd** and **MariaDB**.  
- Integrate a web-based administration tool like **Webmin**.  

This setup improves understanding of web servers, databases, and Linux system management.

---

## **Project Goals**
- Deploy **Lighttpd** as a lightweight web server for WordPress.  
- Set up **MariaDB** as the database server for WordPress.  
- Add **Webmin** for system administration as a bonus service.  
- Apply proper security configurations (e.g., `sudo`, firewall, SSH).

---

## **System Requirements**
- **Debian 12 (Bookworm)** or a compatible Debian-based system.  
- Virtualization software: VirtualBox or VMware.  
- Internet connection for package installation.  
- `sudo` privileges for installation.

---

## **Setup Instructions**

### **1. System Update**
Update and upgrade the system:  
```bash
sudo apt update && sudo apt upgrade -y
```

---

### **2. Install Lighttpd**
Lighttpd will serve WordPress content efficiently.  
```bash
sudo apt install lighttpd -y
sudo systemctl enable lighttpd
sudo systemctl start lighttpd
```
- Verify Lighttpd is running:  
   ```bash
   sudo systemctl status lighttpd
   ```
- Allow HTTP traffic on the firewall:  
   ```bash
   sudo ufw allow 80/tcp
   ```

---

### **3. Install MariaDB**
MariaDB will handle the WordPress database.  
```bash
sudo apt install mariadb-server -y
sudo systemctl enable mariadb
sudo systemctl start mariadb
```

- Secure the database installation:  
   ```bash
   sudo mysql_secure_installation
   ```
   Follow the prompts to:
   - Set a root password.  
   - Remove test databases and users.  

- Create a WordPress database and user:  
   ```sql
   sudo mysql -u root -p
   CREATE DATABASE wordpress;
   CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'your_password';
   GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   ```

---

### **4. Install PHP**
PHP is required for WordPress to function.  
```bash
sudo apt install php php-cgi php-mysql php-fpm -y
sudo systemctl restart lighttpd
```

---

## **WordPress Deployment**

1. **Download WordPress**:  
   ```bash
   wget https://wordpress.org/latest.tar.gz
   tar -xzvf latest.tar.gz
   sudo mv wordpress /var/www/html/
   ```

2. **Configure WordPress**:  
   ```bash
   sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
   sudo nano /var/www/html/wordpress/wp-config.php
   ```
   Update the database details:  
   ```php
   define('DB_NAME', 'wordpress');
   define('DB_USER', 'wp_user');
   define('DB_PASSWORD', 'your_password');
   define('DB_HOST', 'localhost');
   ```

3. **Set Permissions**:  
   ```bash
   sudo chown -R www-data:www-data /var/www/html/wordpress
   ```

4. **Test WordPress**:  
   Open your browser and navigate to:  
   ```
   http://<server-ip>/wordpress
   ```
   Follow the on-screen setup instructions.

---

## **5. Install Webmin (Bonus Service)**
Webmin provides a user-friendly web interface for managing your server.

1. **Add Webmin GPG Key and Repository**:  
   ```bash
   wget -qO- http://www.webmin.com/jcameron-key.asc | sudo tee /etc/apt/trusted.gpg.d/webmin.asc
   sudo sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
   ```

2. **Install Webmin**:  
   ```bash
   sudo apt update
   sudo apt install webmin -y
   ```

3. **Access Webmin**:  
   - Open your browser and navigate to:  
     ```
     https://<server-ip>:10000
     ```
   - Log in with your root credentials.

---

## **Services Included**

| **Service**       | **Purpose**                                  | **Access**                  |
|--------------------|----------------------------------------------|-----------------------------|
| **Lighttpd**       | Lightweight web server for WordPress.        | `http://<server-ip>/wordpress` |
| **MariaDB**        | Database server for WordPress.               | Access via terminal.        |
| **Webmin**         | Web-based tool for system administration.    | `https://<server-ip>:10000` |

---

## **Security Considerations**
- Use strong passwords for the database, Webmin, and system users.  
- Restrict access to Webmin to trusted IPs only.  
- Enable a firewall:  
   ```bash
   sudo ufw allow 80/tcp   # HTTP
   sudo ufw allow 10000/tcp # Webmin
   sudo ufw enable
   ```

---

## **Resources**
- [WordPress Documentation](https://wordpress.org/documentation/)  
- [Lighttpd Documentation](https://redmine.lighttpd.net/)  
- [MariaDB Documentation](https://mariadb.org/documentation/)  
- [Webmin Documentation](http://www.webmin.com/docs.html)  
- Original Guide: [Born2beroot Guide](https://baigal.medium.com/born2beroot-e6e26dfb50ac)  

---


This **README** now clarifies the roles of **Lighttpd** and **MariaDB** for WordPress and highlights **Webmin** as a bonus service. Let me know if you need further adjustments! 🚀
