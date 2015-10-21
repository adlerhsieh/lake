module Lake
  class Finder
    getter :root
    getter :lakefile
    property :tasks
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

  end
end
