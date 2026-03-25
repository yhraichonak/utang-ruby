require 'pp'
require 'test/unit/assertions'
include Test::Unit::Assertions

dnf = "did not find '%s'"
dnm = "does not match '%s'"
@about_details = []

Before do
  @Menu = Menu.new selenium, appium
  @About_window = About_window.new selenium, appium
  @Signoff_window = Signoff_window.new selenium, appium
  @Result = ResultHandler.new
end

When(/^I have AS1$/) do

end

And(/^the Application Info should display$/) do
  sleep(3)
  @about_details = @About_window.about_screen_details if @about_details == nil
  hash = @about_details

  @Result.yield_results("About Window: Application Info", hash) {
    assert(hash["about_header"], dnf % "about_header")
    assert(hash["app_info_header"], dnf % "app_info_header")
    assert(hash.key?("app_name_label"), dnf % "app_name_label")
    assert_equal('QA - utang ONE®', hash["app_name_text"], dnm % "app_name_text")
    assert(hash.key?("app_version_label"), dnf % "app_version_label")
    assert(hash["app_version_text"].match /(^\d{1,2}\.\d{1,2}\.\d{1,2}(.*))/x)
    assert(hash.key?("build_label"), dnf % "build_label")
    assert(hash["build_text"].match /(^[1-9][0-9]*)/x)
    assert(hash.key?("variant_label"), dnf % "variant_label")
    assert_equal("rc qa debug", hash["variant_text"].downcase, dnm % "variant_text")
    assert(hash.key?("udi_label"), dnf % "udi_label")
    # assert(hash["udi_text"].match /(^\+[A-Z][0-9]*\/\$\$[0-9]*\/[0-9]*[A-Z]\d{8}[A-Z])/x)
    assert(hash.key?("copyright_label"), dnf % "copyright_label")
    assert(hash["copyright_text"].match /(^\©\s20\d{2}\sutang)/x)
    assert(hash.key?("patent_label"), dnf % "patent_label")
    assert_equal("USPTO 8,255,238", hash["patent_text"], dnm % "patent_text")
  }
end

And(/^the Device Info should display$/) do
  @about_details = @About_window.about_screen_details if @about_details == nil
  hash = @about_details

  @Result.yield_results("About Window: Device Info", hash) {
    assert(hash["device_info_header"], dnf % "device_info_header")
    assert(hash.key?("reg_code_label"), dnf % "reg_code_label")
    # assert(hash["reg_code_text"].match /(^\d+\-\d+)/x)
    assert(hash.key?("reg_email_label"), dnf % "reg_email_label")
    # assert(hash["reg_email_text"].match /^[\s\S]*\@[\s\S]*\.[A-z]*/x)
    assert(hash.key?("unique_id_label"), dnf % "unique_id_label")
    assert(hash["unique_id_text"].match /^[a-z0-9]{16}/x)
    assert(hash.key?("device_model_label"), dnf % "device_model_label")
    assert(hash["device_model_text"].is_a? String)
    assert(hash.key?("system_version_label"), dnf % "system_version_label")
    assert(hash["system_version_text"].match /^\d|(\d{1,2})/x)
  }
end

And(/^the Technical Support Info should display$/) do
  @about_details = @About_window.about_screen_details if @about_details == nil
  hash = @about_details

  @Result.yield_results("About Window: Technical Support Info", hash) {
    # assert(hash["technical_support_label"], dnf % "technical_support_label")
    # assert(hash["online_user_guide_link"], dnf % "online_user_guide_link")
    assert(hash.key?("phone_us_label"), dnf % "phone_us_label")
    assert_equal("1-877-258-5869", hash["phone_us_text"], dnm % "phone_us_text")
    assert(hash.key?("phone_uk_label"), dnf % "phone_uk_label")
    assert_equal("800: 0-800-088-5520", hash["phone_uk_text"], dnm % "phone_uk_text")
    assert(hash.key?("phone_ca_label"), dnf % "phone_ca_label")
    assert_equal("1-210-805-0444, Option 2", hash["phone_ca_text"], dnm % "phone_ca_text")
    assert(hash.key?("phone_au_label"), dnf % "phone_au_label")
    assert_equal("039832 2222", hash["phone_au_text"], dnm % "phone_au_text")
    assert(hash.key?("email_support_label"), dnf % "email_support_label")
    assert_equal("support@xxxx.com", hash["email_support_text"], dnm % "email_support_text")
  }
end

And(/^the Manufactured By Info should display$/) do
  @about_details = @About_window.about_screen_details if @about_details == nil
  hash = @about_details

  @Result.yield_results("About Window: Manufactured By Info", hash) {
    assert(hash.key?("manufactured_by_header"), dnf % "manufactured_by_header")
    assert_equal("utang Technologies, Inc.\n2915 W. Bitters Rd. Suite 215\nSan Antonio, TX 78248 USA",
                 hash["manufactured_by_text"], dnm % "manufactured_by_text")
    assert(hash["man_date_text"].match /(^20\d{2}\/\d{1,2}\/\d{1,2})/x)
  }
end

And(/^the EU Authorized Representative Info should display$/) do
  @about_details = @About_window.about_screen_details if @about_details == nil
  hash = @about_details

  @Result.yield_results("About Window: EU Auth. Rep. Info", hash) {
    assert(hash.key?("eu_auth_rep_label"), dnf % "eu_auth_rep_label")
    assert_equal("MedEnvoy Global B.V.\nPrinses Margrietplantsoen 33 - Suite 123\n2595 AM The Hague\nThe Netherlands",
                 hash["eu_auth_rep_text"], dnm % "eu_auth_rep_text")
  }
end

And(/^the AU Authorized Representative Info should display$/) do
  @about_details = @About_window.about_screen_details if @about_details == nil
  hash = @about_details

  @Result.yield_results("About Window: AU Auth. Rep. Info", hash) {
    assert(hash.key?("au_auth_rep_label"), dnf % "au_auth_rep_label")
    assert_equal("Cardioscan Services Pty Ltd.\n293 Camberwell Rd. Suite 301\nVictoria 3124 Australia\n+61 3 9832 2222\n0 3 9832-2222",
                 hash["au_auth_rep_text"], dnm % "au_auth_rep_text")
  }
end

When(/^I see the End User License Agreement link$/) do
  @about_details = @About_window.about_screen_details if @about_details == nil
  @About_window.end_user_lic_agreement_element.attribute('displayed').should eq "true"
end

When(/^I click on the End User License Agreement link$/) do
  @about_details = @About_window.about_screen_details if @about_details == nil

  @Result.yield_results("About Window: EULA Info", hash) {
    assert(@about_details["eula_link"], dnf % "eula_link")
  }

  @About_window.end_user_lic_agreement_link.click
end

Then(/^the End User License Agreement displays$/) do
  sleep(2)
  begin
    wait_for(6) { @About_window.webview_title.text.should eq "EULA" }
  rescue
    wait_for(6) { @About_window.webview_title.text.should eq "EULA" }
  end
  @About_window.alert_ok_button.text.should eq "OK"
  @About_window.alert_ok_button.click
end
