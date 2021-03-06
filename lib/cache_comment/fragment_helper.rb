module CacheComment
  module FragmentHelper

    def write_fragment(key, content, options = nil)
      comment = CommentFormatter.new(fragment_cache_key(key), options)
      content = comment.start + content + comment.end
      super key, content, options
    end

    def read_fragment(key, options)
      unless params[:cache_comments]
        comment = CommentFormatter.new(fragment_cache_key(key), options)
        fragment = super(key, options)
        fragment.gsub(comment.start_regex, '').gsub(comment.end_regex, '') unless fragment.nil?
      else
        super key, options
      end
    end
  end
end
