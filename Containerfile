FROM ghcr.io/ublue-os/kinoite:stable

# ===== BlueShift Linux =====
LABEL org.opencontainers.image.title="BlueShift Linux"
LABEL org.opencontainers.image.description="Fedora Atomic gaming distribution"

# Branding: Plymouth theme, MOTD, sysctl tweaks
COPY system_files /

# Rename the distro in os-release
RUN sed -i \
      -e 's/^NAME=.*/NAME="BlueShift Linux"/' \
      -e 's/^PRETTY_NAME=.*/PRETTY_NAME="BlueShift Linux"/' \
      /usr/lib/os-release

# Gaming tools from Fedora repos:
#   gamemode   - optimization daemon (CPU governor, priority)
#   mangohud   - FPS/temperature overlay
#   gamescope  - SteamOS-style nested game compositor
#   steam-devices - udev rules for game controllers
RUN dnf install -y \
        gamemode \
        mangohud \
        gamescope \
        steam-devices && \
    dnf clean all

# Gaming launchers as system Flatpaks
RUN flatpak remote-add --if-not-exists --system flathub https://dl.flathub.org/repo/flathub.flatpakrepo && \
    flatpak install --system --noninteractive flathub \
        com.valvesoftware.Steam \
        com.heroicgameslauncher.hgl \
        net.lutris.Lutris
