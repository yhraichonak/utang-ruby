# frozen_string_literal: true

# This will be for the page that displays when clicing on "Snippet Worklist" from the header bar at the top of the screen

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class SnippetWorklist_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def column_toggle
    controlrow = @selenium.find_element(:css, 'div.toggle.single-column-control')
    switch = controlrow.find_element(:css, '.onoffswitch')
    checkbox = switch.find_element(:css, '.onoffswitch-checkbox')

    disabled = if controlrow.attribute('className').include? 'disabled'
                 true
               else
                 false
               end

    {
      'toggle_obj' => switch,
      'disabled' => disabled,
      'buttonOn' => checkbox.selected?
    }
  end

  def hideCompleted_toggle
    controlrow = @selenium.find_element(:css, 'div.toggle.hide-completed-control')
    switch = controlrow.find_element(:css, '.onoffswitch')
    checkbox = switch.find_element(:css, '.onoffswitch-checkbox')
    value = switch.find_element(:css, '.onoffswitch-checkbox')
    disabled = if controlrow.attribute('className').include? 'disabled'
                 true
               else
                 false
               end

    {
      'toggle_obj' => switch,
      'disabled' => disabled,
      'buttonOn' => checkbox.selected?
    }
  end
end
