Before do  |scenario|
  if scenario.tags.to_s.include?("@c3po")
    unless (defined? Selenium).nil?
      @C3PO_HTLM_interface = get_param("C3PO_GENERATOR_UI")
      if @c3po_browser.nil?
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--ignore-certificate-errors')
        options.add_argument('--disable-save-password-bubble')
        options.add_argument('--capture-network-traffic') # Added by Neil.N for network traffic log testing
        options.add_option(:exclude_switches, ['enable-automation'])
        options.add_preference(:credentials_enable_service, false)
        options.add_preference(:password_manager_enabled, false)
        options.add_preference(:captureNetworkTraffic, true) # Added by Neil.N for network traffic log testing
        options.add_argument('--headless')
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-gpu')
        options.add_argument('--disable-dev-shm-usage')
        @c3po_browser = Selenium::WebDriver.for :chrome, capabilities: options
        @c3po_browser.manage.timeouts.implicit_wait = 4
      end
      @c3po = C3PO_page.new @c3po_browser
    end
  end
end

After do
  begin
    @c3po_browser.quit
  rescue => e
    puts "Unable to exit C#PO generator webdriver #{e.message}"
  end
end

When(/^I open C3PO URL generation interface$/) do
  @c3po_browser.navigate.to @C3PO_HTLM_interface
end

Given(/^I generate (pm-mon|pm-evt|pm-mpv|ecg) (ast|ascom|engage|voalte|ccf|epic|mh) C3PO url with query (.*?)$/) do |target, vendor, query|
  @c3po_browser.navigate.to @C3PO_HTLM_interface
  query=process_param(query)
  @c3po.fill_c3po_params(SERVER_URL, vendor, target, SITE_ID, process_param("C3PO_USERNAME"), query, "Sh4r3d_K3y_F0r_t3st1ing_0nly_32B" )
  @C3PO_URL = @c3po.get_as1_link
  @C3PO_Mobile_URL = @c3po.get_mobile_link
end

Given(/^I navigate to the generated C3PO url$/) do
  @selenium.navigate.to @C3PO_URL
end

Given(/^I navigate to the generated mobile C3PO url$/) do
  puts @C3PO_Mobile_URL
  @appiumDriver.navigate.to @C3PO_Mobile_URL
end
