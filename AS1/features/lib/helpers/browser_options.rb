# frozen_string_literal: true

# * Deprecated passing :desired_capabilities and :options to driver initialization
# in favor of :capabilities. They now can be combined in an array to make
# custom capabilities requirements:
#   caps = Selenium::WebDriver::Remote::Capabilities.chrome
#   opts = Selenium::WebDriver::Chrome::Options.new
#   Selenium::WebDriver.for(:remote, capabilities: :chrome)
#   Selenium::WebDriver.for(:remote, capabilities: caps)
#   Selenium::WebDriver.for(:remote, capabilities: opts)
#   Selenium::WebDriver.for(:remote, capabilities: [caps, opts])

class BrowserOptions
  def preferences(browser)
    options = nil
    case browser
    when 'chrome'
      options = Selenium::WebDriver::Chrome::Options.new
      #options.add_argument('--ignore-certificate-errors') - for some reason all http requests are being forwarded  via https
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
    when 'ie'
      options = Selenium::WebDriver::IE::Options.new
      options.persistent_hover = false
      options.ensure_clean_session = true
      options.require_window_focus = true
      options.ignore_protected_mode_settings = true
    when 'safari'
      # options = Selenium::WebDriver::Safari::Options.new
      # options.browser_name = 'safari'
      # options.platform_name = 'iOS'

      #### Currently broken on selenium with safaridriver on iOS ###

      options = { browserName: 'safari',
                  platformName: 'iOS',
                  "safari:useSimulator": 'true',
                  "safari:deviceType": 'iPad',
                  "safari:diagnose": false,
                  "safari:automaticInspection": false }
    end
    options
  end
end
