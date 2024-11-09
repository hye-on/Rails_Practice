require "application_system_test_case"

class BannedWordsTest < ApplicationSystemTestCase
  setup do
    @banned_word = banned_words(:one)
  end

  test "visiting the index" do
    visit banned_words_url
    assert_selector "h1", text: "Banned words"
  end

  test "should create banned word" do
    visit banned_words_url
    click_on "New banned word"

    fill_in "Word", with: @banned_word.word
    click_on "Create Banned word"

    assert_text "Banned word was successfully created"
    click_on "Back"
  end

  test "should update Banned word" do
    visit banned_word_url(@banned_word)
    click_on "Edit this banned word", match: :first

    fill_in "Word", with: @banned_word.word
    click_on "Update Banned word"

    assert_text "Banned word was successfully updated"
    click_on "Back"
  end

  test "should destroy Banned word" do
    visit banned_word_url(@banned_word)
    click_on "Destroy this banned word", match: :first

    assert_text "Banned word was successfully destroyed"
  end
end
