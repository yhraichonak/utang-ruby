# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class Common_Page_View
  def initialize(selenium)
    @selenium = selenium
  end

  def error_popup
    @selenium.find_element(:class, 'swal2-popup')
  end
end