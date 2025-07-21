# XRDP + XFCE Docker Image

## What is XRDP?
**XRDP** is an open-source implementation of the Microsoft Remote Desktop Protocol (RDP) server. It allows users to connect to a Linux machine using any RDP client (such as Windows Remote Desktop), providing a graphical interface to interact with the system remotely.

## What is XFCE?
**XFCE** is a lightweight, fast, and easy-to-use desktop environment for Unix-like operating systems. It is designed to be user-friendly while using minimal system resources, making it ideal for remote desktop scenarios.

## About This Dockerfile
This Dockerfile creates a containerized Ubuntu 22.04 environment with XRDP and XFCE pre-installed. It allows you to run a full desktop environment accessible via RDP.

### Key Steps in the Dockerfile:
- **Base Image:** Uses `ubuntu:22.04` as the base image.
- **Install Packages:** Installs XRDP, XFCE, and related utilities.
- **User Setup:** Creates a user named `docker` with password `docker` and adds them to the sudoers group.
- **Session Setup:** Configures XRDP to start an XFCE session for the user.
- **Autostart Terminal:** Sets up XFCE to automatically open a terminal window on login.
- **Expose Port:** Exposes port `3389` for RDP connections.
- **Startup Command:** Starts the XRDP services when the container launches.

## How to Build and Run

1. **Build the Docker Image:**
   ```sh
   docker build -t xrdp-xfce .
   ```

2. **Run the Container:**
   ```sh
   docker run -d -p 3390:3389 --name xrdp-xfce xrdp-xfce
   ```
   ```sh
   /usr/sbin/xrdp-sesman &
/usr/sbin/xrdp -n &
   ```

3. **Connect via RDP:**
   - Use any RDP client (e.g., Windows Remote Desktop Connection).
   - Connect to `127.0.0.1:3390` (or your Docker host's IP if running remotely).
   - Login with:
     - **Username:** `docker`
     - **Password:** `docker`

4. **Stop the Container:**
   ```sh
   docker stop xrdp-xfce
   ```

5. **Remove the Container:**
   ```sh
   docker rm xrdp-xfce
   ```

## Notes
- The desktop environment is XFCE, which is lightweight and suitable for remote desktop use.
- The default user is `docker` with password `docker`. Change this in production environments for security.
- You can customize the Dockerfile to install additional packages as needed. 