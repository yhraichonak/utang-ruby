require_relative '../../common/helpers/tr_helper'
require_relative '../../common/helpers/props_helper'

case ARGV.length
when 9
  filePath = ARGV[0]
  testRailRunId = ARGV[1]
  browser_type = ARGV[2]
  browser_version = ARGV[3]
  test_environment = ARGV[4]
  test_branch = ARGV[5]
  site_url = ARGV[6]
  app_version = ARGV[7]
  build_number = ARGV[8]
when 3
  filePath = ARGV[0]
  testRailRunId = ARGV[1]
  result_comment = ARGV[2]
when 4
  filePath = ARGV[0]
  testRailRunId = ARGV[1]
  result_comment = ARGV[2]
  acms=true
else
  puts '-- the args --'
  puts "file_path: #{ARGV[0]}"
  puts "test_rail_run_id: #{ARGV[1]}"
  puts "browser: #{ARGV[2]}"
  puts "browser_version: #{ARGV[3]}"
  puts "site_number: #{ARGV[4]}"
  puts "branch: #{ARGV[5]}"
  puts "site_url: #{ARGV[6]}"
  puts "app_version: #{ARGV[7]}"
  puts "build_number: #{ARGV[8]}"
  puts "features_root_folder: #{ARGV[9]}"
  puts "overwrite_same_results: #{ARGV[10]}"
  puts '-- end of args --'
  raise('Wrong number of parameters provided (3 or 9 are allowed)')
end
$testdata = IniFile.load('ACMS/testdata.ini')
result_comment=process_param(result_comment)
puts "test_run_id used: #{testRailRunId}"

pasedTestsPath = "#{filePath}passed_v2.txt"
if result_comment.nil?
  result_comment = "Browser Type: #{browser_type} \nBrowser Version: #{browser_version} \
          \nTest Env: #{test_environment} \nBranch: #{test_branch} \nSite Url: #{site_url} \
          \nApp Version: #{app_version} \nBuild Number: #{build_number} "
end

begin
  ef = File.open(pasedTestsPath, 'r')
rescue Exception
  puts "File with reports was not found #{pasedTestsPath}"
  return
end

ef.each_line do |line|
  line_parts = line.strip.split('::')
  begin
    tr_do_import_passed_scenario_result(testRailRunId, line_parts[3], line_parts[2], result_comment)
    puts "Importing PASSED result for #{line_parts[3]} [#{line_parts[2]}]"
  rescue => e
    puts("Error on attempt to import result #{line}. #{e}")
  end
end

ef.close
