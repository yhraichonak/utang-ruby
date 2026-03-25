Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

module Constants

  # Alerts
  ALERT_CANCEL ||= "cancel"
  ALERT_CONTINUE ||= "continue"
  ALERT_CONDITIONS ||= [ALERT_CANCEL, ALERT_CONTINUE]

  ALERT_TITLE_ACK_ECG ||= "Acknowledge ECG"
  ALERT_MESSAGE_ACK_ECG ||= "Do you wish to Acknowledge this ECG?" # ... [prepended partial string]
  ALERT_MESSAGE_GEN_ERR ||= "GeneralError\nException processing response"
  ALERT_MESSAGE_LOD_ERR ||= "Unable to load data from site server. Please check your network connection and try again."

  ALERT_MSGS_ON_LOAD ||= [ALERT_MESSAGE_GEN_ERR, ALERT_MESSAGE_LOD_ERR]
end