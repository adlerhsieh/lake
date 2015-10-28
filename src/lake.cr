require "./lake/*"
require "colorize"
require "option_parser"

error  = Lake::Exception.new
finder = Lake::Finder.new

OptionParser.parse! do |parser|
  parser.banner = "Usage:"
  parser.on("[taskname]", "Run specified tasks.") {}
  parser.on("-g", "--global", "Run specified tasks on global Lakefile.") {
    $home = true
    finder.change_root
  }
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
  parser.on("-v", "--version", "Display current version"){
    puts Lake::VERSION
    exit 0
  }
end

if ARGV.size > 0
  runner = Lake::Runner.new(ARGV,$home)
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

puts "No task found."
exit 0
