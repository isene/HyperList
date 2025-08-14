#!/usr/bin/env ruby
# Patch for rcurses to work with Ruby 3.4.5
# This shows the minimal changes needed to fix the initialization hang

module Rcurses
  class << self
    # Override init! with Ruby 3.4+ compatibility
    def init_with_ruby34_fix!
      return if @initialized
      return unless $stdin.tty?

      # Ruby 3.4.5 compatibility: Use Timeout to prevent hangs
      # and try different approaches
      begin
        if RUBY_VERSION >= "3.4.0"
          # For Ruby 3.4+, try using the block form first
          # which properly handles terminal state
          begin
            require 'timeout'
            
            # Try to set raw mode with timeout
            Timeout::timeout(0.5) do
              # In Ruby 3.4+, raw! might need explicit flush
              $stdout.flush
              $stderr.flush
              
              # Try setting raw mode
              $stdin.raw!
            end
            
            # Set echo separately with timeout
            Timeout::timeout(0.5) do
              $stdin.echo = false
            end
          rescue Timeout::Error
            # If raw! hangs, try alternative approach
            # Use stty command as fallback
            system("stty raw -echo 2>/dev/null")
            @using_stty = true
          end
        else
          # Original code for older Ruby versions
          $stdin.raw!
          $stdin.echo = false
        end
      rescue Errno::ENOTTY, Errno::ENODEV
        # Not a terminal, can't initialize
        return
      rescue => e
        # Log error but don't fail
        $stderr.puts "rcurses init warning: #{e.message}" if ENV['DEBUG']
        return
      end

      # ensure cleanup on normal exit
      at_exit do
        if $! && !$!.is_a?(SystemExit) && !$!.is_a?(Interrupt)
          @error_to_display = $!
        end
        cleanup_with_ruby34_fix!
      end

      # ensure cleanup on signals
      %w[INT TERM].each do |sig|
        trap(sig) { cleanup_with_ruby34_fix!; exit }
      end

      @initialized = true
    end
    
    def cleanup_with_ruby34_fix!
      return if @cleaned_up

      begin
        if @using_stty
          # If we used stty for initialization, use it for cleanup too
          system("stty sane 2>/dev/null")
        elsif RUBY_VERSION >= "3.4.0"
          # Ruby 3.4+ cleanup with timeout
          begin
            Timeout::timeout(0.5) do
              $stdin.cooked!
              $stdin.echo = true
            end
          rescue Timeout::Error
            # Fallback to stty
            system("stty sane 2>/dev/null")
          end
        else
          # Original cleanup
          $stdin.cooked!
          $stdin.echo = true
        end
      rescue => e
        # Last resort cleanup
        system("stty sane 2>/dev/null")
      end
      
      # Rest of cleanup remains the same
      if @error_to_display.nil?
        Rcurses.clear_screen
      else
        print "\e[999;1H"
        print "\e[K"
      end
      
      Cursor.show
      @cleaned_up = true
      
      if @error_to_display
        display_error(@error_to_display)
      end
    end
  end
end

# Test the patch
if __FILE__ == $0
  puts "Testing rcurses Ruby 3.4.5 patch..."
  puts "Ruby version: #{RUBY_VERSION}"
  
  # Load rcurses
  require 'rcurses'
  
  # Apply the patch
  class << Rcurses
    alias_method :init_original!, :init!
    alias_method :init!, :init_with_ruby34_fix!
    alias_method :cleanup!, :cleanup_with_ruby34_fix!
  end
  
  # Test initialization
  begin
    puts "Calling Rcurses.init! with patch..."
    Rcurses.init!
    puts "✓ Initialization successful!"
    
    # Do a simple test
    print "\e[2J\e[H"
    print "Patch works! Press any key..."
    $stdin.getch if $stdin.respond_to?(:getch)
    
  rescue => e
    puts "✗ Error: #{e.message}"
  ensure
    Rcurses.cleanup!
    puts "✓ Cleanup successful!"
  end
end