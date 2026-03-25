module Appium_lib
  def predicate_include(appium, class_name, value)
    element = nil
    begin
      element = appium.find_ele_by_predicate_include(:class_name => class_name, :value => value)
    rescue
      element = nil
    end
    return element
  end
  
  def predicates_include(appium, class_name, value)
    element = nil
    begin
      element = appium.find_eles_by_predicate_include(:class_name => class_name, :value => value)
    rescue
      element = nil
    end
    return element
  end
  
  def predicate(appium, class_name, value)
    element = nil
    begin
      element = appium.find_ele_by_predicate(:class_name => class_name, :value => value)
    rescue
      element = nil
    end
    return element
  end
  
  def predicates(appium, class_name, value)
    element = nil
    begin
      element = appium.find_eles_by_predicate(:class_name => class_name, :value => value)
    rescue
      element = nil
    end
    return element
  end
  
  def tags_exact(appium, class_name, value)
    element = nil
    begin
      element = appium.tags_exact(:class_name => class_name, :value => value)
    rescue
      element = nil
    end
    return element
  end
  
  def by_attribute(appium, class_name, attr, attr_value)
    element = nil
    begin
      element = appium.find_eles_by_attr(:class_name => class_name, :attr => attr, :value => attr_value)
    rescue
      element = nil
    end
    return element
  end
  
  def find_exact(appium, value)
    element = nil
    begin
      element = appium.find_exact(:value => value)
    rescue
      element = nil
    end
    return element
  end 
  
  def first_element_by_class(class_name)
    element = nil
    begin
      element = appium.first_ele(:class_name => class_name)
    rescue
      element = nil
    end
    return element
  end 
end