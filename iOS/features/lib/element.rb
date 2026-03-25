class Element
  #visit - https://github.com/appium/ruby_lib/blob/master/docs/docs.md
  
  def initialize(selenium, loc_type, locator)
    @selenium = selenium    
    element = Common.wait_for_element(@selenium, loc_type, locator)
    @element = element["id"]
    @exists = element["exists"]
  end
  
  def click
    @element.click
    #Common.wait_for_loading_prompt(@selenium)
  end
  
  def attribute(att_type)
    @element.attribute(att_type)
  end
  
  def name
    @element.name
  end
  
  def value
    @element.attribute("value")
  end
  
  def text
    @element.attribute("text")
  end
  
  def send_keys(text)
    @element.send_keys(text)
  end
  
  def setValue(text)
    @element.set_value(text)
  end
  
  def visible
    @element.displayed?
  end
  
  def exists
    @exists
  end
  
  def ref
    @element.ref
  end
  
  def location
    @element.location
  end
  
  def clear
    @element.clear
  end
  
  def id
    @element
  end
  
  def scrollTo
    begin
      @selenium.execute_script 'mobile: scrollTo', :element => self.ref
    rescue => e
      #do nothing
   
    end

  end
  
  def doubleClick
    Appium::TouchAction.new.double_tap(:element => @element).perform
  end
  
  def tapWithOptions(tapCount=1, touchCount=1, duration=0.5)
    #self.scrollTo
    #location =  self.location
    #action = Appium::TouchAction.new
    #action.press(element: self).wait(2000).release.perform
    #action.long_press(element: self).release.perform
    #@selenium.execute_script 'mobile: tap', :x => location[:x], :y => location[:y], :tapCount => tapCount, :touchCount => touchCount, :duration => duration
    #@selenium.execute_script "UIATarget.localTarget().tapWithOptions({x:#{location[:x]}, y:#{location[:y]}}, {touchCount:#{touchCount}, tapCount:#{tapCount}, duration:#{duration}, tapOffset:{x:0.0, y:0.0}});"
    #Common.wait_for_loading_prompt(@selenium)
    @selenium.execute_script 'mobile: tap', :x => self.location[:x], :y => self.location[:y]  
  end
end
