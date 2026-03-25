require File.dirname(__FILE__) + '/element'

class EcgLead < Element
  
  def titleLabel
    properties = self.name
    if properties != nil
      lastIndex = properties.index("; 'zoomScale'")
      return properties[14..lastIndex-1]
    end
  end

  def zoomScale
    properties = self.name
    if properties != nil
      firstIndex = properties.index("'zoomScale':")
      lastIndex = properties.index("; 'hasLegend'")
      return properties[firstIndex+12..lastIndex-1]
    end
  end

  def hasLegend
    properties = self.name
    if properties != nil
      firstIndex = properties.index("'hasLegend':")
      lastIndex = properties.index("; 'legendLabel'")
      return properties[firstIndex+12..lastIndex-1]
    end
  end

  def legendLabel
    properties = self.name
    if properties != nil
      firstIndex = properties.index("'legendLabel':")
      lastIndex = properties.length-2
      return properties[firstIndex+14..lastIndex-1]
    end
  end

  def leadData
    properties = self.value
    if properties != nil
      firstIndex = properties.index("'leadData':")
      lastIndex = properties.length-2
      return properties[firstIndex+11..lastIndex-1]
    end
  end
  
  def click(tapCount=1, touchCount=1, duration=0, addX=0, addY=0)
    #self.scrollTo
    #location =  self.location
    #puts "x = #{location[:x]}"
    #puts "y = #{location[:y]}"
    
    #puts "doing some math"
    #calcx = location[:x]+25+addX
    #calcy = location[:y]+25+addY
    #  
    #puts "x afer math = #{calcx}"
    #puts "y afer math = #{calcy}"
   
    ##@selenium.execute_script 'mobile: tap', :x => location[:x]+25+addX, :y => location[:y]+25+addY, :tapCount => tapCount, :touchCount => touchCount, :duration => duratio
    Appium::TouchAction.new.tap(:element => @element, :count => 2).perform

    #ading a message for testing

    #Common.wait_for_loading_prompt(@selenium)
  end

end
