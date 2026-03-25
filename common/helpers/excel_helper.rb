require 'roo'
require 'diffy'

class ExcelHelper

  def process_csv(csv_file, rules)
    rules.each do |rule|
      rule_target=rule.split(":")[0]
      rule_pattern=rule.split(":")[1]
      csv_file.each_with_index do |row, row_index|
        row.each_with_index do |cell,cell_index|
          if !cell.nil? && cell.match?(rule_pattern)
            if rule_target.include?("cell")
              csv_file[row_index][cell_index]="{IGNORED_CELL}"
            end
            if rule_target.include?("column")
              ((row_index+1)..(row.count-1)).each do  |replace_row|
                if  !csv_file[replace_row].nil? and !csv_file[replace_row][cell_index].nil?
                  csv_file[replace_row][cell_index]="{IGNORED_COLUMN}"
                end
              end
            end
          end
        end
      end
    end
    csv_file.collect{ |a| a.collect{ |b| b.nil? ? b : "\"#{b}\"" } }
  end

  def compare_excels(baseline_file, test_file,filter_rules)
    test_spreadsheet = Roo::Spreadsheet.open(test_file)
    baseline_spreadsheet = Roo::Spreadsheet.open(baseline_file)
    File.write("compare_xml.html","<style>"+Diffy::CSS_COLORBLIND_1+"</style>"+Diffy::Diff.new(baseline_spreadsheet.sheet(0).to_xml, test_spreadsheet.sheet(0).to_xml, :include_plus_and_minus_in_html => true).to_s(:html))
    open('compare_csv.html', 'w') { |f|
      f.puts "<style>#{Diffy::CSS_COLORBLIND_1}</style>"
      baseline_spreadsheet.sheets.each do |sheet|
        delta = Diffy::Diff.new(test_spreadsheet.sheet(sheet).to_csv, baseline_spreadsheet.sheet(sheet).to_csv, :include_plus_and_minus_in_html => true)
        unless delta.to_s.empty?
          f.puts "Sheet [#{sheet}] differences:"
          f.puts delta.to_s(:html)
          f.puts "</br>"
        end
      end
    }

    open('compare_txt.txt', 'w') { |f|
      baseline_spreadsheet.sheets.each do |sheet|
        baseline_csv=CSV.parse(baseline_spreadsheet.sheet(sheet).to_csv)
        test_csv=CSV.parse(test_spreadsheet.sheet(sheet).to_csv)
        baseline_csv=process_csv(baseline_csv,filter_rules)
        test_csv=process_csv(test_csv,filter_rules)
        baseline_csv=baseline_csv.collect{|t| t.join(",")}.join("\n")+"\n"
        test_csv=test_csv.collect{|t| t.join(",")}.join("\n") + "\n"
        delta = Diffy::Diff.new(baseline_csv, test_csv, :include_plus_and_minus_in_html => true)
        unless delta.to_s.empty?
          log_info("Baseline file====================\n #{baseline_csv}\n")
          log_info("Test file==================\n #{test_csv}\n")
          f.puts "Sheet [#{sheet}] differences:"
          f.puts "-----------------------------"
          f.puts delta.to_s(:text)
          f.puts "\n"
        end
      end
    }
  end
end
