require "./spec_helper"

# Cleaning files from previous specs
# describe "Purge" do
#   it "all files" do
#     system("./lake -p")
#     File.directory?("#{ENV["PWD"]}/.lake").should be_false
#     File.file?("#{ENV["PWD"]}/Lakefile").should   be_false
#   end
#   it "the executable" do
#     system("rm lake")
#     File.file?("#{ENV["PWD"]}/lake").should be_false
#   end
# end
system("rm Lakefile")
system("rm -rf .lake")
system("rm create.txt")
