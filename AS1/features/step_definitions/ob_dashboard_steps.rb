# frozen_string_literal: true

Before do
    @OB_Dashboard = OB_Dashboard.new @selenium
    @Header_Bar = Header_Bar.new @selenium
end
  
Then(/^I should see the OB Dashboard screen$/) do
    @wait.until { @OB_Dashboard.ob_waveform_chart.displayed? == true }
    expect(@OB_Dashboard.ob_waveform_chart).to be_truthy
    expect(@OB_Dashboard.ob_maternal_vitals).to be_truthy
    expect(@OB_Dashboard.ob_cervical_exams).to be_truthy
    sleep 5
end

When(/^I take a snapshot of the OB Dashboard$/) do 
    time_scale = @OB_Dashboard.time_scale
    @og_delay_time = @OB_Dashboard.delay_time
    puts @og_delay_time.text
end

Then(/^I should see the dashboard updates with new patient information$/) do
    old_time = @og_delay_time
    new_time = @OB_Dashboard.delay_time.text

    expect(new_time == old_time).to be_falsey
end

Then(/^I should see "(.*?)" tile in the OB Dashboard$/) do |tile|
    selected_tile = ''

    case tile
    when "Maternal Vitals"
        selected_tile = @OB_Dashboard.ob_maternal_vitals
    when "Cervical Exams"
        selected_tile = @OB_Dashboard.ob_cervical_exams
    when "Annotations"
        selected_tile = @OB_Dashboard.ob_annotations
    when "Pitocin"
        selected_tile = @OB_Dashboard.ob_pitocin
    end

    expect(selected_tile.displayed?).to be true
end
 
When(/^I click the "(.*?)" tile$/) do |tile|
    selected_tile = ''

    case tile
    when "Maternal Vitals"
        selected_tile = @OB_Dashboard.ob_maternal_vitals
    when "Cervical Exams"
        selected_tile = @OB_Dashboard.ob_cervical_exams
    when "Annotations"
        selected_tile = @OB_Dashboard.ob_annotations
    when "Pitocin"
        selected_tile = @OB_Dashboard.ob_pitocin
    end

    puts selected_tile.text 
    selected_tile.click()
    sleep 3
    @selected_tile = selected_tile
end

Then(/^I should see the "(.*?)" tile expand below the monitor$/) do |tile|
    selected_tile = ''

    case tile
    when "Maternal Vitals"
        selected_tile = @OB_Dashboard.ob_maternal_vitals
    when "Cervical Exams"
        selected_tile = @OB_Dashboard.ob_cervical_exams
    when "Annotations"
        selected_tile = @OB_Dashboard.ob_annotations
    when "Pitocin"
        selected_tile = @OB_Dashboard.ob_pitocin
    end
    monitor = @OB_Dashboard.ob_waveform_chart
    
    expect(monitor.displayed?).to be true

    puts selected_tile.attribute(:class)
    selected_tile.attribute(:class).should include 'expanded'
end