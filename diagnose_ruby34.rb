#!/usr/bin/env ruby
# Diagnostic script for Ruby 3.4.5 compatibility issues

puts "Ruby Compatibility Diagnostic for HyperList"
puts "=" * 50
puts "Ruby version: #{RUBY_VERSION}"
puts "Ruby platform: #{RUBY_PLATFORM}"
puts

# Test 1: Basic rcurses functionality
puts "Test 1: Basic rcurses require and init..."
begin
  require 'rcurses'
  puts "  ✓ rcurses loaded successfully"
  puts "  Rcurses version: #{Rcurses::VERSION}" if defined?(Rcurses::VERSION)
rescue LoadError => e
  puts "  ✗ Failed to load rcurses: #{e.message}"
  exit 1
end

# Test 2: Rcurses initialization with error capture
puts "\nTest 2: Rcurses initialization..."
begin
  # Capture any output during init
  original_stdout = $stdout
  original_stderr = $stderr
  
  # Create StringIO to capture output
  require 'stringio'
  captured_out = StringIO.new
  captured_err = StringIO.new
  
  $stdout = captured_out
  $stderr = captured_err
  
  # Try to initialize
  Rcurses.init!
  
  # Restore output
  $stdout = original_stdout
  $stderr = original_stderr
  
  # Check if anything was captured
  out_content = captured_out.string
  err_content = captured_err.string
  
  if !out_content.empty?
    puts "  Captured stdout during init: #{out_content.inspect}"
  end
  if !err_content.empty?
    puts "  Captured stderr during init: #{err_content.inspect}"
  end
  
  puts "  ✓ Rcurses initialized"
  
  # Test basic functionality
  puts "  Testing basic screen operations..."
  print "\e[2J\e[H"  # Clear screen
  print "Test"
  sleep 0.1
  print "\e[2J\e[H"  # Clear again
  
  puts "  ✓ Basic operations work"
  
rescue => e
  puts "  ✗ Failed during initialization: #{e.message}"
  puts "  Backtrace:"
  e.backtrace.first(5).each { |line| puts "    #{line}" }
ensure
  # Try to restore terminal
  begin
    Rcurses.done! if defined?(Rcurses.done!)
  rescue
    # Fallback terminal restore
    print "\e[?25h"  # Show cursor
    system("stty sane 2>/dev/null")
  end
end

# Test 3: Check for method availability issues in Ruby 3.4
puts "\nTest 3: Ruby 3.4 specific checks..."

# Check IO methods that might have changed
if IO.respond_to?(:console)
  puts "  ✓ IO.console available"
else
  puts "  ✗ IO.console not available"
end

begin
  require 'io/console'
  $stdin.raw { }
  puts "  ✓ IO#raw method works"
rescue => e
  puts "  ✗ IO#raw failed: #{e.message}"
end

# Test 4: Check encoding
puts "\nTest 4: Encoding checks..."
puts "  Default external: #{Encoding.default_external}"
puts "  Default internal: #{Encoding.default_internal}"
puts "  Console encoding: #{$stdout.external_encoding}" if $stdout.respond_to?(:external_encoding)

# Test 5: Simple hyperlist initialization test
puts "\nTest 5: HyperList class initialization..."
begin
  # Load just the class definition part
  hyperlist_code = File.read(File.join(File.dirname(__FILE__), 'hyperlist'))
  
  # Extract just the class without running main
  class_only = hyperlist_code.split(/^if __FILE__ == \$0/)[0]
  
  # Try to evaluate it
  eval(class_only)
  
  puts "  ✓ HyperList class loaded"
  
  # Try to create instance (without running)
  app = HyperListApp.new
  puts "  ✓ HyperListApp instance created"
  
rescue => e
  puts "  ✗ Failed to load HyperList: #{e.message}"
  puts "  Error at: #{e.backtrace.first}"
end

# Test 6: Terminal capability check
puts "\nTest 6: Terminal capabilities..."
puts "  TERM: #{ENV['TERM']}"
puts "  Columns: #{`tput cols`.strip}" rescue nil
puts "  Lines: #{`tput lines`.strip}" rescue nil

# Test 7: Check for signal handling changes
puts "\nTest 7: Signal handling..."
begin
  old_handler = Signal.trap("WINCH") { }
  Signal.trap("WINCH", old_handler)
  puts "  ✓ SIGWINCH trap works"
rescue => e
  puts "  ✗ SIGWINCH trap failed: #{e.message}"
end

puts "\n" + "=" * 50
puts "Diagnostic complete!"
puts "\nPlease share this output to help identify the Ruby 3.4.5 compatibility issue."