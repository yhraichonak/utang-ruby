# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class Documents_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def documents_widget
    @selenium.find_element(:class, 'documents')
  end

  def document_list(item)
    doc_list = @selenium.find_element(:class, 'document-list')
    items = doc_list.find_elements(:class, 'document-item')

    title = items[item].find_element(:class, 'title')
    type = items[item].find_element(:class, 'type')
    author = items[item].find_element(:class, 'author')
    date = items[item].find_element(:class, 'date')

    primary_button_obj = nil
    reject_button_obj = nil

    selected = false
    if items[item].attribute('className').include? 'selected'
      puts "selected is true"
      selected = true
      if items[item].attribute('className').include? 'status-unapproved'
        puts "status unapproved"
        actions = items[item].find_element(:css, 'div.actions')
        primary_button_obj = actions.find_element(:css, 'button.btn.primary')
        reject_button_obj = actions.find_element(:css, 'button.btn.reject')

        puts "primary_button_obj #{primary_button_obj.text}"
        puts "reject_button_obj #{reject_button_obj.text}"
      end
    end

    status = if items[item].attribute('className').include? 'status-saved'
               'Saved'
             elsif items[item].attribute('className').include? 'status-approved'
               'Approved'
             elsif items[item].attribute('className').include? 'status-rejected'
               'Rejected'
             elsif items[item].attribute('className').include? 'status-unapproved'
               'Unapproved'
             else
               'Saved'
             end

    {
      'document_count' => items.count,
      'document_obj' => items[item],
      'status' => status,
      'title' => title,
      'type' => type,
      'author' => author,
      'date' => date,
      'selected' => selected,
      'primary_button_obj' => primary_button_obj,
      'reject_button_obj' => reject_button_obj
    }
  end

  def approve_button(_row)
    @selenium.find_element(:css, 'button.btn.primary')
  end

  def reject_button(_row)
    @selenium.find_element(:css, 'button.btn.reject')
  end

  def documentsNoData_container
    @selenium.find_element(:css, 'div.document.no-data')
  end

  def document_container
    container = @selenium.find_element(:css, 'div.document-container')
    header = container.find_element(:css, 'header')
    document = container.find_element(:class, 'document')
    # document_s = document.find_element(:class, "document-scroll")
    # document_title = document_s.find_element(:css, "iframe")

    {
      'container_obj' => container,
      'header' => header,
      'document_obj' => document
      # "document_title" => document_title
    }
  end

  def document_fit_button
    @selenium.find_element(:id, 'fit-button')
  end

  def document_zoom_in_button
    @selenium.find_element(:id, 'zoom-in-button')
  end

  def document_zoom_out_button
    @selenium.find_element(:id, 'zoom-out-button')
  end

  def alert_window
    @selenium.find_element(:class, 'swal2-header')
  end

  def alert_title
    @selenium.find_element(:class, 'swal2-title')
  end

  def alert_content
    @selenium.find_element(:class, 'swal2-content')
  end

  def alert_reject_button
    actions = @selenium.find_element(:class, 'swal2-actions')
    actions.find_element(:css, 'button.swal2-confirm.swal2-styled')
  end

  def alert_cancel_button
    actions = @selenium.find_element(:class, 'swal2-actions')
    actions.find_element(:css, 'button.swal2-cancel.swal2-styled')
  end
end
