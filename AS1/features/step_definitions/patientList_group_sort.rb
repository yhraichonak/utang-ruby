Before do
  @PatientList_Screen = PatientList_Screen.new @selenium
  @PMGroupSort_Window = PMGroupSort_Window.new @selenium
  @PMFilterUnits_Window = PMFilterUnits_Window.new @selenium
end

Then(/^I should see the PM patient list grouped by unit and sorted by bed$/) do
  location = []
  bed = []

  location << @PatientList_Screen.pm_patientRow_text(1)['location']
  bed << @PatientList_Screen.pm_patientRow_text(1)['bed']

  puts "-----------"
  puts location.count
  puts bed.count
  puts "-----------"

  # counter starts at patient #2
  (2..@PatientList_Screen.pm_patientList_count).each do |i|
    if INFO == true
      puts @PatientList_Screen.pm_patientRow_text(i)['location']
      puts @PatientList_Screen.pm_patientRow_text(i)['bed']
    end

    location << @PatientList_Screen.pm_patientRow_text(i)['location']
    bed.clear if location[i - 2] != location[i - 1]
    bed << @PatientList_Screen.pm_patientRow_text(i)['bed']
    # puts "#{location[i - 1]} - #{bed[bed.length - 1]}" if INFO == true
    expect(bed.should == bed.sort)
  end
  expect(location.should == location.sort)
end

Then(/^I should see the PM patient list grouped by "(.*?)" and sorted by "(.*?)"$/) do |group, sort|
  group_array = []
  sort_array = []
  group_sort = ''

  @wait.until { @PatientList_Screen.patients.length > 0 }

  # group_array << @PatientList_Screen.patientRow_text(group, 0)
  # sort_array << @PatientList_Screen.patientRow_text(sort, 0)

  (0..@PatientList_Screen.pm_patientList_count - 1).each do |i|
    if INFO == true
      puts @PatientList_Screen.patientRow_text(group, i)
      puts @PatientList_Screen.patientRow_text(sort, i)
    end

    group_array << @PatientList_Screen.patientRow_text(group.to_s, i)
    sort_array.clear if group_array[i - 1] != group_array[i]
    sort_array << @PatientList_Screen.patientRow_text(sort.to_s, i)

    case
    when group == 'dob'
      group_sort = group_array.sort_by{|d| m,d,y=d.split("/");[y,m,d]}
    when group == 'bed'
      group_sort = group_array.sort_by {|s| s.split(/(\d+)/).map {|s| begin Integer(s, 10); rescue ArgumentError; s end }}
    else
      group_sort = group_array.sort
    end
    case
    when sort == 'dob'
      sorted = sort_array.sort_by{|d| m,d,y=d.split("/");[y,m,d]}
    when sort == 'bed'
      sorted = sort_array.sort_by {|s| s.split(/(\d+)/).map {|s| begin Integer(s, 10); rescue ArgumentError; s end }}
    else
      sorted = sort_array.sort
    end

    expect(sort_array.should == sorted)
  end
  expect(group_array.should == group_sort)
end