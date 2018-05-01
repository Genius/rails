# Prefer gems to the bundled libs.
require 'rubygems'

begin
  gem 'tmail', '~> 1.2.7'
rescue Gem::LoadError
  $:.unshift "#{File.dirname(__FILE__)}/tmail-1.2.7"
end

module TMail
end

require 'tmail'

silence_warnings do
  TMail::Encoder.const_set("MAX_LINE_LEN", 200)
end

if ActiveSupport.modern_ruby?
  # some monkey patches required
  module TMail
    Unquoter.class_eval do
      class << self
        def convert_to(text, to, from)
          return text if to == 'utf-8' and from == 'utf-8' and text.encoding == Encoding::UTF_8
          original_encoding = text.encoding
          begin
            text.force_encoding(from) if from
          rescue ArgumentError
            # unknown encoding
          end

          if to
            begin
              text.encode(to)
            rescue EncodingError
              text.force_encoding(original_encoding)
              text
            end
          else
            text
          end
        end
      end
    end
  end
end
