# Changelog

All notable changes to the HyperList Ruby TUI will be documented in this file.

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