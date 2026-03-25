
class BrowserOptions
  def preferences(browser)
    options = nil
    case browser
    when 'chrome'
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--ignore-certificate-errors')
      options.add_argument('--disable-save-password-bubble')
      options.add_argument('--capture-network-traffic')  # Added by Neil.N for network traffic log testing
      options.add_option(:exclude_switches, ['enable-automation'])
      options.add_preference(:credentials_enable_service, false)
      options.add_preference(:password_manager_enabled, false)
      options.add_preference(:captureNetworkTraffic, true) # Added by Neil.N for network traffic log testing
      # options.add_argument('--headless')
    when 'edge'
      options = Selenium::WebDriver::Edge::Options.new
      options.add_option(:exclude_switches, ['enable-automation'])
      options.add_preference(:credentials_enable_service, false)
      options.add_preference(:password_manager_enabled, false)
    end
    options
  end
end
