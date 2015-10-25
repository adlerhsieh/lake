require "./lake/*"
require "colorize"
require "option_parser"

error  = Lake::Exception.new
finder = Lake::Finder.new
finder.set_dirs

OptionParser.parse! do |parser|
  parser.on("-b", "--build", "Build all tasks, ignoring existing tasks.") {
    finder.create_tasks
    exit 0
  }
  parser.on("-r", "--rebuild", "Rebuild all tasks.") {
    finder.recreate_tasks
    exit 0
  }
  parser.on("-h", "--help", "Shows this message.") {
    puts parser 
    exit 0
  }
  parser.on("-p", "--purge", "Remove .lake directory and Lakefile"){
    system("rm -rf .lake")
    system("rm Lakefile")
    puts "Purged."
    exit 0
  }
  parser.banner = "Basic usage: lake -t [taskname]"
end

if ARGV
  runner = Lake::Runner.new(ARGV)
  finder.create_tasks if runner.has_task?
  runner.tasks.each do |name|
    error.missing_task(name) unless finder.tasks.includes?(name)
    runner.run(name)
  end
  exit 0 if runner.has_task?
end

error.no_task if finder.tasks.size == 0
puts "Available tasks: #{finder.tasks}"
exit 0
