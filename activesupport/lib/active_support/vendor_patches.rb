# monkey patches for vendored i18n
# has to be called after `core_ext`, because i18n otherwise messes up Hash#slice

module I18n
  if !respond_to?(:normalize_translation_keys) && respond_to?(:normalize_keys)
    def self.normalize_translation_keys(*args)
      normalize_keys(*args)
    end
  end

  require 'i18n/version'
  if VERSION == '0.4.1'
    # needs a monkey patch
    Backend::Base.module_eval do
      def load_file(filename)
        type = File.extname(filename).tr('.', '').downcase
        raise UnknownFileType.new(type, filename) unless respond_to?(:"load_#{type}", true) # <- patched here
        data = send(:"load_#{type}", filename)
        data.each { |locale, d| store_translations(locale, d) }
      end
    end
  end
end
