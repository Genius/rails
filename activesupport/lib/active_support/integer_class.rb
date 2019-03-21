module ActiveSupport
  # to refer to an integer, old ruby versions needed
  # to use `Fixnum`, newer rubies use `Integer`
  # to simplify other parts of the code and avoiding many version switches
  # we alias the appropriate class as `ActiveSupport::IntegerClass`
  if RUBY_VERSION >= '2.4'
    IntegerClass = ::Integer
  else
    IntegerClass = ::Fixnum
  end
end
