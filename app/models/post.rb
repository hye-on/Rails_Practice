class Post < ApplicationRecord
  before_save :check_for_banned_words

  private

  def check_for_banned_words
    banned_words = BannedWord.all

    self.status = 'approved'

    banned_words.each do |banned_word|
      content_to_check = case banned_word.match_target
                         when 'title_only'
                           title
                         when 'content_only'
                           content
                         else
                           "#{title} #{content}"
                         end

      if content_to_check.include?(banned_word.word)
        self.status = banned_word.policy == 'ban' ? 'banned' : 'warning'
        break if status == 'banned'
      end
    end
  end
end

# class Post < ApplicationRecord
#   before_save :check_for_banned_words

#   private

#   def check_for_banned_words
#     banned_words = BannedWord.pluck(:word)
#     self.status = if banned_words.any? { |word| title.include?(word) || content.include?(word) }
#                     'banned'
#                   else
#                     'approved'
#                   end
#   end
# end
