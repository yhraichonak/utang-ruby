Before do
  @ListOfLists_window = ListOfLists_window.new selenium, appium
  @Menu = Menu.new selenium, appium
end

Then(/^I should see the ListOfList window$/) do
  if(ENV['DEVICE'].include? "iPad")
    expect(@ListOfLists_window.pop_over).to be_truthy
  else
    expect(@ListOfLists_window.list_table.visible).to be_truthy
  end
end

When(/^I scroll down the ListOfList window$/) do
  selenium.execute_script 'mobile: scroll', :direction => 'down'
end

Then(/^I should see my ListOfList window with "(.*?)" and "(.*?)" Inbox for test site$/) do |inboxName, groupInbox|

end

Then(/^I should see my ListOfList window with no inboxes displaying for test site$/) do

end

When(/^I click "(.*?)" for the "(.*?)" module in training list of list window$/) do |list_name, module_name|

  if(module_name == "OB")
    #Appium::TouchAction.new.swipe(start_x: 600, start_y: 400, end_x: 600, end_y: 200, duration: 1000).perform
    #list_of_list = @ListOfLists_window.list_name_training_ob
  else
    list_of_list = @ListOfLists_window.list_name_training
  end

	if(module_name == "EMR")
		if(list_name == "RECENT")
			element = list_of_list["emr_recent"]
			Common.click_center_of_object(element)
		elsif(list_name == "SEARCH")
			element = list_of_list["emr_search"]
			Common.click_center_of_object(element)
		end
	elsif(module_name == "COMMUNICATION")
		if(list_name == "LAUNCHER")
			element = list_of_list["com_launcher"]
			Common.click_center_of_object(element)
		elsif(list_name == "SECURE MESSAGES")
			element = list_of_list["com_sec_message"]
			Common.click_center_of_object(element)
		elsif(list_name == "NOTIFICATIONS")
			element = list_of_list["com_notification"]
			Common.click_center_of_object(element)
		end
	elsif(module_name == "PATIENT MONITORING")
		if(list_name == "RECENT")
			element = list_of_list["pm_recent"]
			Common.click_center_of_object(element)
		elsif(list_name == "SNIPPET WORKLIST")
			element = list_of_list["pm_snippet"]
			Common.click_center_of_object(element)
		elsif(list_name == "SEARCH")
			element = list_of_list["pm_search"]
			Common.click_center_of_object(element)
		end
	elsif(module_name == "CARDIO")
		if(list_name == "RECENT")
			element = list_of_list["cardio_recent"]
			Common.click_center_of_object(element)
		elsif(list_name == "IN BASKET")
			element = list_of_list["cardio_in_basket"]
			Common.click_center_of_object(element)
		elsif(list_name == "EMS")
			selenium.execute_script 'mobile: scroll', :direction => 'down'
			element = ist_of_list["cardio_ems"]
			Common.click_center_of_object(element)
		elsif(list_name == "SEARCH")
			selenium.execute_script 'mobile: scroll', :direction => 'down'
			element = list_of_list["cardio_search"]
		end
	elsif(module_name == "OB")
		if(list_name == "CENSUS")
			selenium.execute_script 'mobile: scroll', :direction => 'down'
			list_of_list = @ListOfLists_window.list_name_training_ob
			element = list_of_list["ob_census"]
			Common.click_center_of_object(element)
		  #elsif(list_name == "SEARCH")
			 #selenium.execute_script 'mobile: scroll', :direction => 'down'
			 #list_of_list["ob_search"].click
		end
	end
end

When(/^I click OB CENSUS in List of List window$/) do
	@wait.until { @ListOfLists_window.list_table.displayed? == true }
	element = @ListOfLists_window.training_list_of_list_button("OB CENSUS")
  Common.click_center_of_object(element)
end

When(/^I click OB SEARCH in List of List window$/) do
	@wait.until { @ListOfLists_window.list_table.displayed? == true }
	element = @ListOfLists_window.training_list_of_list_button("OB SEARCH")
  Common.click_center_of_object(element)
end

When(/^I click EMR RECENT in List of List window$/) do
	@wait.until { @ListOfLists_window.list_table.displayed? == true }
	current_device = "#{$device_name} #{$device_plat}"
	if current_device == "iPhone 7 11.3"
		element = @ListOfLists_window.emr_training_list_of_list_btn("RECENT", 1)
		Common.click_center_of_object(element)
	elsif @appVersion == "1.5.23.00"
		element = @ListOfLists_window.emr_training_list_of_list_btn("RECENT", 2)
		Common.click_center_of_object(element)
	elsif @appVersion == "1.6"
		element = @ListOfLists_window.emr_training_list_of_list_btn("RECENT", 3)
		Common.click_center_of_object(element)
	end
end

When(/^I click "(.*?)" in List of List window$/) do |listName|
  sleep 2
  begin
    if(ENV['DEVICE'].include? "iPad")
      @wait.until { @ListOfLists_window.list_sprocket.displayed? == true }
    else
      @wait.until { @ListOfLists_window.list_done_button.displayed? == true }
    end
  rescue Exception => error
    if(ENV['DEVICE'].include? "iPad")
      @wait.until { @ListOfLists_window.list_sprocket.displayed? == true }
    else
      @wait.until { @ListOfLists_window.list_done_button.displayed? == true }
    end
  end

  if listName.match? "(SEARCH|CardioSearch)"
    if(!ENV['DEVICE'].include? "iPad")
      do_swipe
    end
    @ListOfLists_window.cardioSearchList_button.click

  elsif /PMSearch/.match listName
    begin
      element = @ListOfLists_window.pmSearchList_button
      Common.click_center_of_object(element)
    rescue StandardError => e
      @appiumDriver.swipe(:direction => "up")

      element = @ListOfLists_window.pmSearchList_button
      Common.click_center_of_object(element)
    end

  elsif /NOTIFICATIONS/.match listName
    begin
      element = @ListOfLists_window.list_button(listName)
      Common.click_center_of_object(element)
    rescue StandardError => e
      element = @ListOfLists_window.list_button("ON CALL")
      Common.click_center_of_object(element)
      element = @ListOfLists_window.cardioSearchList_button
      Common.click_center_of_object(element)
    end
  elsif /OB - CENSUS/.match listName
    element = @ListOfLists_window.obCensusList_button
    Common.click_center_of_object(element)
  elsif /MOST RECENT/.match listName
    element = @ListOfLists_window.list_button(listName)
    Common.click_center_of_object(element)
  elsif /CENSUS/.match listName
    element = @ListOfLists_window.list_button(listName)
    Common.click_center_of_object(element)
  else

    if $debug_flag == "debug"
      puts "in the final else???"

      puts "DEVICE_PLATFORM on the site list screen: #{$device_plat}"
    end

    if $device_plat == "12.4"
        if($device_name.include? "iPad")
          element = @ListOfLists_window.list_button124ipad(listName)
          Common.click_center_of_object(element)
        else
          element = @ListOfLists_window.list_button124(listName)
          Common.click_center_of_object(element)
        end
    else
      puts " in the final else at the end of the nested if statement"

      if(ENV['DEVICE'].include? "iPad")
        element = @ListOfLists_window.list_button(listName)
        Common.click_center_of_object(element)
      else

        if $debug_flag == "debug"
          puts "should be 13.4 or greater"
        end

        if(ENV['DEVICE'].include? "iPhone 8") || (ENV['DEVICE'].include? "iPhone 7 Plus")
          element = @ListOfLists_window.list_button(listName)
          Common.click_center_of_object(element)
        else
          if $debug_flag == "debug"
            puts "in the last part"
          end

          element = @ListOfLists_window.list_button(listName)
          puts "returned element = #{element.text}"

          Common.click_center_of_object(element)
        end
      end
    end
  end

end

When(/^I click the gear button on list of list window$/) do
  @wait.until { @ListOfLists_window.gear_button.displayed? == true }
  element = @ListOfLists_window.gear_button
  Common.click_center_of_object(element)
end

Then(/^I should see the About and Logoff buttons$/) do
	@ListOfLists_window.about_button.nil?.should be false
  if @appVersion == "1.5.2300"
	@ListOfLists_window.logoff_button.nil?.should be false
  else
	@ListOfLists_window.logout_button.nil?.should be false
  end
end

When(/^I click the About button$/) do
  @wait.until { @ListOfLists_window.about_button.displayed? == true }
  element = @ListOfLists_window.about_button
  Common.click_center_of_object(element)
end

When(/^I click the Logoff button$/) do
  element = @ListOfLists_window.logout_button
  Common.click_center_of_object(element)
end

And(/^I navigate away current screen for logout$/) do
  navigation_bar = @Menu.nav_bar
  nav_title = navigation_bar.attribute('name')
  puts "current navigation bar title = #{nav_title}"

  case nav_title
  when 'PM > Census'
    @Menu.back_button_sites.click
  when 'Cardio > MOST RECENT'
    @Menu.back_button_sites.click
  when 'Secure Messaging'
    @Menu.back_button_sites.click
  when 'WorkspaceKit.Workspace'
  when 'utang.Workspace'
    button_needed = nil
    sleep 2
    found = nil

    begin
      puts "trying the pm census"
      button_needed = @Menu.back_button_pm_census
      puts button_needed.name
      found = true
    rescue => exception
      puts exception
    end

    if found == false
      begin
        puts "trying the cardio most recent"
        button_needed = @Menu.back_button_cardio_most_recent
        puts button_needed.name
      rescue => exception
        puts exception
      end
    end

    button_needed.click
  end

  navigation_bar = @Menu.nav_bar
  nav_title = navigation_bar.attribute('name')
  puts "current navigation bar title = #{nav_title}"

  case nav_title
  when 'PM > Census'
    puts "should be on the pm census screen"
    begin
      @Menu.cancel_button.click
    rescue
    end
  when ''
    puts "should be on the cardio most recent screen"
    begin
      @Menu.cancel_button.click
    rescue
    end
  end

  steps %{
    When I click options button on top left of screen
    Then I should see the ListOfList window
    When I click the gear button on list of list window
    Then I should see the About and Logoff buttons
    When I click the Logoff button
    Then I should see the Site List screen
  }
  sleep 5
end

Then(/^I should see my EMR ListOfList window with My Patients for "(.*?)"$/) do |siteName|
  @ListOfLists_window.utangIcon_text.exists.should be true
  @ListOfLists_window.group_table("EMR").exists.should be true

  @ListOfLists_window.list_button("MY PATIENTS").exists.should be true
  @ListOfLists_window.list_button("SEARCH").exists.should be true

  @ListOfLists_window.siteName_text(siteName).exists.should be true
end

Then(/^I should see my PM ListOfList window with Census and Search for test site$/) do
  @ListOfLists_window.utangIcon_text.exists.should be true
  @ListOfLists_window.group_table("PATIENT MONITORING").exists.should be true

  @ListOfLists_window.list_button("CENSUS").exists.should be true
  @ListOfLists_window.list_button("SEARCH").exists.should be true

  #@ListOfLists_window.siteName_text(SITE_NAME).exists.should be true
end

Then(/^I should see my ListOfList window with Communications section with SECURE MESSAGING$/) do
  @ListOfLists_window.utangIcon_text.exists.should be true
end

  def lol_sitename
    Element.new(@selenium, :xpath, "#{APP_PACKAGE}:id/about_cemark_number")
  end

  def as1_banner
    Element.new(@selenium, :xpath, "#{APP_PACKAGE}:id/about_cemark_number")
  end

When(/^I am logged into the site$/) do
  for i in 0..7
    begin
      if(@PMMonitor_screen.close_button.exists)
        expect(@PMMonitor_screen.close_button).to be_truthy
        break
      end
    rescue StandardError => e
      i
    end
  end
end
