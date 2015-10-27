require "./spec_helper"

describe "Lake" do
  it "builds lake executable" do
    system("crystal build ./src/lake.cr")
    File.file?("#{ENV["PWD"]}/lake").should be_true
  end

  it "without option and tasks" do
    system("./lake").should be_true
    File.file?("#{ENV["PWD"]}/Lakefile").should   be_false
    File.directory?("#{ENV["PWD"]}/.lake").should be_false
  end

  it "creates tasks folder" do
    system("./lake -b").should be_true
    File.file?("#{ENV["PWD"]}/Lakefile").should   be_true
    File.directory?("#{ENV["PWD"]}/.lake").should be_true
  end

  it "# creates tasks with helper" do
    File.write("#{ENV["PWD"]}/.lake/#{file_name[0]}.cr", task_content[0])
    File.write("#{ENV["PWD"]}/.lake/#{file_name[1]}.cr", task_content[1])
    File.file?("#{ENV["PWD"]}/.lake/#{file_name[0]}.cr").should be_true
    File.file?("#{ENV["PWD"]}/.lake/#{file_name[1]}.cr").should be_true
  end

  describe "-b" do
    it "builds tasks" do
      system("./lake -b")
      File.file?("#{ENV["PWD"]}/.lake/tasks/hello.cr").should  be_true
      File.file?("#{ENV["PWD"]}/.lake/tasks/create.cr").should be_true
      File.file?("#{ENV["PWD"]}/.lake/tasks/go.cr").should     be_true
      File.file?("#{ENV["PWD"]}/.lake/bin/hello").should       be_true
      File.file?("#{ENV["PWD"]}/.lake/bin/create").should      be_true
      File.file?("#{ENV["PWD"]}/.lake/bin/go").should          be_true
    end

    it "deletes non-character symbols in task name" do
      File.file?("#{ENV["PWD"]}/.lake/tasks/hi-.cr").should    be_false
      File.file?("#{ENV["PWD"]}/.lake/tasks/hi.cr").should     be_true
      File.file?("#{ENV["PWD"]}/.lake/bin/hi").should          be_true
      File.file?("#{ENV["PWD"]}/.lake/bin/hi-").should         be_false
    end
  end
end

describe "options" do
  it "--help" do
    system("./lake -h").should be_true
  end
  it "--version" do
    system("./lake -v").should be_true
  end
end
