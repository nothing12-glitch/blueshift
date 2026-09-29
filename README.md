# BlueShift Linux

Геймінговий дистрибутив на базі Fedora Atomic (Bazzite), зібраний за технологією
Universal Blue / BlueBuild — так само, як Bazzite, Bluefin та Aurora.

## Що всередині

| Компонент | Джерело |
|---|---|
| Fedora Atomic + KDE Plasma | базовий образ `ghcr.io/ublue-os/kinoite:stable` |
| gamemode, MangoHud, gamescope, steam-devices | RPM з репозиторіїв Fedora |
| Steam | Flatpak, встановлюється при збірці |
| Heroic Games Launcher (Epic/GOG) | Flatpak, встановлюється при збірці |
| Lutris | Flatpak, встановлюється при збірці |
| Plymouth-тема «BlueShift» | `system_files/usr/share/plymouth/themes/blueshift/` |
| MOTD-банер | `system_files/etc/motd.d/blueshift.motd` |
| Sysctl-твіки (vm.max_map_count, swappiness тощо) | `system_files/etc/sysctl.d/99-blueshift.conf` |

## Структура репозиторію

```
blueshift/
├── Containerfile                  # шар BlueShift поверх Bazzite
├── .github/workflows/build.yml    # збірка образу в GitHub Actions
└── system_files/                  # файли автоматично копіюються в образ
    ├── etc/
    │   ├── motd.d/blueshift.motd
    │   ├── plymouth/plymouthd.conf
    │   └── sysctl.d/99-blueshift.conf
    └── usr/share/plymouth/themes/blueshift/
        ├── blueshift.plymouth
        └── blueshift.script
```

## Як зібрати (без локального Fedora)

1. Створи новий публічний репозиторій на GitHub, наприклад `blueshift`.
2. Завантаж туди всі файли з цієї структури (через веб-інтерфейс GitHub:
   *Add file → Create new file*, зберігаючи шляхи).
3. GitHub Actions автоматично збере образ:
   - контейнер публікується в `ghcr.io/<твій-нік>/blueshift`;
   - після збірки у вкладці **Actions** з'явиться артефакт-інсталятор (ISO)
     для встановлення на реальну машину чи у віртуалку.
4. Щоб зробити репозиторій публічним для образів:
   GitHub → твій профіль → *Packages* → `blueshift` → *Change visibility* → Public.

## Встановлення

З артефакту інсталятора (з вкладки Actions) або командою на будь-якій Fedora Atomic:

```bash
sudo bootc switch ghcr.io/<твій-нік>/blueshift:latest
```

## Кастомні шпалери

Поклади свій PNG у `system_files/usr/share/backgrounds/blueshift.png` —
він потрапить в образ. Далі його можна встановити як шпалери через GNOME/KDE.

## Оновлення

Образ перебудовується автоматично щопонеділка (schedule у workflow) і при
кожному push у main. На встановленій системі: `sudo rpm-ostree upgrade`.
