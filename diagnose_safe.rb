#!/usr/bin/env ruby
# HyperList Safe Diagnostic Script
# This version ensures terminal remains in a sane state

# First, ensure terminal is in sane state
system("stty sane 2>/dev/null")

# Ensure we're not in raw mode and output is flushed properly
$stdout.sync = true
$stderr.sync = true

# Don't load rcurses until we explicitly test it
puts "=" * 60
puts "HyperList Safe Diagnostic Report"
puts "=" * 60

# Check Ruby version
puts "\n1. Ruby Version:"
puts "   #{RUBY_VERSION} (#{RUBY_PLATFORM})"
if RUBY_VERSION < "3.0.0"
  puts "   WARNING: HyperList requires Ruby 3.0.0 or higher"
elsif RUBY_VERSION >= "3.4.0"
  puts "   WARNING: Ruby 3.4+ is a development version and may have compatibility issues"
  puts "   RECOMMENDED: Use Ruby 3.3.x for stability"
else
  puts "   OK: Ruby version supported"
end

# Check gem versions WITHOUT loading them
puts "\n2. Installed Gem Versions:"
begin
  hyperlist_output = `gem list hyperlist --local 2>&1`
  rcurses_output = `gem list rcurses --local 2>&1`
  
  if hyperlist_output.include?("hyperlist")
    version = hyperlist_output.match(/hyperlist \(([\d.]+)/)[1] rescue "unknown"
    puts "   hyperlist: #{version}"
    if version >= "1.1.3"
      puts "   OK: HyperList version is current"
    else
      puts "   UPDATE NEEDED: gem update hyperlist"
    end
  else
    puts "   hyperlist: NOT INSTALLED"
    puts "   Run: gem install hyperlist"
  end
  
  if rcurses_output.include?("rcurses")
    # Extract just the first/latest version
    version = rcurses_output.match(/rcurses \(([\d.]+)/)[1] rescue "unknown"
    puts "   rcurses: #{version}"
    if version >= "5.1.4"
      puts "   OK: rcurses version is current"
    else
      puts "   UPDATE NEEDED: gem update rcurses"
    end
  else
    puts "   rcurses: NOT INSTALLED"
    puts "   Run: gem install rcurses"
  end
rescue => e
  puts "   Error checking gems: #{e.message}"
end

# Check terminal environment
puts "\n3. Terminal Environment:"
puts "   TERM: #{ENV['TERM'] || 'not set'}"
puts "   LANG: #{ENV['LANG'] || 'not set'}"
puts "   TTY: #{$stdin.tty? ? 'Yes' : 'No'}"
puts "   Terminal columns: #{`tput cols`.strip rescue 'unknown'}"
puts "   Terminal rows: #{`tput lines`.strip rescue 'unknown'}"

# Check for HyperList executable
puts "\n4. HyperList Executable:"
hyperlist_path = `which hyperlist 2>/dev/null`.strip
if hyperlist_path.empty?
  puts "   NOT FOUND in PATH"
  
  # Check common gem bin paths
  gem_paths = [
    "#{ENV['HOME']}/.local/share/gem/ruby/*/bin/hyperlist",
    "#{ENV['HOME']}/.gem/ruby/*/bin/hyperlist",
    "/usr/local/bin/hyperlist",
    "/usr/bin/hyperlist"
  ]
  
  found = false
  gem_paths.each do |pattern|
    Dir.glob(pattern).each do |path|
      if File.exist?(path)
        puts "   Found at: #{path}"
        puts "   Add to PATH: export PATH=\"#{File.dirname(path)}:$PATH\""
        found = true
        break
      end
    end
    break if found
  end
else
  puts "   Found at: #{hyperlist_path}"
  if File.executable?(hyperlist_path)
    puts "   OK: File is executable"
  else
    puts "   ERROR: File is not executable"
    puts "   Fix: chmod +x #{hyperlist_path}"
  end
end

# Test basic dependencies WITHOUT loading rcurses
puts "\n5. Core Ruby Dependencies:"
deps = ['io/console', 'date', 'cgi', 'openssl', 'digest', 'base64']
deps.each do |dep|
  begin
    require dep
    puts "   OK: #{dep}"
  rescue LoadError => e
    puts "   MISSING: #{dep} - #{e.message}"
  end
end

# Separate rcurses test with isolation
puts "\n6. Testing rcurses (isolated):"
puts "   Running isolated test..."

# Create a separate test script to isolate rcurses
test_script = <<~RUBY
  begin
    require 'rcurses'
    puts "RCURSES_LOAD:OK"
    
    # Check if main classes exist without initializing
    if defined?(Rcurses::Pane)
      puts "RCURSES_PANE:OK"
    else
      puts "RCURSES_PANE:FAIL"
    end
  rescue LoadError => e
    puts "RCURSES_LOAD:FAIL:\#{e.message}"
  rescue => e
    puts "RCURSES_ERROR:\#{e.class}:\#{e.message}"
  end
RUBY

# Run test in subprocess to avoid terminal corruption
result = `ruby -e "#{test_script}" 2>&1`

if result.include?("RCURSES_LOAD:OK")
  puts "   OK: rcurses loads successfully"
else
  puts "   ERROR: rcurses failed to load"
  error = result.match(/RCURSES_LOAD:FAIL:(.+)/)
  puts "   Details: #{error[1]}" if error
end

if result.include?("RCURSES_PANE:OK")
  puts "   OK: Rcurses::Pane class available"
else
  puts "   ERROR: Rcurses::Pane class not found"
end

if result.include?("RCURSES_ERROR")
  error = result.match(/RCURSES_ERROR:(.+):(.+)/)
  puts "   ERROR: #{error[1]} - #{error[2]}" if error
end

# Test terminal sanity
puts "\n7. Terminal State Check:"
system("stty -a > /dev/null 2>&1")
if $?.success?
  puts "   OK: Terminal responds to stty"
else
  puts "   ERROR: Terminal not responding properly"
end

# Try to restore terminal just in case
system("stty sane 2>/dev/null")
system("tput reset 2>/dev/null")

puts "\n" + "=" * 60
puts "Diagnostic complete!"
puts "=" * 60

puts "\nRECOMMENDATIONS:"
if RUBY_VERSION >= "3.4.0"
  puts "1. IMPORTANT: You're using Ruby #{RUBY_VERSION} (development version)"
  puts "   Install Ruby 3.3.x for stability:"
  puts "   - Arch Linux: sudo pacman -S ruby"
  puts "   - Or use: rbenv install 3.3.4"
end

puts "\nTo test rcurses isolation:"
puts "  ruby -e \"require 'rcurses'; puts 'Loaded OK'\""

puts "\nTo restore terminal if corrupted:"
puts "  stty sane"
puts "  reset"

puts "\nPlease share this diagnostic output when reporting issues."