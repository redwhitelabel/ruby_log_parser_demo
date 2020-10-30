#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'src/parser'

begin
  Parser.call(file_path: ARGV[0])
rescue StandardError => e
  warn e.message
end
