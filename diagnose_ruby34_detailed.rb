#!/usr/bin/env ruby
# Detailed diagnostic script for Ruby 3.4.5 compatibility issues

puts "Ruby Compatibility Diagnostic for HyperList (Detailed)"
puts "=" * 50
puts "Ruby version: #{RUBY_VERSION}"
puts "Ruby platform: #{RUBY_PLATFORM}"
puts

# Test 0: Environment check
puts "Test 0: Environment check..."
puts "  TERM: #{ENV['TERM']}"
puts "  SHELL: #{ENV['SHELL']}"
puts "  HOME: #{ENV['HOME']}"
puts "  PATH includes gem bin: #{ENV['PATH'].include?('.gem')}"
puts

# Test 1: Basic rcurses load
puts "Test 1: Loading rcurses gem..."
STDOUT.flush
begin
  require 'rcurses'
  puts "  ✓ rcurses loaded"
  puts "  Rcurses constants defined: #{Rcurses.constants.sort.join(', ')}" if defined?(Rcurses)
  STDOUT.flush
rescue LoadError => e
  puts "  ✗ Failed to load rcurses: #{e.message}"
  exit 1
end

# Test 2: Check rcurses version and methods
puts "\nTest 2: Checking rcurses methods..."
STDOUT.flush
if defined?(Rcurses)
  puts "  Methods available: #{Rcurses.methods(false).sort.join(', ')}"
  puts "  Responds to init!: #{Rcurses.respond_to?(:init!)}"
  puts "  Responds to done!: #{Rcurses.respond_to?(:done!)}"
  STDOUT.flush
end

# Test 3: Try initialization with timeout
puts "\nTest 3: Attempting rcurses initialization (with 2 second timeout)..."
STDOUT.flush

require 'timeout'
begin
  Timeout::timeout(2) do
    puts "  Calling Rcurses.init!..."
    STDOUT.flush
    
    # Try to capture any initialization issues
    old_stdout = $stdout
    old_stderr = $stderr
    
    begin
      Rcurses.init!
      puts "  ✓ Rcurses.init! returned successfully"
    rescue => e
      puts "  ✗ Rcurses.init! raised: #{e.class} - #{e.message}"
      puts "    Backtrace: #{e.backtrace.first(3).join("\n    ")}"
    ensure
      $stdout = old_stdout
      $stderr = old_stderr
    end
    
    STDOUT.flush
  end
rescue Timeout::Error
  puts "  ✗ Rcurses.init! timed out after 2 seconds"
  puts "  This suggests init! is hanging"
  STDOUT.flush
end

# Test 4: Check terminal control without rcurses
puts "\nTest 4: Direct terminal control test..."
STDOUT.flush
begin
  # Save terminal state
  system("stty -g > /tmp/terminal_state.txt 2>/dev/null")
  
  # Try basic terminal operations
  print "\e[?25l"  # Hide cursor
  print "\e[2J"     # Clear screen
  print "\e[H"      # Home
  print "Terminal control test"
  sleep 0.5
  print "\e[2J\e[H" # Clear again
  print "\e[?25h"   # Show cursor
  
  puts "  ✓ Direct terminal control works"
  STDOUT.flush
rescue => e
  puts "  ✗ Terminal control failed: #{e.message}"
  STDOUT.flush
ensure
  # Restore terminal
  system("stty $(cat /tmp/terminal_state.txt) 2>/dev/null")
  print "\e[?25h"  # Ensure cursor is visible
end

# Test 5: Check IO/console
puts "\nTest 5: IO/console functionality..."
STDOUT.flush
begin
  require 'io/console'
  
  # Check if stdin is a tty
  puts "  STDIN.tty?: #{STDIN.tty?}"
  puts "  STDOUT.tty?: #{STDOUT.tty?}"
  
  # Test raw mode
  begin
    STDIN.raw { }
    puts "  ✓ STDIN.raw works"
  rescue => e
    puts "  ✗ STDIN.raw failed: #{e.message}"
  end
  
  # Test noecho
  begin
    STDIN.noecho { }
    puts "  ✓ STDIN.noecho works"
  rescue => e
    puts "  ✗ STDIN.noecho failed: #{e.message}"
  end
  
  STDOUT.flush
rescue => e
  puts "  ✗ Failed: #{e.message}"
  STDOUT.flush
end

# Test 6: Check if rcurses is trying to use methods that don't exist
puts "\nTest 6: Checking potential Ruby 3.4 incompatibilities..."
STDOUT.flush

# Check Thread methods
puts "  Thread.respond_to?(:handle_interrupt): #{Thread.respond_to?(:handle_interrupt)}"
puts "  Signal.list includes WINCH: #{Signal.list.include?('WINCH')}"

# Check IO methods that might be different
if defined?(IO.console)
  console = IO.console
  puts "  IO.console class: #{console.class}"
  puts "  IO.console methods include raw: #{console.respond_to?(:raw)}"
  puts "  IO.console methods include getch: #{console.respond_to?(:getch)}"
end

puts "\n" + "=" * 50
puts "Diagnostic complete!"
puts "\nIf the script hangs at 'Calling Rcurses.init!', it means rcurses"
puts "is incompatible with Ruby 3.4.5 and needs to be updated."
STDOUT.flush

# Clean exit
exit 0