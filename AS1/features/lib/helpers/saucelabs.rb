# frozen_string_literal: true

class SauceLabs
  def options(remote_browser, selenium_ver)
    { browserName: remote_browser,
      platformName: ENV['PLATFORM_NAME'] || 'Windows 10',
      browserVersion: ENV['BROWSER_VERSION'] || 'latest',
      'sauce:options': { tunnelIdentifier: 'scott.gillenwater_tunnel_id',
                         "seleniumVersion": selenium_ver,
                         # "extendedDebugging": false,
                         # "capturePerformance": false,
                         screenResolution: '1280x960',
                         "passed": true } }
  end
end
