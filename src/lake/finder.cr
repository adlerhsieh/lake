module Lake
  class Finder
    getter :root
    getter :lakefile
    property :bin
    def initialize
      @root     = ENV["PWD"]
      @lakefile = find_lakefile.to_s
    end

    def find_lakefile
      if File.file?("#{@root}/Lakefile")
        return "#{@root}/Lakefile"
      end
    end

    def find_lake_dir
      if File.directory?("#{@root}/.lake")
        return "#{@root}/.lake"
      end
    end

    def find_task(filename)
      "#{@root}/.lake/bin/#{filename}"
    end

    def tasks
      Dir.entries("#{@root}/.lake/bin").map {|file|
        file if File.file?("#{@root}/.lake/bin/#{file}")
      }.compact.join(", ")
    end

    def set_dirs
      unless File.file?("#{@root}/Lakefile")
        system("touch Lakefile")          
        puts "#{"Created".colorize(:green)}: #{@root}/Lakefile"
      end
      unless Dir.exists?("#{@root}/.lake") 
        Dir.mkdir("#{@root}/.lake")       
        puts "#{"Created".colorize(:green)}: #{@root}/.lake"
      end
      unless Dir.exists?("#{@root}/.lake/tasks")
        Dir.mkdir("#{@root}/.lake/tasks") 
        puts "#{"Created".colorize(:green)}: #{@root}/.lake/bin"
      end
      unless Dir.exists?("#{@root}/.lake/bin")
        Dir.mkdir("#{@root}/.lake/bin")   
        puts "#{"Created".colorize(:green)}: #{@root}/.lake/tasks"
      end
    end

    def create_tasks
      Dir.entries("#{@root}/.lake").each do |file|
        is_file = File.file?("#{@root}/.lake/#{file}")
        is_cr   = File.extname(file) == ".cr"
        next unless is_file && is_cr
        Lake::Builder.new("#{@root}/.lake/#{file}").build_tasks
      end
      # Lake::Builder.new(find_lakefile.to_s).build_tasks
    end

  end
end
