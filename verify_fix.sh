#!/bin/bash

echo "========================================="
echo "Verifying rcurses ANSI wrapping fix"
echo "========================================="
echo
echo "This will test the hyperlist app with the fixed rcurses library."
echo "Steps to verify:"
echo "1. The app will open test_wrap.hl"
echo "2. Type :vs to enable split view"
echo "3. Navigate to lines with AND: OR: IF: THEN: operators"
echo "4. Check that colors appear correctly (blue for operators)"
echo "5. Verify NO literal ANSI codes like [38;5;4m appear"
echo "6. Both narrow panes should display colors correctly on wrapped lines"
echo
echo "Press Enter to start hyperlist with the test file..."
read

./hyperlist test_wrap.hl