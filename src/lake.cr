require "./lake/*"
require "colorize"

module Lake
  
end

finder = Lake::Finder.new

unless finder.lakefile
  abort("Error: Missing Lakefile".colorize(:red))
end

unless Dir.exists?("#{finder.root}/.lake")
  Dir.mkdir("#{finder.root}/.lake")
  Dir.mkdir("#{finder.root}/.lake/tasks") unless Dir.exists?("#{finder.root}/.lake/tasks")
  Dir.mkdir("#{finder.root}/.lake/bin")   unless Dir.exists?("#{finder.root}/.lake/bin")
end

File.read(finder.lakefile)

