require "./spec_helper"

system("rm Lakefile")
system("rm lake")
system("rm -rf .lake")
system("rm create.txt")

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
end
