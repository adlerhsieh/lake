module Lake
  class Builder
    def initialize(@file)
      @content  = File.read_lines(@file.to_s)
      @root     = @file.split("/")[0..-2].join("/")
      @filename = @file.split("/")[-1]
    end

    def file(dir)
      case dir
      when :tasks
        "#{@root}/tasks/#{@filename}"
      when :bin
        "#{@root}/bin/#{@filename[0..-4]}"
      end
    end

    # Prepends Lake DSL to a task
    def prepend_dsl
      # WIP
    end

    # Matches task content with source
    def up_to_date?
      if File.file?(file(:tasks).to_s)
        @task == File.read(file(:tasks).to_s)
      else
        false
      end
    end

    def separates_all_tasks
      tasks = {} of String? => MemoryIO | String?
      title = ""
      desc  = [] of String
      # index = -1
      @content.each_with_index do |line, index|
        if /^Task\./ =~ line
          title = line.match(/^Task\.(\w+)/) {|md| md[1] }
        else
          desc << line
        end
        if index + 1 == @content.size || /^Task\./ =~ @content[index + 1]
          unless title == ""
            tasks[title] = desc.join("\n")
          end
          title = ""
          desc = [] of String
        end
      end
    end

    # Parses content of a file and return 
    def parse
      # system("cp #{@file} #{file(:tasks)}")
    end

    # Copies task to task directory
    def copy

    end

    # Runs crystal build and move it to bin directory
    def build
      system("crystal build #{file(:tasks)} -o #{file(:bin)}")
    end

  end
end
