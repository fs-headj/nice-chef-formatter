nice_chef_formatter
===================

Formatter for chef with execution times for every cookbook/recipe and simplified output
Color codes:
- Green, resource had nothing to do. It was already applied
- Yellow, resource has done work. Applied
- Blue, resource was skipped due to conditional (only_if, not_if, ...)
