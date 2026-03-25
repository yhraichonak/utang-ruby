
require 'gherkin/parser'
require_relative '../../common/helpers/tr_helper'

testRailRunId = ARGV[0]
nonExecutedOnly = ARGV[1]||'true'
featuresFilters = ARGV[2]

automated_tests_in_run = tr_get_tests_from_test_run(testRailRunId, nonExecutedOnly)
@output_raw_file="tr_exec_candidates.txt"

File.open(@output_raw_file, "w") do |f|
  for automated_test_in_run in automated_tests_in_run do
    Dir['**/*.feature'].select{|f| File.file?(f) }.each do |filepath|
      if File.readlines("#{Dir.pwd}/#{filepath}", :encoding => 'UTF-8').grep(/.*#{automated_test_in_run["case_id"]}.*/).any?
        puts("Trying to parse... #{filepath}")
        begin
          gherkin_document = Gherkin::Parser.new.parse(File.read(filepath))
        rescue => e
          puts("Unable to parse Gherkin file #{filepath} due to error #{e}")
        end
        if featuresFilters.nil? or filepath.match?(".*("+featuresFilters.gsub(",","|")+").*")
          if nonExecutedOnly.downcase == "false"
              puts("#{filepath}")
              f.write("#{filepath}\n")
            else
              r = tr_get_case_results_from_run(testRailRunId,automated_test_in_run["case_id"])
              if r.empty?
                puts("#{filepath}")
                f.write("#{filepath}\n")
              else
                r.sort_by {|obj| obj["id"]}
                if (r[0]["custom_custom_test_field"].nil?)
                  if (r[0]['status_id']!=1)
                    puts("#{filepath}")
                    f.write("#{filepath}\n")
                  end
                  else
                    step_resuls=  r[0]["custom_custom_test_field"].filter{|t| t['status_id']!=1}
                    for step_result in step_resuls do
                      scenario_name= "Scenario#{step_result["content"].split("\n")[0].split("Scenario")[1]}"
                     scenario_definition=gherkin_document.feature.children.find{|t| !t.scenario.nil? && !t.scenario.name.nil? && t.scenario.name.include?(scenario_name.gsub("Scenario: ",""))}
                      if scenario_definition.nil?
                        puts "Unable to find #{scenario_name} execution result under #{filepath} as candidate for execution from Test Rail. Running all feature.."
                        puts("#{filepath}")
                        f.write("#{filepath}\n")
                      else
                        puts("#{filepath}:#{scenario_definition.scenario.location.line}")
                        f.write("#{filepath}:#{scenario_definition.scenario.location.line}\n")
                      end

                    end
                  end
                end
            end
          end
      end
    end
  end
end

File.write(@output_raw_file, File.readlines(@output_raw_file).uniq.join)
puts "In total [#{File.foreach(@output_raw_file).count}] candidates identified for execution."



