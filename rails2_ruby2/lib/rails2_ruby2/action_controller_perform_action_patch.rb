ActionController::Base.class_eval do
  private

  def perform_action_without_filters
    if action_methods.include?(action_name)
      send(action_name)
      default_render unless performed?
    elsif respond_to?(:method_missing) || protected_methods.include?(:method_missing)
      method_missing action_name
      default_render unless performed?
    else
      begin
        default_render
      rescue ActionView::MissingTemplate => e
        # Was the implicit template missing, or was it another template?
        if e.path == default_template_name
          raise ActionController::UnknownAction, "No action responded to #{action_name}. Actions: #{action_methods.sort.to_sentence(:locale => :en)}", caller
        else
          raise e
        end
      end
    end
  end
end
