this is a script designed to get a **good start** for linux support.

# main objectives:
[🟩] done | [🟨] in progress | [🟥] todo
- [🟩] fix fonts for linux (literally edits font files to force correct names)
- [🟩] fix folder and file names to be correct
- [🟨] fix logbase to work on linux
- [🟥] fix fonts to be loaded on both windows and linux perfectly without having to install (requires rewriting clientscheme parsing)
- [🟥] resize icon fonts to work on linux, and create [$POSIX] entries for each.

# running:

1. paste the `linux scripts` folder and the `fix_hud.sh` file next to the hud

2. open a terminal next to the hud (**right click > Open Terminal Here** on most distros)

3. in the new terminal run the following command
```
./fix_hud.sh [HUD FOLDER]
```
where `[HUD FOLDER]` is the current folder name of the hud.
