module KEYBOARD
  def toggle_hardware_keyboard	
	`osascript -e 'tell application "Simulator" to activate'`	
	`osascript -e 'tell application "System Events" to key code 40 using {shift down, command down}'`	
  end
end
