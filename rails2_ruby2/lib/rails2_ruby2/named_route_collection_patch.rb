ActionController::Routing::RouteSet::NamedRouteCollection.prepend(Module.new do
  private

  def define_hash_access(route, name, kind, options)
    super(route, name, kind, options).tap do
      selector = hash_access_name(name, kind)
      named_helper_module_eval "public :#{selector}"
    end
  end

  def define_url_helper(route, name, kind, options)
    super(route, name, kind, options).tap do
      selector = url_helper_name(name, kind)
      named_helper_module_eval "public :#{selector}"
    end
  end
end)
