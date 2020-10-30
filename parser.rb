#!/usr/bin/env ruby
path = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)

require 'lib/parser'

begin
  Parser.call(file_path: ARGV[0])
rescue StandardError => e
  warn e.message
end
