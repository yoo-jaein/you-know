module PostHelper
    def render_with_hashtags(body)
       body.gsub(/#\w+/){|word| link_to word, "/post/hashtag/#{word.delete('#')}"}.html_safe
    end
end
