# Debugging HyperList Issues

## For the user experiencing startup crashes:

### 1. First, verify you have the latest versions:

```bash
gem list hyperlist
# Should show: hyperlist (1.1.3)

gem list rcurses  
# Should show: rcurses (5.1.4) or higher
```

### 2. If not, update to the latest:

```bash
gem update hyperlist
gem update rcurses
```

### 3. Run with debug mode to see errors:

```bash
# Set debug environment variable
export RCURSES_DEBUG=1
export DEBUG=1

# Then run hyperlist
hyperlist

# Or run in one line:
DEBUG=1 RCURSES_DEBUG=1 hyperlist
```

### 4. Alternative: Run with Ruby directly to see errors:

```bash
# Find where hyperlist is installed
which hyperlist

# Run it directly with Ruby to see any errors
ruby $(which hyperlist)
```

### 5. Check Ruby version compatibility:

```bash
ruby --version
# HyperList requires Ruby 3.0.0 or higher
```

### 6. Try running with verbose Ruby output:

```bash
ruby -w $(which hyperlist)
```

### 7. Check for missing dependencies:

```bash
# This will show if rcurses is properly installed
ruby -e "require 'rcurses'; puts 'rcurses loaded successfully'"
```

### 8. Create a simple test file to isolate the issue:

Create a file called `test_hyperlist.rb`:

```ruby
#!/usr/bin/env ruby

puts "Ruby version: #{RUBY_VERSION}"
puts "Testing rcurses..."

begin
  require 'rcurses'
  puts "✓ rcurses loaded successfully (version from gem)"
rescue LoadError => e
  puts "✗ Failed to load rcurses: #{e.message}"
  exit 1
end

puts "\nTesting basic rcurses functionality..."
begin
  include Rcurses
  puts "✓ Rcurses module included"
  puts "✓ All basic checks passed!"
rescue => e
  puts "✗ Error: #{e.message}"
  exit 1
end
```

Run it with:
```bash
ruby test_hyperlist.rb
```

### 9. If all else fails, capture output:

```bash
# Run with script to capture all output
script -c "hyperlist" hyperlist_output.txt

# Then send us the hyperlist_output.txt file
```

## Notes:
- GDB won't work with Ruby scripts (it's for compiled binaries)
- The new error handling in rcurses 5.1.4+ should show errors after terminal cleanup
- Setting DEBUG=1 or RCURSES_DEBUG=1 will show full stack traces