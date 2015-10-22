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
      system("touch Lakefile")          unless File.file?("#{@root}/Lakefile")
      Dir.mkdir("#{@root}/.lake")       unless Dir.exists?("#{@root}/.lake")
      Dir.mkdir("#{@root}/.lake/tasks") unless Dir.exists?("#{@root}/.lake/tasks")
      Dir.mkdir("#{@root}/.lake/bin")   unless Dir.exists?("#{@root}/.lake/bin")
    end

    def create_tasks
      Dir.entries("#{@root}/.lake").each do |file|
        is_file = File.file?("#{@root}/.lake/#{file}")
        is_cr   = File.extname(file) == ".cr"
        next unless is_file && is_cr
        Lake::Builder.new("#{@root}/.lake/#{file}").build_tasks
      end
    end

  end
end
