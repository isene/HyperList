#!/bin/bash
# Terminal restoration script for when things go wrong

echo "Restoring terminal to sane state..."

# Reset terminal to sane defaults
stty sane 2>/dev/null

# Clear any raw mode settings
stty echo 2>/dev/null
stty icanon 2>/dev/null
stty icrnl 2>/dev/null

# Reset terminal completely
tput reset 2>/dev/null
reset 2>/dev/null

# Clear screen
clear

# Show cursor
tput cnorm 2>/dev/null
echo -e "\033[?25h"  # ANSI escape to show cursor

echo "Terminal restored!"
echo ""
echo "If your terminal is still broken, try:"
echo "  1. Close and reopen your terminal"
echo "  2. Run: reset"
echo "  3. Run: stty sane"
echo ""
echo "To check terminal state:"
echo "  stty -a"