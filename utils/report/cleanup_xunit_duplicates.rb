if __FILE__ == $0
  reportDir = ARGV[0]
  Dir.foreach(reportDir) do |filename|
    full_file_name=reportDir+"/"+filename
    next if filename == '.' or filename == '..'
    text = open(full_file_name, "r") { |io| io.read.encode("UTF-8", invalid: :replace, replace: "") }
    new_contents = text.gsub(/<testcase.*testcase /m, '<testcase ')
    File.open(full_file_name, "w") {|file| file.puts new_contents }
  end
end
