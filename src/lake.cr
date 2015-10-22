require "./lake/*"
require "colorize"
require "option_parser"

module Lake
end

finder = Lake::Finder.new
error  = Lake::Exception.new

# error.missing_lakefile unless finder.lakefile

finder.set_dirs

Dir.entries("#{finder.root}/.lake").each do |file|
  is_file = File.file?("#{finder.root}/.lake/#{file}")
  is_cr   = File.extname(file) == ".cr"
  next unless is_file && is_cr
  Lake::Builder.new("#{finder.root}/.lake/#{file}").build_tasks
end

OptionParser.parse! do |parser|
  parser.on("-t TASK", "--task=TASK", "Run a specified task") { |name| 
    error.missing_task(name) unless finder.tasks.includes?(name)
    system finder.find_task(name) 
    abort(nil)
  }
  parser.on("-h", "--help", "Show this message") { puts parser }
  parser.banner = "Basic usage: lake -t [taskname]"
end

puts "Usage: lake -t [taskname]"
puts "Available tasks: #{finder.tasks}"
