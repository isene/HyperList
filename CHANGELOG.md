# Changelog

All notable changes to the HyperList Ruby TUI will be documented in this file.

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