#!/usr/bin/env ruby
# HyperList Diagnostic Script
# Run this to help diagnose installation/startup issues

puts "=" * 60
puts "HyperList Diagnostic Report"
puts "=" * 60

# Check Ruby version
puts "\n1. Ruby Version:"
puts "   #{RUBY_VERSION} (#{RUBY_PLATFORM})"
if RUBY_VERSION < "3.0.0"
  puts "   ⚠️  WARNING: HyperList requires Ruby 3.0.0 or higher"
else
  puts "   ✓ Ruby version OK"
end

# Check gem versions
puts "\n2. Gem Versions:"
begin
  hyperlist_version = `gem list hyperlist --local`.match(/hyperlist \(([\d.]+)\)/)[1] rescue "not found"
  rcurses_version = `gem list rcurses --local`.match(/rcurses \(([\d.]+(?:,\s*[\d.]+)*)\)/)[1] rescue "not found"
  
  puts "   hyperlist: #{hyperlist_version}"
  if hyperlist_version >= "1.1.3"
    puts "   ✓ HyperList version OK"
  else
    puts "   ⚠️  Please update: gem update hyperlist"
  end
  
  puts "   rcurses: #{rcurses_version}"
  if rcurses_version.include?("5.1.4") || rcurses_version >= "5.1.4"
    puts "   ✓ rcurses version OK"
  else
    puts "   ⚠️  Please update: gem update rcurses"
  end
rescue => e
  puts "   Error checking gems: #{e.message}"
end

# Test loading rcurses
puts "\n3. Testing rcurses load:"
begin
  require 'rcurses'
  puts "   ✓ rcurses loaded successfully"
  
  # Check if we can access rcurses modules
  include Rcurses
  puts "   ✓ Rcurses modules accessible"
rescue LoadError => e
  puts "   ✗ Failed to load rcurses: #{e.message}"
  puts "   Try: gem install rcurses"
rescue => e
  puts "   ✗ Error with rcurses: #{e.message}"
end

# Test terminal capabilities
puts "\n4. Terminal Check:"
puts "   TERM: #{ENV['TERM'] || 'not set'}"
puts "   TTY: #{$stdin.tty? ? 'Yes' : 'No'}"
puts "   Encoding: #{Encoding.default_external}"

# Check for HyperList executable
puts "\n5. HyperList Installation:"
hyperlist_path = `which hyperlist`.strip
if hyperlist_path.empty?
  puts "   ✗ hyperlist command not found in PATH"
  puts "   Try: gem install hyperlist"
else
  puts "   ✓ Found at: #{hyperlist_path}"
  
  # Check if it's executable
  if File.executable?(hyperlist_path)
    puts "   ✓ File is executable"
  else
    puts "   ⚠️  File is not executable"
    puts "   Try: chmod +x #{hyperlist_path}"
  end
end

# Try to load core dependencies
puts "\n6. Core Dependencies:"
deps = ['io/console', 'date', 'cgi', 'openssl', 'digest', 'base64']
deps.each do |dep|
  begin
    require dep
    puts "   ✓ #{dep}"
  rescue LoadError => e
    puts "   ✗ #{dep}: #{e.message}"
  end
end

# Test creating a basic rcurses pane (without initializing terminal)
puts "\n7. Testing Rcurses Pane Creation (simulation):"
begin
  # Don't actually initialize the terminal, just test the class exists
  if defined?(Rcurses::Pane)
    puts "   ✓ Rcurses::Pane class exists"
  else
    puts "   ✗ Rcurses::Pane class not found"
  end
rescue => e
  puts "   ✗ Error: #{e.message}"
end

puts "\n" + "=" * 60
puts "Diagnostic complete!"
puts "=" * 60

puts "\nIf everything shows ✓ but hyperlist still crashes:"
puts "1. Run with debug mode: DEBUG=1 RCURSES_DEBUG=1 hyperlist"
puts "2. Check for error log: cat ~/.hyperlist_error.log"
puts "3. Try running directly: ruby #{hyperlist_path}"

puts "\nPlease share this diagnostic output when reporting issues."