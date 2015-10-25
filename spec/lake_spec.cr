require "./spec_helper"

describe "Purge" do
  it "all files" do
    system("./lake -p")
    File.directory?("#{ENV["PWD"]}/.lake").should be_false
    File.file?("#{ENV["PWD"]}/Lakefile").should   be_false
  end
  it "the executable" do
    system("rm lake")
    File.file?("#{ENV["PWD"]}/lake").should be_false
  end
end

describe "Lake" do
  it "builds lake executable" do
    system("crystal build ./src/lake.cr")
    File.file?("#{ENV["PWD"]}/lake").should be_true
  end

  it "without option" do
    system("./lake")
    File.file?("#{ENV["PWD"]}/Lakefile").should   be_true
    File.directory?("#{ENV["PWD"]}/.lake").should be_true
  end

  it "# creates tasks" do
    File.write("#{ENV["PWD"]}/.lake/hello.cr",
               "Task.hello\n"\
               "puts \"hello world\"\n"\
               "Task.create\n"\
               "system(\"touch create.txt\")"
              )
    File.write("#{ENV["PWD"]}/.lake/go.cr",
               "Task.go\n"\
               "puts \"We need to go now.\"\n"
              )
    File.file?("#{ENV["PWD"]}/.lake/hello.cr").should be_true
    File.file?("#{ENV["PWD"]}/.lake/go.cr").should    be_true
  end

  it "-b" do
    system("./lake -b")
    File.file?("#{ENV["PWD"]}/.lake/tasks/hello.cr").should  be_true
    File.file?("#{ENV["PWD"]}/.lake/tasks/create.cr").should be_true
    File.file?("#{ENV["PWD"]}/.lake/tasks/go.cr").should     be_true
    File.file?("#{ENV["PWD"]}/.lake/bin/hello").should       be_true
    File.file?("#{ENV["PWD"]}/.lake/bin/create").should      be_true
    File.file?("#{ENV["PWD"]}/.lake/bin/go").should          be_true
  end
end

describe "options" do
  it "exit with 1 without an option" do
    system("./lake")
    system("echo $?").should be_true
  end
  it "exit with 1 with an option" do
    system("./lake -h")
    system("echo $?").should be_true
  end
end

describe "Run tasks" do
  it "-t create" do
    system("./lake -t create")
    File.file?("#{ENV["PWD"]}/create.txt").should be_true
  end
end
