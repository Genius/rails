# from https://gist.github.com/grosser/599b47bea7f3c5a044cb
# fixed in rails 3 by https://github.com/rails/rails/commit/4f12e3a3a5d28b63a74344cc8997b8466d276277
# see https://github.com/rails/rails/issues/7430

class ERB
  module Util
    def html_escape(s)
      s = s.to_s
      if s.html_safe?
        s
      else
        s.gsub(/[&"'><]/, HTML_ESCAPE).html_safe
      end
    end

    alias h html_escape

    singleton_class.send(:remove_method, :html_escape)
    module_function :html_escape, :h
  end
end
