# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class EditConfirm_window
  def initialize(selenium)
    @selenium = selenium
  end

  def statement_editor_window
    @selenium.find_element(:class, 'statement-editor')
  end

  def date_acquisition_time
    @selenium.find_element(:class, 'acquisition-time')
  end

  def ecg_measurements
    statement_editor = @selenium.find_element(:class, 'statement-editor')
    stats = statement_editor.find_element(:class, 'stats')
    values = stats.find_elements(:css, 'td.value')

    {
      'stats' => stats,
      'vhr' => values[0],
      'pr' => values[1],
      'qrs' => values[2],
      'prt' => values[3],
      'ahr' => values[4],
      'qt' => values[5],
      'qtc' => values[6]
    }
  end

  def sentence_containers
    @selenium.find_elements(:class, 'sentence')
  end

  def delete_sentences
    @selenium.find_elements(:class, 'delete-sentence')
  end

  def delete_word
    @selenium.find_elements(:class, 'delete-word')
  end

  def appendStatement_button
    @selenium.find_element(:css, 'button.btn.append-statement')
  end

  def cancel_button
    @selenium.find_element(:css, 'button.cancel.btn.secondary')
  end

  def back_button
    actions = @selenium.find_element(:class, 'swal2-actions')
    #@selenium.find_element(:css, 'button.cancel.btn.secondary')
    button = actions.find_element(:class, 'swal2-cancel')
    return button
  end

  def confirm_button
    @selenium.find_element(:css, 'button.cancel.btn.primary')
  end

  def undoEdit_prompt_window
    @selenium.find_element(:id, 'swal2-content')
  end

  def undoEdit_prompt_undoEdits_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def undoEdit_prompt_cancel_button
    @selenium.find_element(:class, 'swal2-cancel')
  end

  def confirm_prompt_window
    @selenium.find_element(:id, 'swal2-content')
  end

  def confirm_prompt_confirm_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def confirm_prompt_cancel_button
    @selenium.find_element(:class, 'swal2-cancel')
  end

  def statementLibrary
    statementLibrary = @selenium.find_element(:class, 'suggestions')
    statementLibrary.find_elements(:class, 'suggestion')
  end

  def edit_confirm_message
    @selenium.find_element(:id, 'swal2-content')
  end

  def edit_confirm_message_ok_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def edit_confirm_message_cancel_button
    @selenium.find_element(:class, 'swal2-cancel')
  end
end
