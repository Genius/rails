ActionController::Base.prepend(Module.new do
  private

  def log_processing_for_parameters
    parameters = respond_to?(:filter_parameters, :include_all) ? filter_parameters(params) : params.dup
    parameters = parameters.except!(:controller, :action, :format, :_method)

    logger.info "  Parameters: #{parameters.inspect}" unless parameters.empty?
  end
end)
