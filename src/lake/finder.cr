module Lake
  class Finder
    getter :pwd
    def initialize
      @pwd = ENV["PWD"]
    end

    def lakefile
      if File.file?("#{@pwd}/Lakefile")
        return "#{@pwd}/Lakefile"
      else
        puts "Missing Lakefile"
        abort(1)
      end
    end
  end
end
