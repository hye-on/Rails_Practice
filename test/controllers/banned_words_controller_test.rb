require "test_helper"

class BannedWordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @banned_word = banned_words(:one)
  end

  test "should get index" do
    get banned_words_url
    assert_response :success
  end

  test "should get new" do
    get new_banned_word_url
    assert_response :success
  end

  test "should create banned_word" do
    assert_difference("BannedWord.count") do
      post banned_words_url, params: { banned_word: { word: @banned_word.word } }
    end

    assert_redirected_to banned_word_url(BannedWord.last)
  end

  test "should show banned_word" do
    get banned_word_url(@banned_word)
    assert_response :success
  end

  test "should get edit" do
    get edit_banned_word_url(@banned_word)
    assert_response :success
  end

  test "should update banned_word" do
    patch banned_word_url(@banned_word), params: { banned_word: { word: @banned_word.word } }
    assert_redirected_to banned_word_url(@banned_word)
  end

  test "should destroy banned_word" do
    assert_difference("BannedWord.count", -1) do
      delete banned_word_url(@banned_word)
    end

    assert_redirected_to banned_words_url
  end
end
