# frozen_string_literal: true

Before do
  @Header_Bar = Header_Bar.new @selenium
  @SiteList_Screen = SiteList_Screen.new @selenium
end

Then(/^the Site List screen displays$/) do
  @wait.until { @SiteList_Screen.main_div.text }

  expect(@SiteList_Screen.sites_title.text).to eql 'Sites'
  expect(@SiteList_Screen.refresh_link.text).to eql 'Refresh'
end

When(/^I click the Where Are My Sites link$/) do
  @SiteList_Screen.whereAreMySites_link.click
end

When(/^I click the Site List refresh button$/) do
  @SiteList_Screen.refresh_link.click
end

Then(/^the Where Are My Sites message displays$/) do
  @SiteList_Screen.whereAreMySitesPopup_text.should eql 'Some sites are not displayed because they have not been configured for patient monitoring.'
end

When(/^I click on site "(.*?)"$/) do |site|
  @wait.until { @SiteList_Screen.siteList_div }
  case site
  when '34 QA Cardio PM'
    siteCode = 1763
  when '35 QA Cardio PM'
    siteCode = 1764
  end

  expect(@SiteList_Screen.site_button(siteCode).text).to eql '34 QA Cardio PM EMR LightLabs (msg)'
  sleep(2)
  @SiteList_Screen.site_button(siteCode).click
end
