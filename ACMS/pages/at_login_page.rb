
Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }
require "#{File.dirname(__FILE__)}/login_page.rb"
class AlertTracker_LoginPage < LoginPage
  def initialize(selenium)
    @selenium = selenium
  end

end
