# frozen_string_literal: true

Before do
  @PM_Monitor_Screen = PM_Monitor_Screen.new @selenium
  @Ventilator_Screen = Ventilator_Screen.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
end

Then(/^I should see the Ventilator Grid screen$/) do
  @wait.until { @PM_Navigation_Menu.vents_sub_nav_button('Grid')['status'] == true }

  @wait.until { @Ventilator_Screen.grid_object.displayed? == true }
  sleep 3
  steps %(
    And I should see the pm patient info in the header
	)
  expect(@PM_Navigation_Menu.vents_sub_nav_button('Grid')['status']).to be_truthy
  expect(@Ventilator_Screen.ventilator_widget.displayed?).to be_truthy
  expect(@Ventilator_Screen.chicklets('rr').displayed?).to be_truthy
  expect(@Ventilator_Screen.chicklets('fi-o-2').displayed?).to be_truthy
  expect(@Ventilator_Screen.chicklets('peep').displayed?).to be_truthy
  expect(@Ventilator_Screen.chicklets('peak').displayed?).to be_truthy
  expect(@Ventilator_Screen.chicklets('map').displayed?).to be_truthy
  expect(@Ventilator_Screen.chicklets('vt-i').displayed?).to be_truthy
  expect(@Ventilator_Screen.chicklets('m-vex').displayed?).to be_truthy
  expect(@Ventilator_Screen.grid_object.displayed?).to be_truthy
end

Then(/^I should see the Ventilator Graphs screen$/) do
  @wait.until { @PM_Navigation_Menu.vents_sub_nav_button('Graphs')['status'] == true }
  sleep 3
  steps %(
    And I should see the pm patient info in the header
	)
  expect(@PM_Navigation_Menu.vents_sub_nav_button('Graphs')['status']).to be_truthy
  expect(@Ventilator_Screen.ventilator_widget.displayed?).to be_truthy
end

Then(/^I should see the Ventilator Events screen$/) do
  @wait.until { @PM_Navigation_Menu.vents_sub_nav_button('Events')['status'] == true }
  sleep 3
  steps %(
    And I should see the pm patient info in the header
	)

  expect(@PM_Navigation_Menu.vents_sub_nav_button('Events')['status']).to be_truthy
  expect(@Ventilator_Screen.events_table.displayed?).to be_truthy
end

When(/^I scroll the ventilator grid to the "(.*?)"$/) do |direction|
  sleep 2

  case direction
  when 'left'
    # @selenium.action.drag_and_drop_by(@Ventilator_Screen.ventilator_widget,-400,0).perform
  when 'right'
    # @selenium.action.drag_and_drop_by(@Ventilator_Screen.ventilator_widget,400,0).perform
  when 'up'
    # @selenium.action.drag_and_drop_by(@Ventilator_Screen.ventilator_widget,0,-400).perform
  when 'down'
    # @selenium.action.drag_and_drop_by(@Ventilator_Screen.ventilator_widget,0,400).perform
    @selenium.action.drag_and_drop_by(@Ventilator_Screen.ventilator_widget, 1937, 156.38)
  end

  sleep 2
end
