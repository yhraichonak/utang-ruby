# encoding: utf-8

class Element
  #visit - https://github.com/appium/ruby_lib/blob/master/docs/docs.md
  
  def initialize(selenium, loc_type, locator)
    @selenium = selenium
    element = Common.wait_for_element(@selenium, loc_type, locator)
    @element = element["id"]
    @exists = element["exists"]
  end
  
  def click(offsetX = 0, offsetY = 0)
	   #Common.wait_for_loading_prompt(@selenium)
    if offsetX != 0 or offsetY != 0
      location = @element.location
      @selenium.execute_script 'mobile: tap', :x => location[:x]+offsetX, :y => location[:y]+offsetY
    else
      @element.click
    end
    #Common.wait_for_loading_prompt(@selenium)
  end
  
  def doubleClick2(offsetX = 0, offsetY = 0)
    location = @element.location
    puts Time.now
    Appium::TouchAction.new.tap( :x => location[:x] + offsetX, :y => location[:y] + offsetY, :count => 3).release.perform
    Appium::TouchAction.new.tap( :x => location[:x] + offsetX, :y => location[:y] + offsetY, :count => 3).release.perform
    puts Time.now
    #Common.wait_for_loading_prompt(@selenium)
  end
  
  def clear
    @element.clear
  end
  
  def longclick(offsetX = 0, offsetY = 0)    
    location = @element.location
    #@selenium.execute_script 'mobile: swipe', :startX => location[:x]+offsetX, :startY =>location[:y]+offsetY, :endX => location[:x]+offsetX, :endY => location[:y]+offsetY, :duration => 3
    Appium::TouchAction.new.swipe(:start_x => location[:x]+offsetX, :start_y => location[:y]+offsetY, :end_x => location[:x]+offsetX, :end_y => location[:y]+offsetY, :duration => 3000).perform
    #Common.wait_for_loading_prompt(@selenium)
  end
  
  def attribute(att_type)
    @element.attribute(att_type)
  end
  
  def name   
    @element.tag_name
  end
  
  def value
    @element.attribute("value")
  end
  
  def text
    @element.text
  end
   
  def send_keys(text)
    @element.send_keys(text)
  end
  
  def visible
    @element.displayed?
  end
  
  def exists
    @exists
  end
  
  def location
	@element.location
  end
  
  def size
	@element.size
  end
  
  def scrollTo
    begin
      @selenium.execute_script 'mobile: scrollTo', :element => @element.ref
    rescue => e
      #do nothing
    end
  end
  
  def swipe
    @selenium.execute_script 'mobile: swipe', :x => location[:x], :y => location[:y]
  end
  
  def ref
    @element.ref
  end

  
  #Need function for special iOS instruments commands
  #selenium.execute_script 'mobile: tap', :element => @Login_screen.login_button.ref
  
  #Function to get page objects
  #puts JSON.parse selenium.page_source
end
