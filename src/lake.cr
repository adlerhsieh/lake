require "./lake/*"
require "colorize"
require "option_parser"

module Lake
end

finder = Lake::Finder.new
error  = Lake::Exception.new

error.missing_lakefile unless finder.lakefile

Dir.mkdir("#{finder.root}/.lake")       unless Dir.exists?("#{finder.root}/.lake")
Dir.mkdir("#{finder.root}/.lake/tasks") unless Dir.exists?("#{finder.root}/.lake/tasks")
Dir.mkdir("#{finder.root}/.lake/bin")   unless Dir.exists?("#{finder.root}/.lake/bin")

# File.read(finder.lakefile)

# puts "Initializing..."
Dir.entries("#{finder.root}/.lake").each do |file|
  is_file = File.file?("#{finder.root}/.lake/#{file}")
  is_cr   = File.extname(file) == ".cr"
  next unless is_file && is_cr
  builder = Lake::Builder.new("#{finder.root}/.lake/#{file}")
  unless builder.up_to_date?
    builder.copy
    builder.prepend_dsl
    builder.build
  end
end

OptionParser.parse! do |parser|
  # parser.on("name","Specifies a task name") { |name| 
  #   system finder.find_task(name) 
  # }
  parser.on("-t TASK","--task=TASK","Run a specified task") { |name| 
    error.missing_task(name) unless finder.tasks.includes?(name)
    system finder.find_task(name) 
  }
  parser.on("-h","--help","Show this message") { puts parser }
  parser.banner = "Basic usage: lake -t [taskname]"
end

puts "Usage: lake -t [taskname]"
puts "Available tasks: #{finder.tasks}"
