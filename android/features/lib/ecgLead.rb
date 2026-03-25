require File.dirname(__FILE__) + '/element'

class Ecg_Lead < Element
  
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

end
