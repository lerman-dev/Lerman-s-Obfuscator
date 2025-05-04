# Lerman's Obfuscator

A simple Lua obfuscator designed for Roblox scripts.

## Features
- Variable renaming
- String encoding (into number arrays)
- Junk code insertion
- Code minification
- Line scrambling

## Installation
1. Extract the archive to any folder.
2. Ensure the `lua` folder exists and contains `lua54.exe` (Lua 5.4 interpreter).
   - If `lua54.exe` is missing, download it from [http://www.lua.org](http://www.lua.org) or [https://sourceforge.net/projects/luabinaries/](https://sourceforge.net/projects/luabinaries/) and place it in the `lua` folder.
3. Place your Lua script in a file named `script.lua` in the same folder as `obfuscator.lua`.

## Usage
1. Double-click `run.bat` or run from the command line with options: `run.bat [options]`
   - Options: `nojunk`, `nominify`, `noscramble`
2. The obfuscator will automatically read and obfuscate the script from `script.lua`.
3. Copy the obfuscated code from the console.

## Notes
- The script uses variable renaming, string encoding, junk code, minification, and line scrambling by default.
- If `script.lua` is not found or is empty, an error will be displayed.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
For issues or suggestions, contact me on Discord or Telegram. Discord: lerman228; Telegram: @lermandev
