Before do
  @Ob_Summary_screen = Ob_Summary_screen.new selenium, appium 
end

When(/^I click the refresh button on the OB screen$/) do
  @Ob_Summary_screen.ob_refresh.click
end

When(/^I click the the OB pause button$/) do
  @Ob_Summary_screen.ob_live.click
end

When(/^I click on About from the OB screen$/) do
  @Ob_Summary_screen.ob_about.click
  sleep(3)
end

When(/^I click on Toggle Color$/) do
  @Ob_Summary_screen.ob_toggle.click
  sleep(3)
end

Then(/^the About screen displays from the OB options$/) do
  sleep(3)
  @Ob_Summary_screen.about_title.exists.should be true
end

When(/^the build info is recorded$/) do
  puts @Ob_Summary_screen.app_ver.text
  puts @Ob_Summary_screen.build_ver.text
  @Ob_Summary_screen.app_ver.exists.should be true
  @Ob_Summary_screen.build_ver.exists.should be true
end

Then(/^the OB census displays$/) do
  @Ob_Summary_screen.ob_census.exists.should be true
end

When(/^the device information is recorded$/) do
  puts @Ob_Summary_screen.device_mdl.text
  puts @Ob_Summary_screen.device_OSys.text
  @Ob_Summary_screen.device_mdl.exists.should be true
  @Ob_Summary_screen.device_OSys.exists.should be true
end

When(/^I click on the patients name$/) do
   @Ob_Summary_screen.Ob_Summary_pName.click
end

When(/^I click on the OB screen caret$/) do
   sleep(1)
   #puts @Ob_Summary_screen.ob_caret.exists
   @Ob_Summary_screen.ob_caret.click
   sleep(1)
end

When(/^I click the OB live button$/) do
   @Ob_Summary_screen.ob_live.click
end

When(/^I click on an annotation$/) do
  puts @Ob_Summary_screen.annotation.text
   @Ob_Summary_screen.annotation.click
end

When(/^I click on an earlier annotation$/) do
  puts @Ob_Summary_screen.later_annotation.text
   @Ob_Summary_screen.later_annotation.click
end

When(/^I click the annotation body$/) do
   @Ob_Summary_screen.annotation_pointer.click
   sleep(2)
end

When(/^I click in the Search nav bar from the ob census$/) do
   @Ob_Summary_screen.ob_census_search.click
end

When(/^the annotation body is dismissed$/) do
   @Ob_Summary_screen.annotation_body.exists.should be false
end

When(/^the annotation note displays on the fetal strip$/) do
   @Ob_Summary_screen.annotation_body.exists.should be true
   puts @Ob_Summary_screen.annotation_body.text
end

When(/^the legend on the Maternal Vitals tile displays as L H Rec$/) do
   @Ob_Summary_screen.ob_Vrange.text ==  "L - H"
   @Ob_Summary_screen.ob_Vvalue.text ==  "Rec"
   puts @Ob_Summary_screen.ob_Vrange.text
   puts @Ob_Summary_screen.ob_Vvalue.text
end

Then(/^the fetal strip displays$/) do
   @Ob_Summary_screen.ob_fetal_strip.exists.should be true
end

Then(/^the vitals being recorded are listed$/) do
   if (@Ob_Summary_screen.ob_MVsbp.exists.should be true)
       puts @Ob_Summary_screen.ob_MVsbp.text
    else
        next
   end
    if (@Ob_Summary_screen.ob_MVdbp.exists.should be true)
       puts @Ob_Summary_screen.ob_MVdbp.text
    else 
        next
    end
    if (@Ob_Summary_screen.ob_MVspo.exists.should be true)
       puts @Ob_Summary_screen.ob_MVspo.text
    else
        next
    end
end

Then(/^the fetal strip does not display$/) do
   @Ob_Summary_screen.ob_fetal_strip.exists.should be false
end

Then(/^I can view the patients last name, first name, gender, age, MRN, location, and site$/) do
  puts @Ob_Summary_screen.Ob_Summary_pName.text
  #puts @Ob_Summary_screen.Ob_Summary_pGender.text
  puts @Ob_Summary_screen.Ob_Summary_pAge.text
  #puts @Ob_Summary_screen.Ob_Summary_pMRN.text
  puts @Ob_Summary_screen.Ob_Summary_pLocation.text
  puts @Ob_Summary_screen.Ob_Summary_pSite.text
  @Ob_Summary_screen.Ob_Summary_pName.exists.should be true
  #@Ob_Summary_screen.Ob_Summary_pGender.exists.should be true
  @Ob_Summary_screen.Ob_Summary_pAge.exists.should be true
  #@Ob_Summary_screen.Ob_Summary_pMRN.exists.should be true
  @Ob_Summary_screen.Ob_Summary_pLocation.exists.should be true
  @Ob_Summary_screen.Ob_Summary_pSite.exists.should be true
end

When(/^I click to toggle the strip color$/) do
    if (@Ob_Summary_screen.tablet_color_toggle.exists == true)
      sleep(3)
      @Ob_Summary_screen.tablet_color_toggle.click
    elsif (@Ob_Summary_screen.tablet_color_toggle.exists == false)
      steps %{
		    When I click the more options button
		    And I view the ECG screen
        And I click on Toggle Color
      }
    end
end

Then(/^the OB Search screen displays$/) do
    @Ob_Summary_screen.ob_search.exists == true
end

Then(/^the OB Search screen displays in landscape$/) do
    @Ob_Summary_screen.ob_search_landscape.exists == true
end

Then(/^Census displays in the banner$/) do
    @Ob_Summary_screen.ob_search.text == "Census"
    puts @Ob_Summary_screen.ob_search.text
end

Then(/^the site name displays in the banner$/) do
    puts @Ob_Summary_screen.obcen_sitename.text
end

Then(/^I have patients displayed$/) do
    @Patient_Summary_screen.first_patient.exists == true
end

When(/^I enter Jane Doe in the ob search field$/) do 
  #Common.wait_for_loading_prompt(selenium)
  @Ob_Summary_screen.ob_census_search.send_keys("Jane Doe" +"\n")
  #@Ob_Summary_screen.sendKeyEvent(Keys.ENTER)
end

Then(/^I leave the app idle for 15 minutes$/) do
  sleep(900)
end

Then(/^I leave the app idle for 3 minutes$/) do
  sleep(180)
end

Then(/^I leave the app idle for 2 minutes$/) do
  sleep(120)
end

Then(/^I click on the OB search field$/) do
  @Ob_Summary_screen.ob_census_search.click
end

