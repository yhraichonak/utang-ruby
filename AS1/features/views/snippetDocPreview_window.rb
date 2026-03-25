# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class SnippetDocPreview_Window
  def initialize(selenium)
    @selenium = selenium
  end

  def preview_window
    @selenium.find_element(:css, 'div.swal2-popup.swal2-modal.snippet-preview.swal2-show')
  end

  def preview_doc_window
    @selenium.find_element(:css, 'div.swal2-content')
  end

  def save_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def ok_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def back_button
    @selenium.find_element(:class, 'swal2-cancel')
  end

  def snippet_notification_window
    @selenium.find_element(:id, 'swal2-title')
  end

  def zoom
    zoom = @selenium.find_element(:css, 'div.zoom-control.component')
    zoom.find_element(:css, 'input')
  end
end
