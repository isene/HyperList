#!/usr/bin/env ruby
# encoding: utf-8

# Wrapper for Ruby 3.4+ compatibility
# This ensures proper initialization of rcurses

# Handle help/version before loading libraries
if ARGV[0] == '-h' || ARGV[0] == '--help' || ARGV[0] == '-v' || ARGV[0] == '--version'
  # Pass through to main hyperlist
  load File.join(File.dirname(__FILE__), 'hyperlist')
  exit 0
end

# Explicitly initialize rcurses before loading the main app
require 'rcurses'

begin
  # Initialize rcurses with proper error handling
  Rcurses.init!
  
  # Now load and run the main hyperlist app
  # We need to prevent the main file from running automatically
  $hyperlist_wrapper_mode = true
  
  # Load the hyperlist file
  load File.join(File.dirname(__FILE__), 'hyperlist')
  
  # Create and run the app
  app = HyperListApp.new(ARGV[0])
  app.run
  
rescue Interrupt
  # Handle Ctrl+C gracefully
  Rcurses.done! if defined?(Rcurses.done!)
  puts "\nInterrupted"
  exit 0
rescue => e
  # Ensure terminal is restored on error
  Rcurses.done! if defined?(Rcurses.done!)
  
  # Fallback terminal restoration
  print "\e[?25h"  # Show cursor
  system("stty sane 2>/dev/null")
  
  puts "Error: #{e.message}"
  puts "Backtrace:" if ENV['DEBUG']
  e.backtrace.first(10).each { |line| puts "  #{line}" } if ENV['DEBUG']
  exit 1
ensure
  # Always try to restore terminal
  begin
    Rcurses.done! if defined?(Rcurses.done!)
  rescue
    print "\e[?25h"
    system("stty sane 2>/dev/null")
  end
end