#!/usr/bin/env ruby
#
# str2go <package_name> <constant_name> <path_to_file>
#

package_name  = ARGV[0]
constant_name = ARGV[1]

input = $stdin
output = $stdout

def line_to_go(line)
  '"' + line.gsub('\\', '\\\\\\').gsub("\n", '\n').gsub('"', '\"').gsub(/[^[:ascii:]]/) do |char|
    "\\#{char.ord}"
  end + '"'
end

def lines_to_go(lines)
  lines.map do |line|
    "\t#{line_to_go(line)}"
  end.join(" +\n").sub("\t", '')
end

output.puts "package #{package_name}"
output.puts

output.puts "const #{constant_name} = #{lines_to_go(input.lines)}"
