require "./spec_helper"

system("rm lake")
system("rm -rf .lake")
system("rm Lakefile")

describe "Lake" do
  it "builds lake executable" do
    system("crystal build ./src/lake.cr")
    File.file?("#{ENV["PWD"]}/lake").should be_true
  end

  it "creates directory and Lakefile" do
    system("./lake")
    File.file?("#{ENV["PWD"]}/Lakefile").should   be_true
    File.directory?("#{ENV["PWD"]}/.lake").should be_true
  end

  it "creates tasks" do
    File.write("#{ENV["PWD"]}/.lake/hello.cr",
               "Task.hello\n"\
               "puts \"hello world\"\n"\
               "Task.salute\n"\
               "puts \"salute\""
              )
    File.write("#{ENV["PWD"]}/.lake/go.cr",
               "Task.go\n"\
               "puts \"We need to go now.\"\n"
              )
    File.file?("#{ENV["PWD"]}/.lake/hello.cr").should be_true
    File.file?("#{ENV["PWD"]}/.lake/go.cr").should    be_true
  end

  it "builds tasks" do
    system("./lake -b")
    File.file?("#{ENV["PWD"]}/.lake/tasks/hello.cr").should  be_true
    File.file?("#{ENV["PWD"]}/.lake/tasks/salute.cr").should be_true
    File.file?("#{ENV["PWD"]}/.lake/tasks/go.cr").should     be_true
    File.file?("#{ENV["PWD"]}/.lake/bin/hello").should       be_true
    File.file?("#{ENV["PWD"]}/.lake/bin/salute").should      be_true
    File.file?("#{ENV["PWD"]}/.lake/bin/go").should          be_true
  end
end
