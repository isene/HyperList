# HyperList TUI

[![Gem Version](https://badge.fury.io/rb/hyperlist.svg)](https://badge.fury.io/rb/hyperlist)
[![License](https://img.shields.io/badge/License-Public%20Domain-brightgreen.svg)](https://unlicense.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.0%2B-red.svg)](https://www.ruby-lang.org/)
[![GitHub stars](https://img.shields.io/github/stars/isene/HyperList.svg)](https://github.com/isene/HyperList/stargazers)
[![Stay Amazing](https://img.shields.io/badge/Stay-Amazing-blue.svg)](https://isene.org)

<img src="img/hyperlist_logo.svg" align="left" width="150" height="150">
<br clear="left"/>

A powerful Terminal User Interface (TUI) application for creating, editing, and managing HyperLists - a methodology for describing anything in a hierarchical, structured format.

<br clear="left"/>

## What is HyperList?

HyperList is a universal methodology for describing anything - any state, item, pattern, action, process, transition, program, instruction set, etc. It can be used as an outliner, a todo list handler, a process design tool, a data modeler, or any other way you want to describe something.

Learn more about the HyperList methodology at: [https://isene.org/hyperlist/](https://isene.org/hyperlist/)

For historical context and the original VIM implementation, see: [hyperlist.vim](https://github.com/isene/hyperlist.vim)

## Screenshots

### Main Interface
![HyperList Main View](img/screenshot_sample.png)

### Help Screen
![HyperList Help](img/screenshot_help.png)

## What's New in v1.9.0

### 🏷️ Item Tagging & Batch Operations
- **Tag items**: Press 't' to tag/untag items for batch operations
- **Auto-advance**: Cursor automatically moves to next item after tagging for fast consecutive tagging
- **Visual feedback**: Tagged items show dark blue background, lighter blue when selected
- **Status indicator**: Shows `[T:N]` in status line with count of tagged items
- **Clear tags**: Press 'u' to clear all tags
- **Regex tagging**: Press 'C-T' to tag all items matching a regex pattern
- **Batch operations**: Delete (D/C-D), yank (y/Y), and indent (Tab/S-Tab) work on all tagged items
- Tag consecutive or non-consecutive items, then perform operations on the entire set

### ✏️ External Editor Support
- **Edit in $EDITOR**: Press 'E' to spawn your preferred editor (vim, nano, emacs, etc.)
- **Seamless workflow**: File saved automatically, editor launched, changes reloaded on exit
- **Terminal management**: Terminal state properly saved and restored
- Uses `$EDITOR` environment variable (defaults to vi if not set)

### 📋 Enhanced Paste & Navigation
- **Paste above**: Press 'P' to paste above current item (vim-style)
- **Paste below**: Press 'p' to paste below current item (existing)
- **Presentation mode**: Moved to 'C-P' (was 'P') for consistency
- **Templates**: Moved to 'T' key (was 't')
- **Undo**: Moved to 'U' key (was 'u') - consistent with RTFM

### 🎯 Smart Modified Flag
- **Intelligent tracking**: `[+]` indicator automatically removed when undoing back to original file state
- **Clean status**: No false "modified" indicator after complete undo to original

## Previous Release: v1.8.0

### 📋 Multi-Line Paste Support
- **Paste multiple lines**: When pasting multi-line content into item insertion prompts ('o', 'O', 'a', 'A'), each line becomes a separate item
- **Visual feedback**: Shows `[+N lines]` indicator during multi-line paste
- **Smart insertion**: All pasted lines inserted as siblings at the same level
- Great for importing bullet lists from PDFs, emails, or other documents
- Requires rcurses 6.1.5+

### 📄 PDF/LaTeX Export
- **Export to PDF**: `:export pdf filename.pdf` - Full LaTeX-based PDF generation
- **Export to LaTeX**: `:export latex filename.tex` - Get the LaTeX source
- **Professional output**: Color-coded elements, table of contents, headers
- **Complete HyperList support**: All syntax elements rendered beautifully
- Requires: texlive-latex-base and texlive-latex-extra packages

### 📋 System Clipboard Integration
- **Yank to clipboard**: 'y' and 'Y' now copy to system clipboard
- **Middle-click paste**: Yanked items can be pasted into other terminals
- **Preserves indentation**: Copied text maintains proper structure

## Previous Version Features (v1.4.0)

### 🎨 Configuration Lines & Theming
- **Configuration Lines**: Add settings at the bottom of HyperList files using `((option=value, option2=value))`
- **Theme Support**: Three color themes - `light` (bright colors), `normal` (standard), `dark` (for light terminals)
- **Line Wrapping**: Enable with `wrap=yes` - wrapped lines use `+` prefix per HyperList spec
- **Line Numbers**: Enable with `show_numbers=yes`
- **Manual Configuration**: Use `:set option=value` to change settings on the fly
- **View Settings**: Use `:set` to see all settings, `:set option` to see one setting
- **Auto-apply**: Settings from config lines are applied when files are loaded
- **Invisible Config Lines**: Config lines are stored but never displayed in the editor
- **Persistent Settings**: All `:set` commands automatically update the config line in the file

### Configuration Options
- `theme` - Color theme: light, normal, or dark
- `wrap` - Line wrapping: yes or no
- `show_numbers` - Show line numbers: yes or no
- `fold_level` - Default fold level: 0-99 (0=all folded, 99=all open)
- `auto_save` - Enable auto-save: yes or no
- `auto_save_interval` - Auto-save frequency in seconds
- `tab_width` - Indentation width: 2-8 spaces

Example config line: `((theme=dark, wrap=yes, fold_level=2))`

### Using Configuration

#### Per-File Configuration
Add a configuration line at the bottom of any HyperList file:
```
My HyperList
    Item 1
    Item 2

((fold_level=2, theme=light))
```

#### Runtime Configuration
Use `:set` commands while editing:
```
:set                    # Show all current settings
:set fold_level         # Show current fold level
:set fold_level=3       # Set fold level to 3
:set theme=dark         # Switch to dark theme
:set wrap=yes           # Enable line wrapping
```

All `:set` commands automatically update the file's configuration line.

## Previous Updates

### v1.2.0 - User-Defined Templates
- **Save as Template**: Save any HyperList document as a reusable template (`:st`)
- **Template Manager**: List and delete your custom templates (`:lt`, `:dt`)
- **Enhanced Template Browser**: Shows both built-in and user templates
- **Template Metadata**: Includes description and creation date
- Templates stored in `~/.hyperlist/templates/` for easy backup and sharing

### v1.1.0 - Encryption Support
- **File-level encryption** for sensitive files (dot files like `.passwords.hl`)
- **Line-level encryption** for individual items (Ctrl-E to toggle)
- Secure AES-256-CBC encryption with PBKDF2 key derivation
- Password caching for the session

### 🎯 Enhanced Presentation Mode
- **Auto-collapse** everything outside the current context
- **Smart focus**: Shows only current item, ancestors, and immediate children
- **Visual hierarchy**: Focused items in full color, others greyed out
- Improved navigation with proper cursor tracking

### 🎨 Better Visual Experience
- **Improved highlighting**: Dark gray background preserves syntax colors
- **Subtle selection**: No more harsh reverse video
- **Preserved colors**: All HyperList elements maintain their colors when selected

## Features

### Core Functionality
- **Hierarchical Organization**: Create multi-level nested lists with unlimited depth
- **Rich Syntax Highlighting**: Color-coded elements for better readability
  - Properties and dates in red
  - Operators (AND, OR, IF, THEN) in blue
  - Checkboxes in various shades of green
  - References in magenta
  - Hash tags in yellow/orange
  - Comments in cyan
- **Advanced Folding**: Collapse and expand sections with multiple fold levels
- **Powerful Navigation**: Jump between items, references, and markers
- **Full Editing Capabilities**: Create, edit, delete, move, and reorganize items
- **Checkbox Support**: Multiple checkbox types with completion tracking
- **Template System**: Built-in templates plus save/load custom templates
- **Presentation Mode**: Focus on current item with auto-collapse

### Security Features
- **Encryption**: Protect sensitive data with AES-256 encryption
- **Automatic detection**: Dot files automatically prompt for encryption
- **Line-level security**: Encrypt individual sensitive items
- **Visual indicators**: Encrypted lines show lock icon

### Text Formatting
- **Bold**: `*text*`
- **Italic**: `/text/`
- **Underline**: `_text_`
- **References**: `<reference name>` or `<file:/path/to/file>`
- **Hash tags**: `#tag`
- **Comments**: `; comment text`
- **Dates**: `2025-08-12` or `2025-08-12 14:30`

### Export Formats
- **PDF**: Professional LaTeX-based PDF with color coding and TOC
- **LaTeX**: Source .tex files for customization
- **HTML**: Full-featured HTML with syntax highlighting
- **Markdown**: GitHub-flavored Markdown
- **Plain Text**: Clean text output
- **PNG Graph**: Visual representation using Graphviz

### File Operations
- Multiple file support with recent files list
- Autosave functionality with configurable intervals
- Split view for working with multiple lists
- Encryption support for sensitive files

## Installation

### Prerequisites
- Ruby 3.0 or higher
- rcurses gem: `gem install rcurses`
- Optional: Graphviz for PNG export (`apt-get install graphviz` or `brew install graphviz`)

### Install from RubyGems
```bash
gem install hyperlist
```

### Install from Source
```bash
git clone https://github.com/isene/HyperList.git
cd HyperList
chmod +x hyperlist
./hyperlist
```

## Usage

### Basic Usage
```bash
hyperlist                    # Start with empty document
hyperlist file.hl           # Open existing HyperList file
hyperlist .passwords.hl     # Open encrypted file (will prompt for password)
hyperlist file.txt          # Open any text file
```

### Key Bindings

#### Navigation
- `j/↓` - Move down
- `k/↑` - Move up
- `h` - Go to parent item
- `l` - Go to first child
- `g/Home` - Go to top
- `G/End` - Go to bottom
- `/` - Search
- `n` - Next search match
- `N` - Next template marker (=)

#### Editing
- `i/Enter` - Edit line
- `o` - Insert line below
- `O` - Insert line above
- `a` - Insert child item
- `A` - Insert outdented item (one level less)
- `I` - Cycle indentation size (2-5 spaces)
- `D` - Delete and yank line
- `C-D` - Delete and yank item with descendants
- `y/Y` - Copy line/tree
- `p` - Paste below
- `P` - Paste above
- `U` - Undo
- `r` or `C-R` - Redo
- `E` - Edit in $EDITOR

#### Tagging & Batch Operations
- `t` - Tag/untag current item
- `u` - Clear all tags
- `C-T` - Tag items matching regex pattern
- Operations (D/C-D, y/Y, Tab/S-Tab) work on all tagged items when tags exist

#### Folding
- `Space` - Toggle fold
- `za` - Toggle all folds
- `1-9` - Expand to level
- `0` - Multi-digit fold level

#### Features
- `v` - Toggle checkbox
- `V` - Toggle checkbox with timestamp
- `C-E` - Encrypt/decrypt current line
- `R` - Go to reference
- `F` - Open file reference
- `C-P` - Presentation mode (with auto-collapse)
- `T` - Insert template (built-in or custom)
- `?` - Help screen

#### File Commands
- `:w` - Save
- `:q` - Quit
- `:wq` or `W` - Save and quit
- `:e file` - Open file
- `:export pdf` - Export to PDF (requires LaTeX)
- `:export latex` - Export to LaTeX source
- `:export html` - Export to HTML
- `:export md` - Export to Markdown
- `:graph` - Export to PNG graph

#### Template Commands
- `:st` - Save current document as template
- `:dt` - Delete a user template
- `:lt` - List all user templates
- `t` - Browse and insert templates

## Examples

### Simple Todo List
```
Daily Tasks
    [ ] Morning review
        [ ] Check emails
        [ ] Review calendar
    [ ] Development work
        [ ] Fix bug #123
        [ ] Code review
    [X] Lunch break
    [ ] Afternoon tasks
```

### Encrypted Password Manager
Save as `.passwords.hl` for automatic encryption:
```
Online Accounts
    GitHub
        Username: myuser
        Password: [will be encrypted]
        2FA: enabled
    Banking
        Account: 12345678
        PIN: [will be encrypted]
```

### Project Structure
```
MyProject #project
    Planning Phase
        [X] Define objectives
        [O] Identify stakeholders
        [ ] Create timeline
    Implementation
        Backend Development
            Authentication module
            Database schema
            REST endpoints
        Frontend Development
            Login page
            Dashboard
    Documentation
        Technical docs
        User manual
```

### Meeting Notes with References
```
Team Meeting 2025-08-12 14:00
    Participants
        John (PM)
        Sarah (Dev)
        Mike (Design)
    Discussion Points
        Sprint planning <Sprint-23>
        Bug review <file:./bugs.hl>
        Design updates
            ; Mike will share mockups
    Action Items
        [ ] John: Update roadmap
        [ ] Sarah: Fix critical bugs
        [ ] Mike: Finalize designs
```

## Configuration

### Application Configuration
The application stores configuration in `~/.hyperlist/`:
- `recent_files.txt` - List of recently opened files
- `marks.yml` - Saved marks across sessions
- `command_history` - Command history for `:` commands
- `templates/` - User-defined templates

### Per-File Configuration
Each HyperList file can have its own configuration line at the bottom:
```
((option=value, option2=value))
```

This configuration line is:
- Automatically applied when the file is loaded
- Updated when you use `:set` commands
- Invisible in the editor (not displayed as content)
- Preserved when saving the file

Available options:
- `theme` - light/normal/dark
- `wrap` - yes/no
- `show_numbers` - yes/no
- `fold_level` - 0-99
- `auto_save` - yes/no
- `auto_save_interval` - seconds
- `tab_width` - 2-8

## Testing

Run the included test suite:
```bash
./hyperlist test.hl
```

Follow the instructions in the test file to verify all features are working correctly.

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## Changelog

### v1.1.1 (2025-08-13)
- **Fixed**: Critical navigation bug where the last item (line 154 in test.hl) was not reachable when pressing 'G'
- **Fixed**: Improved scrolling behavior to properly handle wrapped lines using rcurses built-in capabilities
- **Fixed**: Split view navigation - g/G/Home/End/PgUp/PgDown now correctly affect the active pane
- **Added**: Wrap-around navigation in split view right pane (UP from first goes to last, DOWN from last goes to first)
- **Added**: Visual end-of-document indicator (blank line at bottom) for better UX
- **Improved**: Scroll calculations now dynamically account for line wrapping

### v1.1.0 (2025-08-12)
- Added encryption support for sensitive documents
- Enhanced presentation mode
- Various bug fixes and improvements

## License

This software is released into the **Public Domain**.

## Author

Created by Geir Isene - [https://isene.org](https://isene.org)

Based on the HyperList methodology and inspired by the original hyperlist.vim plugin.

## Acknowledgments

- The rcurses library for excellent terminal UI capabilities
- The Ruby community for a wonderful programming language
- All contributors and users of HyperList

---

For more information about HyperList, visit [https://isene.org/hyperlist/](https://isene.org/hyperlist/)