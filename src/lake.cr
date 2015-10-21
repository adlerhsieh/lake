require "./lake/*"
require "colorize"

module Lake
  
end

finder = Lake::Finder.new

unless finder.lakefile
  abort("Error: Missing Lakefile".colorize(:red))
end

Dir.mkdir("#{finder.root}/.lake")       unless Dir.exists?("#{finder.root}/.lake")
Dir.mkdir("#{finder.root}/.lake/tasks") unless Dir.exists?("#{finder.root}/.lake/tasks")
Dir.mkdir("#{finder.root}/.lake/bin")   unless Dir.exists?("#{finder.root}/.lake/bin")

# File.read(finder.lakefile)

Dir.entries("#{finder.root}/.lake").each do |file|
  is_file = File.file?("#{finder.root}/.lake/#{file}")
  is_cr   = File.extname(file) == ".cr"
  if is_file && is_cr
    builder = Lake::Builder.new("#{finder.root}/.lake/#{file}")
    unless builder.match
      builder.copy
      builder.prepend_dsl
      builder.build
    end
    # system(builder.file(:bin).to_s)
  end
end



