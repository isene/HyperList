# Changelog

All notable changes to the HyperList Ruby TUI will be documented in this file.

## [1.4.4] - 2025-09-01

### Added
- **Case conversion commands**
  - `gU` to convert current line to UPPERCASE
  - `gu` to convert current line to lowercase
  - Works with all HyperList elements (checkboxes, operators, etc.)

### Fixed
- **Color code display issues**
  - Fixed bracket content extraction in safe_regex_replace to preserve qualifier text
  - Updated operator regex pattern to match after ANSI placeholders
  - Both numbered lists (1.) and operators (NOT:) now color correctly when combined

## [1.4.3] - 2025-08-30

### Fixed
- **Multi-line item handling**
  - Proper handling of multi-line items per HyperList specification
  - Fixed display and editing of items with embedded newlines

## [1.4.2] - 2025-08-29

### Fixed
- **Help screen improvements**
  - Fixed help screen crash issue with CONFIGURATION section
  - Improved alignment of :set commands in help
  - Added working CONFIGURATION section with proper formatting
  
### Changed
- **Code cleanup**
  - Removed debug logging code
  - Cleaned up unused variables
  - Improved code consistency

## [1.4.1] - 2025-08-29

### Fixed
- **Configuration system improvements**
  - Config lines are now completely invisible (not shown in gray)
  - Config management only through `:set` commands
  - Fixed `:set` commands to properly update config lines when saving
  - Fixed fold_level persistence issue when using `:set fold_level=N`
  - Fixed help screen crash when showing configuration section
  - Added error logging for help screen debugging
  
### Changed
- **Line numbering improvements**
  - Line numbers now show actual line position in file (including collapsed lines)
  - Both main pane and split pane show true line numbers
  - Wrapped lines show line number only on first line
  
### Added
- **Help system documentation**
  - Added CONFIGURATION section to help screen (?)
  - Documents all `:set` commands and available options
  - Explains config line format and behavior

## [1.4.0] - 2025-08-28

### Added
- **Configuration Lines & Theming**
  - New configuration line format: `((option=value, option2=value))`
  - Configuration lines displayed in gray when shown
  - Three color themes: `light` (bright), `normal` (standard), `dark` (for light terminals)
  - Line wrapping with `+` prefix per HyperList specification
  - Line number display option
  - Manual configuration via `:set` commands
  - `:set option=value` to change settings
  - `:set option` to view a setting
  - `:set` to view all settings
  - **Command history** with UP/DOWN arrow navigation
  - History persistence between sessions (~/.hyperlist_command_history)
  - Configuration options:
    - `theme` - Color theme (light/normal/dark)
    - `wrap` - Line wrapping (yes/no)
    - `show_numbers` - Display line numbers (yes/no)
    - `fold_level` - Default fold level (0-99)
    - `auto_save` - Auto-save enable (yes/no)
    - `auto_save_interval` - Auto-save frequency (seconds)
    - `tab_width` - Indentation width (2-8)

## [1.3.0] - 2025-08-28

### Added  
- **Initial Configuration Support**
  - Basic config line parsing (old format, now deprecated)

## [1.2.7] - 2025-08-27

### Fixed
- Fixed 'D' key to delete only the current line, not from cursor to end of file

## [1.2.6] - 2025-08-26

### Fixed
- Fixed presentation mode navigation issues
- Corrected presentation mode footer display

## [1.2.5] - 2025-08-25

### Enhanced
- Improved presentation mode with better focus
- Reorganized help page for better readability

## [1.2.4] - 2025-08-24

### Enhanced
- Enhanced item movement and indentation
- Improved editing capabilities

## [1.2.3] - 2025-08-23

### Fixed
- Various bug fixes and improvements

## [1.2.2] - 2025-08-20

### Fixed
- Fixed encoding compatibility error when decrypting files (UTF-8 vs ASCII-8BIT)
- Force UTF-8 encoding on decrypted content and text processing

### Added
- Auto-fold encrypted files on open for privacy (fold level 0)
- Display "folded for privacy" message when opening encrypted files

## [1.2.1] - 2025-08-20

### Fixed
- Fixed crash when opening encrypted dot files (footer not initialized)
- Added password confirmation when encrypting files for the first time
- Improved initialization order to ensure UI components are ready before file loading

## [1.2.0] - 2025-08-20

### Added
- **User-Defined Templates**
  - Save any HyperList document as a reusable template (`:st` or `:save-template`)
  - Template manager for listing and deleting custom templates (`:lt`, `:dt`)
  - Enhanced template browser showing both built-in and user templates
  - Template metadata including description and creation date
  - Templates stored in `~/.hyperlist/templates/` for easy backup and sharing
  - JSON format for template storage with full hierarchy preservation
  
### Changed
- Template system now supports both built-in and user-created templates
- Template browser UI improved with separate sections for built-in vs user templates
- Help documentation updated with new template commands

## [1.1.7] - 2025-08-15

### Fixed
- **Updated rcurses dependency to 5.1.6**
  - Fixes Ruby 3.4.5 hanging issue during terminal initialization
  - rcurses now handles stdin.raw! blocking with timeout and stty fallback
  - Fully backward compatible

## [1.1.6] - 2025-08-14

### Fixed
- **Ruby 3.4+ Compatibility**
  - Added explicit rcurses initialization for Ruby 3.4.0 and later
  - Improved error handling during terminal initialization
  - Added proper cleanup on exit for newer Ruby versions
  - Fixed silent crashes on Arch Linux with Ruby 3.4.5

## [1.1.0] - 2025-08-13

### Added
- **Encryption Support**
  - File-level encryption for sensitive files (automatic for dot files)
  - Line-level encryption for individual items (Ctrl-E to toggle)
  - Secure AES-256-CBC encryption with PBKDF2 key derivation
  - Password caching for the session
  - Visual indicators for encrypted content (lock icon)

- **Enhanced Presentation Mode**
  - Auto-collapse everything outside the current context
  - Smart focus showing only current item, ancestors, and immediate children
  - Visual hierarchy with focused items in full color, others greyed out
  - Proper cursor tracking when folding changes

### Changed
- **Improved Visual Experience**
  - Current line highlighting now uses dark gray background instead of reverse video
  - Preserves all syntax colors when items are selected
  - Search highlighting no longer overrides text colors
  - More subtle and professional appearance

### Fixed
- Cursor position tracking in presentation mode when folds change
- Cache invalidation issues in presentation mode
- Navigation responsiveness improvements

## [1.0.0] - 2025-08-12

### Initial Release

#### Features
- Full HyperList syntax support with color highlighting
- Hierarchical list management with unlimited nesting
- Advanced folding system with multi-level support
- Powerful navigation including marks, jumps, and references
- Complete editing capabilities (insert, delete, move, copy, paste)
- Multiple checkbox types with completion tracking
- Template system with marker navigation
- Presentation mode for focused viewing
- Search functionality with highlighting
- Undo/redo support with repeat last action
- Split view for working with multiple lists
- Autosave functionality with configurable intervals
- Recent files list

#### Export Formats
- HTML with full syntax highlighting and responsive design
- Markdown (GitHub-flavored)
- Plain text
- PNG graph visualization (requires Graphviz)

#### Text Formatting
- Bold (*text*)
- Italic (/text/)
- Underline (_text_)
- References (<reference>)
- Hash tags (#tag)
- Comments (; comment)
- Date/time support

#### Keyboard Shortcuts
- Comprehensive vim-like key bindings
- Help system with full documentation
- Customizable through command mode

#### File Support
- Native .hl HyperList files
- Any text file can be edited as HyperList
- UTF-8 support with unicode and emoji

### Technical
- Built with Ruby 3.0+
- Uses rcurses for terminal UI
- Public Domain license