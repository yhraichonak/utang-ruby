# frozen_string_literal: true

Before do
  @Documents_Screen = Documents_Screen.new @selenium
end

Then(/^I should see the Snippets Rhythms Documents screen$/) do
  sleep 2
  @wait.until { @Documents_Screen.documents_widget }

  expect(@Documents_Screen.documents_widget).to be_truthy
  puts "sum doc tile count "
  puts @sum_doc_tile_count.to_i
  puts "doc screen documents count "
  puts @Documents_Screen.document_list(0)['document_count']
  expect(@sum_doc_tile_count.to_i).to eql @Documents_Screen.document_list(0)['document_count']

  x = 0

  unless @summary_doc_count.nil?
    previous_doc_date = nil
    while x < @summary_doc_count
      doc_list_title = @Documents_Screen.document_list(x)['title'].text
      doc_list_type = @Documents_Screen.document_list(x)['type'].text
      doc_list_author = @Documents_Screen.document_list(x)['author'].text
      doc_list_date = @Documents_Screen.document_list(x)['date'].text
      doc_list_status = @Documents_Screen.document_list(x)['status']

      if INFO == true
        puts doc_list_title
        puts doc_list_type
        puts doc_list_author
        puts doc_list_date
        puts doc_list_status
        puts '_________________________'
      end

      expect(@sum_tile_doc_desc[x]).to eql doc_list_title
      expect(doc_list_date).to include @sum_tile_doc_date[x]
      expect(DateTime.strptime(doc_list_date, '%m/%d/%Y - %H:%M:%S')).to be_truthy

      unless previous_doc_date.nil?
        # check if documents are listed LIFO
        expect(previous_doc_date).to be >= doc_list_date
      end
      previous_doc_date = doc_list_date
      x += 1
    end
  end
end

Then(/^I should see No Documents message and No Documents selected$/) do
  expect(@Documents_Screen.documentsNoData_container.displayed?).to be_truthy
end

Then(/^I should see Event Descriptions wrapping up to three lines$/) do
  # no code needed assertions on view doc screen cover list more for manual documentation
end

When(/^I select document item "(.*?)" in sidebar list$/) do |item|
  @Documents_Screen.document_list(item.to_i - 1)['document_obj'].click
end

Then(/^I should see the document item "(.*?)" selected$/) do |item|
  @doc_list_title = @Documents_Screen.document_list(item.to_i - 1)['title'].text
  @doc_list_type = @Documents_Screen.document_list(item.to_i - 1)['type'].text
  @doc_list_author = @Documents_Screen.document_list(item.to_i - 1)['author'].text
  @doc_list_date = @Documents_Screen.document_list(item.to_i - 1)['date'].text

  if INFO == true
    puts @doc_list_title
    puts @doc_list_type
    puts @doc_list_author
    puts @doc_list_date
  end

  expect(@Documents_Screen.document_list(item.to_i - 1)['selected']).to be_truthy
end

Then(/^the document should appear in viewer$/) do
  sleep 2
  listdate = DateTime.strptime(@doc_list_date, '%m/%d/%Y - %H:%M').strftime('%m/%d/%Y - %H:%M')

  @wait.until { @Documents_Screen.document_container['document_obj'] }

  expect(@Documents_Screen.document_container['container_obj'].displayed?).to be_truthy
  expect(@Documents_Screen.document_container['document_obj'].displayed?).to be_truthy

  #expect(@Documents_Screen.document_container['header'].text).to include @doc_list_title

  expect(@Documents_Screen.document_container['header'].text).to include listdate
end

When(/^I click the zoom "(.*?)" button on document viewer$/) do |type|
  objectCoord = @Documents_Screen.document_container['document_obj'].rect
  # log objectCoord

  x = 0
  y = 0
  case type
  when 'in'
    x = objectCoord[:width] - 75
    y = objectCoord[:height] - 100
  when 'out'
    x = objectCoord[:width] - 75
    y = objectCoord[:height] - 50
  end

  @selenium.action.move_to(@Documents_Screen.document_container['document_obj'], x, y).click.release.perform

  sleep 2
end

When(/^I click the page fit button on document viewer$/) do
  objectCoord = @Documents_Screen.document_container['document_obj'].rect
  # #<struct Selenium::WebDriver::Rectangle x=300, y=245, width=980, height=532>

  x = objectCoord[:width] - 75
  y = objectCoord[:height] - 175

  @selenium.action.move_to(@Documents_Screen.document_container['document_obj'], x, y).click.release.perform
  sleep 2
end

When(/^I should see document viewer zoom correctly$/) do
  # selenium can't see pdf viewer, this is manual visual check
end

When(/^I should see the document list scroll correctly$/) do
  # selenium can't see pdf viewer, this is manual visual check
end

When(/^I should see the document viewer scroll correctly$/) do
  # selenium can't see pdf viewer, this is manual visual check
end

When(/^I scroll "(.*?)" on the document list$/) do |direction|
  case direction
  when 'up'
    (1..5).each do |_a|
      @selenium.action.key_down(:up).perform
      sleep 0.5
    end
  when 'down'
    (1..5).each do |_a|
      @selenium.action.key_down(:down).perform
      sleep 0.5
    end
  end
end

When(/^I scroll "(.*?)" on the document viewer$/) do |direction|
  objectCoord = @Documents_Screen.document_container['document_obj'].rect
  # #<struct Selenium::WebDriver::Rectangle x=300, y=245, width=980, height=532>
  case direction
  when 'down'
    x = objectCoord[:width] - 5
    y = objectCoord[:height] - 5
  when 'up'
    x = objectCoord[:width] - 5
    y = 5
  when 'right'
    x = objectCoord[:width] - 25
    y = objectCoord[:height] - 5
  when 'left'
    x = 5
    y = objectCoord[:height] - 5
  end

  @selenium.action.move_to(@Documents_Screen.document_container['document_obj'], x, y).click.release.perform
  sleep 5
end

When(/^I click on the Unapproved icon for latest snippet document$/) do
  @Documents_Screen.document_list(0)['document_obj'].click
end

When(/^I should see the Approve and Reject buttons in list for selected document$/) do
  doc_list = @Documents_Screen.document_list(0)
  expect(doc_list['primary_button_obj'].text).to eql "Approve"
  expect(doc_list['reject_button_obj'].text).to eql "Reject"
end

When(/^I should see not the Approve and Reject buttons in list for selected document$/) do
  buttons = false
  begin
    expect(@Documents_Screen.document_list(0)['primary_button_obj'].displayed?).to be_falsey
    expect(@Documents_Screen.document_list(0)['reject_button_obj'].displayed?).to be_falsey
    buttons = true
  rescue StandardError
    expect(buttons).to be_falsey
  end
end

When(/^I click the Approve button on selected document$/) do
  # @Documents_Screen.document_list(0)['primary_button_obj'].click
  @selenium.find_element(:css, "button.primary").click
  sleep 1
end

Then(/^I should see the document selected refresh with approved icon$/) do
  sleep 3
  expect(@Documents_Screen.document_list(0)['status']).to eql 'Approved'
end

When(/^I click the Reject button on selected document$/) do
  @Documents_Screen.document_list(0)['reject_button_obj'].click
end

Then(/^I should see prompt to Reject or Cancel selected document$/) do
  @wait.until { @Documents_Screen.alert_title.displayed? == true }
  expect(@Documents_Screen.alert_title.text).to eql 'Reject Snippet'
  expect(@Documents_Screen.alert_content.text).to eql 'Are you sure you want to Reject?'
  expect(@Documents_Screen.alert_reject_button.displayed?).to be_truthy
  expect(@Documents_Screen.alert_cancel_button.displayed?).to be_truthy
end

When(/^I click Reject button in prompt window$/) do
  sleep(0.5)
  # selenium click on reject button not working.
  @selenium.action.send_keys(:return).perform
  # @Documents_Screen.alert_reject_button.click
end

When(/^I click Cancel button in prompt window$/) do
  sleep 2
  # @Documents_Screen.alert_cancel_button.click
  @selenium.action.send_keys(:tab).perform
  @selenium.action.send_keys(:return).perform
end

Then(/^I should see the document selected refresh with rejected icon$/) do
  sleep 3
  expect(@Documents_Screen.document_list(0)['status']).to eql 'Rejected'
end

Then(/^I should see the document selected refresh with unapproved icon$/) do
  expect(@Documents_Screen.document_list(0)['status']).to eql 'Unapproved'
end

Then(/^I should see Approval icons in document list$/) do
  listCount = @Documents_Screen.document_list(0)['document_count']
  puts listCount if INFO == true

  if listCount > 15
    # only check the first 15 (performance)
    listCount = 15
  end

  (0..(listCount - 1)).each do |i|
    status = @Documents_Screen.document_list(i)['status']
    puts status if INFO == true

    icon = case status
           when 'Unapproved'
             true
           when 'Rejected'
             true
           when 'Saved'
             true
           when 'Approved'
             true
           else
             false
           end
    expect(icon).to be_truthy
  end
end

Then(/^the Snippets Document view displays "(.*?)"$/) do |string|
  # step can't be automated since window has an dynamic image
end

Then(/^I should see the snippet descriptions not wrap and truncate when necessary$/) do
  # step can't be automated visual check
end
