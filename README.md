# BlueShift Linux

Геймінговий дистрибутив на базі Fedora Atomic (KDE Plasma), зібраний за
технологією Universal Blue / BlueBuild — так само, як Bazzite, Bluefin та Aurora.

## Що всередині

| Компонент | Джерело |
|---|---|
| Fedora Atomic + KDE Plasma | базовий образ `ghcr.io/ublue-os/kinoite:stable` |
| gamemode, MangoHud, gamescope, steam-devices | RPM з репозиторіїв Fedora (модуль `dnf`) |
| Steam, Heroic (Epic/GOG), Lutris | системні Flatpak (модуль `default-flatpaks`) |
| Plymouth-тема «BlueShift» | `files/system/usr/share/plymouth/themes/blueshift/` |
| MOTD-банер | `files/system/etc/motd.d/blueshift.motd` |
| Sysctl-твіки (vm.max_map_count, swappiness тощо) | `files/system/etc/sysctl.d/99-blueshift.conf` |
| Назва «BlueShift Linux» у системі | `files/scripts/rename.sh` |

## Структура репозиторію

```
blueshift/
├── recipes/recipe.yml           # рецепт образу (база + модулі)
├── cosign.pub                   # публічний ключ підпису образу
├── .github/workflows/build.yml  # збірка в GitHub Actions
└── files/
    ├── scripts/rename.sh        # перейменування дистрибутива
    └── system/                  # копіюється в корінь образу
        ├── etc/
        │   ├── motd.d/blueshift.motd
        │   ├── plymouth/plymouthd.conf
        │   └── sysctl.d/99-blueshift.conf
        └── usr/share/plymouth/themes/blueshift/
            ├── blueshift.plymouth
            └── blueshift.script
```

## Як зібрати (без локального Fedora)

1. Збірку повністю виконує GitHub Actions (action `blue-build/github-action`).
2. Образ публікується в `ghcr.io/<твій-нік>/blueshift` і підписується cosign
   (приватний ключ лежить у секреті репозиторію `SIGNING_SECRET`).
3. Автоперебудова: при кожному push у `main` та щопонеділка о 06:00 UTC.

## Встановлення

На будь-якій Fedora Atomic (Silverblue/Kinoite) або іншому bootc-дистрибутиві:

```bash
sudo bootc switch ghcr.io/<твій-нік>/blueshift:stable
systemctl reboot
```

Щоб образ бачили інші — зроби пакет публічним:
GitHub → профіль → **Packages** → `blueshift` → **Package settings** →
**Change visibility** → Public.

## Кастомні шпалери

Поклади свій PNG у `files/system/usr/share/backgrounds/blueshift.png` —
він потрапить в образ. Далі його можна встановити як шпалери через KDE.

## Оновлення на встановленій системі

```bash
sudo bootc upgrade && systemctl reboot   # або: sudo rpm-ostree upgrade
```

Відкат на попередню версію: `sudo bootc rollback` з меню завантаження.
