# frozen_string_literal: true
require 'date'
Before do
  @PatientHeader_Bar = PatientHeader_Bar.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
end

Then(/^I should see the cardio patient info in the header$/) do
  patient_info_object = @PatientHeader_Bar.patient_info_object
  @patient_header_name = patient_info_object['name']
  @patient_header_age_sex = patient_info_object['age_sex']
  @patient_info_mrn_location = patient_info_object['mrn_location']

  if INFO == true
    puts @patient_header_name
    puts @patient_header_age_sex
    puts @patient_info_mrn_location
  end

  s = @patient_header_name
  space = (0...s.length).find_all { |i| s[i, 1] == ' ' }
  separator = (0...s.length).find_all { |i| s[i, 1] == '•' }

  @patient_header_name = s[0..(space[1] - 1)]
  puts "header name after = #{@patient_header_name}"
  @patient_header_gender = s[(space[-3] + 1)..(separator[0] - 2)]
  @patient_header_age = s[(separator[0] + 2)..s.length - 1]

  if INFO == true
    puts '---------------'
    puts @patient_header_name
    puts @patient_header_gender
    puts @patient_header_age
  end

  t = @patient_info_mrn_location
  puts t if INFO == true
  # space = (0...t.length).find_all { |i| t[i, 1] == ' ' }
  separator = (0...t.length).find_all { |i| t[i, 1] == '•' }

  # @patient_header_mrn = t[0..(separator[0] - 2)]
  # @patient_header_dob = t[(separator[0] + 2)..(separator[1] - 2)]
  # @patient_header_unit = t[(separator[1] + 2)..(separator[2] - 2)]

  if separator.count == 2
    @patient_header_mrn = t[0..(separator[0] - 2)]
    @patient_header_dob = nil
    @patient_header_unit = t[(separator[0] + 2)..(separator[1] - 2)]
    @patient_header_bed = nil
    @patient_header_site = t[(separator[1] + 2)..(t.length - 1)]
  elsif separator.count == 3
    @patient_header_mrn = t[0..(separator[0] - 2)]
    @patient_header_dob = t[(separator[0] + 2)..(separator[1] - 2)]
    @patient_header_unit = t[(separator[1] + 2)..(separator[2] - 2)]
    @patient_header_bed = nil
    @patient_header_site = t[(separator[2] + 2)..(t.length - 1)]
  else
    @patient_header_mrn = t[0..(separator[0] - 2)]
    @patient_header_dob = t[(separator[0] + 2)..(separator[1] - 2)]
    @patient_header_unit = t[(separator[1] + 2)..(separator[2] - 2)]
    @patient_header_bed = t[(separator[2] + 2)..(separator[3] - 2)]
    @patient_header_site = t[(separator[3] + 2)..(t.length - 1)]
  end

  if INFO == true
    puts @patient_header_mrn
    puts @patient_header_dob
    puts @patient_header_bed
    puts @patient_header_unit
    puts @patient_header_site
    puts '---------------'
  end

  expect(@patient_list_name).to include @patient_header_name

  if @patient_header_gender != 'U'
    expect(@patient_list_gender).to include @patient_header_gender
    expect(@patient_list_age).to eq @patient_header_age
  end

  if !@patient_list_dob.nil? && !@patient_header_mrn.nil?
    expect(@patient_header_mrn).to include @patient_list_mrn
    expect(@patient_list_dob).to include @patient_header_dob unless @patient_header_dob.nil?
  end
end

Then(/^I should see the pm patient info in the header$/) do
  patient_info_object = @PatientHeader_Bar.patient_info_object
  @patient_header_name = patient_info_object['name']
  @patient_header_age_sex = patient_info_object['age_sex']
  @patient_info_mrn_location = patient_info_object['mrn_location']

  if INFO == true
    puts @patient_header_name
    puts @patient_header_age_sex
    puts @patient_info_mrn_location
  end

  s = @patient_header_name
  # space = (0...s.length).find_all { |i| s[i, 1] == ' ' }
  separator = (0...s.length).find_all { |i| s[i, 1] == '•' }

  @patient_header_name = s.slice(0..(separator[0] - 4))
  @patient_header_gender = s[(separator[0] - 2)..(separator[0] - 2)]
  @patient_header_age = s[(separator[0] + 2)..s.length - 1]

  if INFO == true
    puts '---------------'
    puts @patient_header_name
    puts @patient_header_gender
    puts @patient_header_age
  end

  t = @patient_info_mrn_location
  puts t if INFO == true
  # space = (0...t.length).find_all { |i| t[i, 1] == ' ' }
  separator = (0...t.length).find_all { |i| t[i, 1] == '•' }

  case separator.count
  when 3
    @patient_header_mrn = t[0..(separator[0] - 2)]
    @patient_header_dob = nil
    @patient_header_unit = t[(separator[0] + 2)..(separator[1] - 2)]
    @patient_header_bed = t[(separator[1] + 2)..(separator[2] - 2)]
    @patient_header_site = t[(separator[2] + 2)..(t.length - 1)]
  when 1
    @patient_header_mrn = nil
    @patient_header_dob = nil
    @patient_header_unit = t[0..(separator[0] - 2)]
    @patient_header_bed = t[(separator[0] + 2)..(t.length - 1)]
    @patient_header_site = nil
  else
    @patient_header_mrn = t[0..(separator[0] - 2)]
    @patient_header_dob = t[(separator[0] + 2)..(separator[1] - 2)]
    @patient_header_unit = t[(separator[1] + 2)..(separator[2] - 2)]
    @patient_header_bed = t[(separator[2] + 2)..(separator[3] - 2)]
    @patient_header_site = t[(separator[3] + 2)..(t.length - 1)]
  end

  if INFO == true
    puts @patient_header_mrn
    puts @patient_header_dob
    puts @patient_header_bed
    puts @patient_header_unit
    puts @patient_header_site
    puts '---------------'
  end

  expect(@patient_list_name).to include @patient_header_name

  if @patient_header_gender != 'U'
    expect(@patient_list_gender).to include @patient_header_gender
    expect(@patient_list_age.to_s).to eq @patient_header_age.to_s
  end

  if !@patient_list_dob.nil? && !@patient_header_mrn.nil?
    expect(@patient_header_mrn.to_s).to include @patient_list_mrn.to_s
    if (@patient_header_dob.include?("Z"))
      processed_date = Date.strptime(@patient_list_dob.gsub("DOB: ",""), "%m/%d/%Y").strftime("%Y-%m-%dT%H:%M:%SZ")
    else
      processed_date=@patient_list_dob.gsub("DOB: ","")
    end

    expect(@patient_header_dob).to match(".*(#{processed_date}).*") unless @patient_header_dob.nil?
  end
end

When(/^I click the Back button in patient header$/) do
  sleep 2
  @PM_Navigation_Menu.back_button.click
  # @selenium.navigate.back
end

When(/^I click the expand icon menu button$/) do
  @PatientHeader_Bar.expandNavigation_button.click
end

Then(/^I should see the expanded navigation links$/) do
  expect(@PatientHeader_Bar.main_header['is_open']).to be_truthy
  expect(@PatientHeader_Bar.userNavigation_menu).to be_truthy
end

Then(/^I should not see the expanded navigation links$/) do
  expect(@PatientHeader_Bar.main_header['is_open']).to be_falsey
end

Then(/^I should see on first line as \[Last Name\], \[First Name\]\*\[GENDER\]\*\[AGE\] of patient header$/) do
  puts @patient_header_name if INFO == true
  puts @patient_header_age_sex if INFO == true
end

Then(/^I should see on second line as UNIT\*BED of patient header$/) do
  puts @patient_info_mrn_location if INFO == true
end

Then(/^I should see on first line as \[Last Initial\], \[First Initial\]\*\[GENDER\]\*\[AGE\] of patient header$/) do
  puts @patient_header_name if INFO == true
  puts @patient_header_age_sex if INFO == true
end

Then(/^I should see the pm patient info in the header for role switch$/) do
  patient_info_object = @PatientHeader_Bar.patient_info_object
  @patient_header_name = patient_info_object['name']
  @patient_header_age_sex = patient_info_object['age_sex']
  @patient_info_mrn_location = patient_info_object['mrn_location']

  s = @patient_header_name
  separator = (0...s.length).find_all { |i| s[i, 1] == '•' }

  @patient_header_name = s.slice(0..(separator[0] - 4))
  @patient_header_gender = s[(separator[0] - 2)..(separator[0] - 2)]
  @patient_header_age = s[(separator[0] + 2)..s.length - 1]
  t = @patient_info_mrn_location
  puts t if INFO == true
  separator = (0...t.length).find_all { |i| t[i, 1] == '•' }

  case separator.count
  when 3
    @patient_header_mrn = t[0..(separator[0] - 2)]
    @patient_header_dob = nil
    @patient_header_unit = t[(separator[0] + 2)..(separator[1] - 2)]
    @patient_header_bed = t[(separator[1] + 2)..(separator[2] - 2)]
    @patient_header_site = t[(separator[2] + 2)..(t.length - 1)]
  when 1
    @patient_header_mrn = nil
    @patient_header_dob = nil
    @patient_header_unit = t[0..(separator[0] - 2)]
    @patient_header_bed = t[(separator[0] + 2)..(t.length - 1)]
    @patient_header_site = nil
  else
    @patient_header_mrn = t[0..(separator[0] - 2)]
    @patient_header_dob = t[(separator[0] + 2)..(separator[1] - 2)]
    @patient_header_unit = t[(separator[1] + 2)..(separator[2] - 2)]
    @patient_header_bed = t[(separator[2] + 2)..(separator[3] - 2)]
    @patient_header_site = t[(separator[3] + 2)..(t.length - 1)]
  end

  expect(@patient_list_name).to include @patient_header_name
  puts "$$$$ patient list name is #{@patient_list_name}"

  if @patient_header_gender != 'U'
    pln = @patient_list_name
    pln_separator = (0...pln.length).find_all { |i| pln[i, 1] == '•' }
    @patient_list_gender = pln[pln_separator[0] + 2..pln_separator[1] - 2]
    @patient_list_age = pln[(pln_separator[1] + 2)..pln.length - 1]
    expect(@patient_list_gender).to include @patient_header_gender
    expect(@patient_list_age.to_s).to eq @patient_header_age.to_s
  end
  if !@patient_list_dob.nil? && !@patient_header_mrn.nil?
    expect(@patient_header_mrn.to_s).to include @patient_list_mrn.to_s
    if (@patient_header_dob.include?("Z"))
      processed_date = Date.strptime(@patient_list_dob.gsub("DOB: ", ""), "%m/%d/%Y").strftime("%Y-%m-%dT%H:%M:%SZ")
    else
      processed_date = @patient_list_dob.gsub("DOB: ", "")
    end
    expect(@patient_header_dob).to match(".*(#{processed_date}).*") unless @patient_header_dob.nil?
  end
end
