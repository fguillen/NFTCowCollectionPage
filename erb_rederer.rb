require "erb"

class Cow
  attr_reader :name, :file_name

  def initialize(name:, file_name:)
    @name = name
    @file_name = file_name
  end
end


cows = []

Dir.entries("#{__dir__}/cows/").select { |e| e.end_with? ".png" }.sort.each do |file_name|
  puts file_name
  name = file_name.match(/CowNTF - \d\d\d - (.*)\.png/)[1]
  cow = Cow.new(name: name, file_name: file_name)
  cows.push cow
end

template = ERB.new(File.read("#{__dir__}/index.html.erb"))

File.open("#{__dir__}/index.html", "w") do |f|
  f.write template.result(binding)
end
