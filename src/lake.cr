require "./lake/*"
require "colorize"
require "option_parser"

error  = Lake::Exception.new
finder = Lake::Finder.new

OptionParser.parse! do |parser|
  parser.on("[taskname]", "Run a specified task.") {}
  parser.on("-b", "--build", "Build all tasks, ignoring existing tasks.") {
    finder.prepare
    finder.create_tasks
    exit 0
  }
  parser.on("-r", "--rebuild", "Rebuild all tasks.") {
    finder.prepare
    finder.recreate_tasks
    exit 0
  }
  parser.on("-h", "--help", "Shows this message.") {
    puts parser 
    exit 0
  }
  # parser.on("-p", "--purge", "Removes .lake directory and Lakefile."){
  #   system("rm -rf .lake") if File.directory?("#{ENV["PWD"]}/.lake")
  #   system("rm lake")      if File.file?("#{ENV["PWD"]}/lake")
  #   system("rm Lakefile")  if File.file?("#{ENV["PWD"]}/Lakefile")
  #   puts "Purged."
  #   exit 0
  # }
  parser.on("-v", "--version", "Display current version"){
    puts Lake::VERSION
    exit 0
  }
  # parser.banner = "Basic usage: lake [taskname]"
end

if ARGV.size > 0
  runner = Lake::Runner.new(ARGV)
  if runner.has_task?
    finder.prepare
    finder.create_tasks 
    runner.tasks.each do |name|
      error.missing_task(name) unless finder.tasks.includes?(name)
      runner.run(name)
    end
    exit 0
  else
    error.no_task
  end
end

puts "No specified task."
exit 0
