FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic packages, xfce and xrdp
RUN apt update && apt install -y \
    sudo \
    xrdp \
    xfce4 \
    xfce4-terminal \
    dbus-x11 \
    x11-xserver-utils \
    && apt clean

# Create a new user
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Set up xrdp
RUN echo xfce4-session > /home/docker/.xsession && \
    chown docker:docker /home/docker/.xsession

# Allow xrdp to work with xfce
RUN sed -i.bak '/^test -x \/etc\/X11\/Xsession && exec \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh && \
    echo "startxfce4" >> /etc/xrdp/startwm.sh


EXPOSE 3389

# Start xrdp service
CMD ["/bin/bash", "-c", "/usr/sbin/xrdp-sesman && /usr/sbin/xrdp -n"]

RUN mkdir -p /home/docker/.config/autostart && \
    echo "[Desktop Entry]\nType=Application\nExec=xfce4-terminal\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName=Terminal" > /home/docker/.config/autostart/xfce4-terminal.desktop && \
    chown -R docker:docker /home/docker/.config



