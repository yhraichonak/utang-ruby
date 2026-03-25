Before do
  @SiteList_screen = SiteList_screen.new selenium, appium
  @Welcome_screen = Welcome_screen.new selenium, appium
  @Menu = Menu.new selenium, appium
  @Login_screen = Login_screen.new selenium, appium
end

When(/^I click "(.*?)" site on Site List screen$/) do |site|
	@wait.until { @SiteList_screen.site_button(site).displayed? == true }
  element = @SiteList_screen.site_button(site)
	Common.click_center_of_object(element)
end

When(/^I click "(.*?)" button on Site List screen$/) do |site|
 puts "in the site list steps click button on site list screen.......... #{site}>>>>>>>"
  begin
    @appiumDriver.alert_accept
    if $debug_flag == "debug"
      puts "accepted notification alert"
    end
  rescue StandardError => e
    #alert not there
  end

  currentScreen = "Undetermined"

  begin
    if @SiteList_screen.navigation_bar.name == "Sites"
      currentScreen = "Sites"
    end
  rescue StandardError => e
    if @Welcome_screen.title_text.text == "WELCOME"
      currentScreen = "Welcome"
    end

    if $debug_flag == "debug"
       puts "The Welcome Screen displayed"
    end
  end

  if $debug_flag == "debug"
   puts "Current Screen is ** #{currentScreen} **"
  end

  #site = $siteName
  puts "sitename = #{$siteName}"

  if currentScreen == "Sites"
    e = @SiteList_screen.site_button($siteName)

    if e.nil? == false
      expect(e.name).to eq $siteName

     if $debug_flag == "debug"
      puts "( #{e.name} )"
     end
      ########### puts "here" ######
      steps %{
        When I click the gear button on Site List screen
      }
      steps %{
        And I click the Logout button
        When I click OK button in alert prompt
      }
    else
      steps %{
        When I click the gear button on Site List screen
        Then I should see the gear button options
        When I click the About button
        Then I should see the About screen
        When I click the Cancel button on the About screen
      }

      puts "*****"
      puts "Registering Device: #{@RegistrationCode}"
      puts "*****"
      GS_Registration.site_registration(@RegistrationCode, 1763)
      GS_Registration.site_registration(@RegistrationCode, 1770)
      GS_Registration.site_registration(@RegistrationCode, 4186)
      GS_Registration.site_registration(@RegistrationCode, 2419)
      GS_Registration.site_registration(@RegistrationCode, 1770)
      GS_Registration.site_registration(@RegistrationCode, 3743)
      GS_Registration.site_registration(@RegistrationCode, 4645)
      GS_Registration.site_registration(@RegistrationCode, 4121)
      GS_Registration.site_registration(@RegistrationCode, 4751)
      puts "Registered Sites!!"

      #@seleniumDriver.execute_script 'mobile: scroll', :direction => 'up'
      Appium::TouchAction.new.press(:x => 200, :y => 75).wait(5000).move_to(:x => 0, :y => 500).release.perform
    end
  else
    steps %{
      When I click the Sign In button
      Then I should see the utang Credentials window prompt
      When I enter "test@test.com" in username field
      And I enter "XXXXX" in password field
      And I click the Sign In cell
      Then the utang Would Like to Send You Notifications Alert window displays
      When I click the Alert Allow Notifications button
      Then I should see the "cardio" test site button on Site List screen
    }

    steps %{
      When I click the gear button on Site List screen
      Then I should see the gear button options
      When I click the About button
      Then I should see the About screen
      When I click the Cancel button on the About screen
    }
  end

  element = @SiteList_screen.site_button($siteName)
  puts "i have the element = #{element.text}"
  #Common.click_center_of_object(element)
  element.click
  puts 'just clicked the site button'

  begin
   element = @Login_screen.login_text
   expect(element.name).to eq "Please enter your credentials"
  rescue
   e = @SiteList_screen.site_button($siteName)
   puts "++++++++++++++++++++++++++"
   puts "site list button #{e.text}"
   puts "++++++++++++++++++++++++++"
   #e.click
   Common.click_center_of_object(e)
   puts "just tried to click the element in the rescue"


  end

end

Then(/^I should see the Site List screen$/) do
  sleep 4
 @appiumDriver.find_element(:xpath,'//XCUIElementTypeStaticText[@name="Sites"]')
end

When(/^I click the test site button on Site List screen$/) do
 @appiumDriver.find_element(:xpath,'//XCUIElementTypeStaticText[@name="Sites"]')

 e = @SiteList_screen.site_button($siteName)
 #puts "++++++++++++++++++++++++++"
 #puts "site list button #{e.text}"
 #puts "++++++++++++++++++++++++++"

 @appiumDriver.action.move_to(e).click.perform
 #Common.click_center_of_object(e)

 #puts "just tried to click the element"

 begin
  element = @Login_screen.login_text
  expect(element.name).to eq "Please enter your credentials"
 rescue
  e = @SiteList_screen.site_button($siteName)
  puts "++++++++++++++++++++++++++"
  puts "site list button #{e.text}"
  puts "++++++++++++++++++++++++++"

  @appiumDriver.action.move_to(e).click.perform

  puts "just tried to click the site button"
 end

  # begin
  #   element = @Login_screen.login_text
  #   expect(element.name).to eq "Please enter your credentials"
  #   sleep 2
  # rescue
  #   navigation_bar = @Menu.nav_bar
  #   nav_title = navigation_bar.attribute('name')
  #   puts "current navigation bar title = #{nav_title}"
  #   puts "if not on site list i will nav back"

  #   case nav_title
  #   when 'PM > Census'
  #     steps %{
  #       When I click options button on top left of screen
  #       Then I should see the ListOfList window
  #       When I click the gear button on list of list window
  #       Then I should see the About and Logoff buttons
  #       When I click the Logoff button
  #     }
  #   when 'Cardio > MOST RECENT'
  #     steps %{
  #       When I click options button on top left of screen
  #       Then I should see the ListOfList window
  #       When I click the gear button on list of list window
  #       Then I should see the About and Logoff buttons
  #       When I click the Logoff button
  #     }
  #   end

  #   steps %{
  #     Then I should see the Site List screen
  #   }
  # else
  #   e = @SiteList_screen.site_button($siteName)
  #   puts "++++++++++++++++++++++++++"
  #   puts "site list button #{e.text}"
  #   puts "++++++++++++++++++++++++++"
  #   #e.click
  #   #Common.click_center_of_object(e)
  #   @appiumDriver.action.move_to(e).click.perform
  #   puts "just tried to click the element in the rescue"
  # end
 end
# end

Then(/^I should see "(.*?)" button on Site List screen$/) do |siteName|
  expect(@SiteList_screen.site_button(siteName).nil?).to eq false
  #@SiteList_screen.site_button("Training Hospital").exists.should be true
end

Then(/^I should see the test site button on Site List screen$/) do
  value = nil
  if not selenium.orientation.to_s.include?("portrait")
    selenium.rotation = :portrait
  end
  begin
    @appiumDriver.alert_accept

  rescue StandardError => e
    if $debug_flag == "debug"
     puts "alert not found #{e}"
    end
  end


  if $debug_flag == "debug"
   puts "site: #{$siteName}"
  end

 currentScreen = ""
 found_site_screen = false
 found_welcome_screen = false

 #welcome screen logic  I updated the for loop from 4 to 2 loops.  hopefully this speeds things up
 begin
   value_needed = @Welcome_screen.title_text

   if $debug_flag == "debug"
    puts "current screen title :  #{value_needed.name}"
   end
   if  ["WELCOME", "Welcome"].include? value_needed.name
      currentScreen = "Welcome"
      if $debug_flag == "debug"
       puts "found the #{currentScreen}"
      end
      found_welcome_screen = true
   end
 rescue StandardError => e
 end

#site Screen Logic
for i in 0..4
 begin
   value_needed = @SiteList_screen.navigation_bar_title

   if  value_needed.name == "Sites"
      currentScreen = "Sites"
      found_site_screen = true
      if $debug_flag == "debug"
       puts "current screen is #{currentScreen}"
      end
   end
 rescue StandardError => e

 end

 if(found_site_screen == true)
  if $debug_flag == "debug"
   puts "site list screen found..."
  end
  break
 end
end

 #determined on site screen.  not checking if site exists.......
 puts "checking if I am on the site screen Feb 5"
 puts "current screen on feb 5 = #{currentScreen}"
  if currentScreen == "Sites"
   puts "should be in the site screen feb 5"
    site_value = @SiteList_screen.verify_site_button($siteName)
    puts "the site_value = #{site_value}"
    if site_value == "true"
     puts "in the site check if................"
     @SITE_CHECK = @SiteList_screen.site_button($siteName)
     #value = @SITE_CHECK["text"].text
     value = @SITE_CHECK.name.strip
     puts "the value of the @site check feb 5 #{value}"
    end

    if $debug_value == "debug"
     puts "site found = #{site_value}"
    end

    if site_value == "true"
     # TODO: Seems lines below are useless and slowdown test execution
     # puts "site_value = true"
	   #  steps %{
     #    When I click the gear button on Site List screen
     #    Then I should see the gear button options
     #    When I click the About button
     #    Then I should see the About screen }
     #
     #  steps %{
     #    When I click the Cancel button on the About screen
     #  }

      expect(value).to eq $siteName

      if $debug_flag == "debug"
       puts "expected site equals given site"
      end

    elsif site_value == "false"

      if $debug_flag == "debug"
       puts "site button did not display for #{@siteName}"
      end

     steps %{
        When I click the gear button on Site List screen
        Then I should see the gear button options
        When I click the About button
        Then I should see the About screen
        When I click the Done button on the About screen
      }

      if $debug_flag == "debug"
       puts "Registering Device: #{@RegistrationCode}"   #39 QA App Orchard
      end
      GS_Registration.site_registration(@RegistrationCode, 1763)
      GS_Registration.site_registration(@RegistrationCode, 1770)
      GS_Registration.site_registration(@RegistrationCode, 4186)
      GS_Registration.site_registration(@RegistrationCode, 2419)
      GS_Registration.site_registration(@RegistrationCode, 1770)
      GS_Registration.site_registration(@RegistrationCode, 3743)
      GS_Registration.site_registration(@RegistrationCode, 4170)
      GS_Registration.site_registration(@RegistrationCode, 4121)
      GS_Registration.site_registration(@RegistrationCode, 4645)
      GS_Registration.site_registration(@RegistrationCode, 4751)

      if $debug_flag == "debug"
       puts "refreshing the screen for new sites added"
      end

      # Appium::TouchAction.new.press(:x => 200, :y => 100).wait(5000).move_to(:x => 200, :y => 600).release.perform
      do_swipe(200, 100, 200, 600)
    end
  else
   #you are on the welocme screen.  you need to sign into the app.....
   if $debug_flag == "debug"
    puts "should be on the welcome screen"
   end

    steps %{
      When I click the Sign In button
      Then I should see the utang Credentials window prompt
      When I enter "test@test.com" in username field
      And I enter "XXXXX" in password field
      And I click the Sign In cell
      Then the utang Would Like to Send You Notifications Alert window displays
      When I click the Alert Allow Notifications button
      Then I should see the test site button on Site List screen
    }

    steps %{
        When I click the gear button on Site List screen
        Then I should see the gear button options
        When I click the About button
        Then I should see the About screen
        When I click the Cancel button on the About screen
      }
  end
end

Then(/^I should see the "(.*?)" prod site button on Site List screen$/) do |siteType|
  #@appiumDriver.set_wait 1
  #####Common.wait_for_loading_prompt(selenium)
  #@appiumDriver.set_wait 3
  begin
    @appiumDriver.alert_accept
  rescue StandardError => e
    #alert not there
  end


  #need to see if
  if @SiteList_screen.allow_button.nil? == false
    begin
    element = @SiteList_screen.allow_button
    Common.click_center_of_object(element)
   #@SiteList_screen.allow_button.click
   rescue StandardError => e
      #button not there
    end
    #@appiumDriver.set_wait 5


    #  steps %{
    #    When I click the gear button on Site List screen
    #    Then I should see the gear button options
    #    When I click the About button
    #    Then I should see the About screen
    #    When I click the Sign Out button
    #    Then I should see the Sign Out prompt
    #    And I click the Sign Out button on the Sign Out prompt
    #    When I click the Ok button on Success window prompt
    #  }
  end

  if siteType == "ob"
    @siteName = $ob_sitename_prod
  end

  ##appiumDriver.set_wait 1
  #Common.wait_for_loading_prompt(selenium)
  ##@appiumDriver.set_wait 5

  currentScreen = nil
  begin
    if @SiteList_screen.navigation_bar.name == "Sites"
      currentScreen = "Sites"
    end
  rescue StandardError => e
    if @Welcome_screen.title_text.visible == true
      currentScreen = "Welcome"
    end
  end

  if currentScreen == "Sites"
    if @SiteList_screen.site_button(@siteName).nil? == false
      @SiteList_screen.site_button(@siteName).name.should eql @siteName
    else
      steps %{
        When I click the gear button on Site List screen
        Then I should see the gear button options
        When I click the About button
        Then I should see the About screen
        When I click the Done button on the About screen
      }

      puts "Registering Device: #{@RegistrationCode}"
      GS_Registration.site_registration_prod(@RegistrationCode, 1488)
      GS_Registration.site_registration_prod(@RegistrationCode, 1547)

      #@seleniumDriver.execute_script 'mobile: scroll', :direction => 'up'
      Appium::TouchAction.new.press(:x => 200, :y => 150).wait(5000).move_to(:x => 0, :y => 500).release.perform
    end
  else
    steps %{
      When I click the Sign In button
      Then I should see the utang Credentials window prompt
      When I enter "test@test.com" in username field
      And I enter "XXXXX" in password field
      And I click the Sign In cell
      Then the utang Would Like to Send You Notifications Alert window displays
      When I click the Alert Allow Notifications button
      Then I should see the "#{siteType}" prod site button on Site List screen
    }
  end
end

When(/^I click the gear button on Site List screen$/) do
  @wait.until { @SiteList_screen.gear_button.displayed? == true }
  element = @SiteList_screen.gear_button
  Common.click_center_of_object(element)
end

Then(/^I should see the menu display$/) do
  element = @Menu.menu_sheet
  @wait.until { element.displayed? == true }
  expect(element.visible).to be_truthy
end

When(/^I click the Logout button$/) do
  @wait.until { @Menu.menu_logout.displayed? == true }
  @Menu.menu_logout.click
  # el = @Menu.menu_logout
  # puts "trying to logout....."
  #
  # pos =  el.location
  # size =  el.size
  #
  # center_x = pos[:x] + size[:width] / 2
  # center_y = pos[:y] + size[:height] / 2
  # Appium::TouchAction.new.press(:x => center_x, :y => center_y).wait(1000).release.perform

  #Common.click_center_of_object(element)
  #element.click
end

Then(/^I should see the gear button options$/) do
  expect(@SiteList_screen.logout_button.displayed?).to eq true
end

When(/^I toggle on Touch Id enrollment$/) do
  @appiumDriver.toggle_touch_id_enrollment
end

When(/^I refresh the site list$/) do
  Appium::TouchAction.new.press(:x => 200, :y => 75).wait(5000).move_to(:x => 0, :y => 500).release.perform
end
