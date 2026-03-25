# frozen_string_literal: true

# This is the login screen you initially see upon navigating to the site, http://10.10.0.119/utangWebExternalGS/
# This will display if the user is logged out, this is BEFORE the site list.
# If a tester see's the site list, they must puts out to reach this screen.

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class SignOn_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def main_div
    @selenium.find_element(:id, 'mainDiv')
  end

  def signOn_button
    @selenium.find_element(:id, 'btnLogin')
  end

  def resetPassword_button
    @selenium.find_element(:id, 'btnReg')
  end

  def signIn_div
    @selenium.find_element(:id, 'utangSignIn')
  end
end
