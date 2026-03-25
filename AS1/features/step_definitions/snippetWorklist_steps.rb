# frozen_string_literal: true

Before do
  @SnippetWorklist_Screen = SnippetWorklist_Screen.new @selenium
  @PatientList_Screen = PatientList_Screen.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
end

Then(/^I should see single column toggle turned "([^"]*)"$/) do |status|
  #if status == 'On'
  #  expect(@SnippetWorklist_Screen.column_toggle['buttonOn']).to be_truthy
  #else
  #  expect(@SnippetWorklist_Screen.column_toggle['buttonOn']).to be_falsey
  #end
  
  if status == 'On'
    expect(@PatientList_Screen.patient_groups['single_column']).to be_truthy
  else
    expect(@PatientList_Screen.patient_groups['single_column']).to be_falsey
  end

end

Then(/^I should see snippet worklist with single columns "([^"]*)"$/) do |status|
  puts "Expected Status: #{status}" if INFO == true

  if status == 'On'
    expect(@PatientList_Screen.patient_groups['single_column']).to be_truthy
  else
    expect(@PatientList_Screen.patient_groups['single_column']).to be_falsey
  end
end

When(/^I click on single column toggle$/) do
  @SnippetWorklist_Screen.column_toggle['toggle_obj'].click
end

When(/^Toggle single column view (on|off)$/) do |_on_off|
  if @PatientList_Screen.patient_groups['single_column']!=_on_off.include?('on')
   @SnippetWorklist_Screen.column_toggle['toggle_obj'].click
  end
end

Then(/^I should be returned to location in worklist of previous patient selected$/) do
  # manual
  sleep 4
end

When(/^I click the Hide Completed toggle switch to "([^"]*)"$/) do |_status|
  @SnippetWorklist_Screen.hideCompleted_toggle['toggle_obj'].click
end

Then(/^I should completed snippets toggled "([^"]*)"$/) do |status|
  if status == 'On'
    expect(@SnippetWorklist_Screen.hideCompleted_toggle['buttonOn']).to be_truthy
  else
    expect(@SnippetWorklist_Screen.hideCompleted_toggle['buttonOn']).to be_falsey
  end
end

Then(/^I toggle hide completed snippets (on|off)$/) do |on_off|
  toggle_on=on_off.include?("on") ? true : false
  if @SnippetWorklist_Screen.hideCompleted_toggle['buttonOn'] != toggle_on
    @SnippetWorklist_Screen.hideCompleted_toggle['toggle_obj'].click
  end
end

Then(/^I should see Group Sort, Filter Units links disabled$/) do
  expect(@PatientList_Screen.group_sort_link['disabled']).to be_truthy
  expect(@PatientList_Screen.filter_units_link['disabled']).to be_truthy
end

Then(/^I should see snippet worklist sorted in default order A-Z$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I scroll to the bottom of the snippet worklist$/) do
  @last_patient = @PatientList_Screen.patient_card.last
  @selenium.execute_script "arguments[0].scrollIntoView();", @last_patient
 
  expect(@last_patient.displayed?).to be_truthy
end

Then(/^I should see the bottom of the worklist$/) do
  sleep 5
  @wait.until { @SnippetWorklist_Screen.column_toggle['toggle_obj'].displayed? == true }
  
  last_patient = @PatientList_Screen.patient_card.last

  expect(last_patient.displayed?).to be_truthy
end

When(/^I click the back button in the Snippet Tools Header$/) do 
  back_button = @PM_Navigation_Menu.back_button

  @wait.until { back_button }

  back_button.click 
end
