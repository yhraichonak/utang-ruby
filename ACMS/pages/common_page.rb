Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class CommonPage
  def initialize(selenium)
    @selenium = selenium
  end

  def header()
    @selenium.find_element(:xpath, "//div[@data-testid='header']")
  end

  def utang_logo()
    header.find_element(:xpath,"descendant::img[@alt='utang one logo']")
  end

  def app_logo()
    header.find_element(:xpath,"descendant::img[@data-testid='app-logo']")
  end

  def sitename_label()
    header.find_element(:xpath,"descendant::div[div[@data-testid='site-name']]")
  end

  def units_filter_label()
    @selenium.find_element(:css, "div[data-testid='units-filter']")
  end

  def units_filter_summary_value()
    @selenium.find_element(:css, "div[data-testid='units-filter'] div[data-testid='summary-value-container']")
  end

  def user_panel
    @selenium.find_element(:css,"div[data-testid='user-panel'] div[data-testid='username']")
  end

  def logout()
    @selenium.find_element(:xpath,"//div[@data-testid='user-panel']").click
    @selenium.find_element(:xpath,"//div[@data-testid='menu-item-logout']").click
  end

  def get_current_filters()
    @selenium.find_elements(:xpath,"//div[@data-testid='select-filter-content']/descendant::div[@role='listbox']/descendant::div[@data-testid='option-value'][descendant::button[@data-state='checked']]")
  end

  def set_filter(filters)
    begin
      unit_filter_selector=@selenium.find_element(:css,"div[data-testid='select-filter-content']")
      for filter in filters
        unit_filter_selector.find_element(:xpath,".//div[contains(@data-testid,'checkbox-option') and contains(.,'#{filter}')] | .//span[contains(@data-testid,'checkbox-group-heading') and contains(.,'#{filter}')] ").click
      end
    rescue => e
      @selenium.navigate.refresh
      unit_filter_selector=@selenium.find_element(:css,"div[data-testid='select-filter-content']")
      for filter in filters
        unit_filter_selector.find_element(:xpath,".//div[contains(@data-testid,'checkbox-option') and contains(.,'#{filter}')] | .//span[contains(@data-testid,'checkbox-group-heading') and contains(.,'#{filter}')] ").click
      end
    end
  end

  def isFlightDetailsPanelOpen()
    @selenium.find_element(:xpath,"//div[@data-testid='flight-details-panel']").displayed?
  end
end
