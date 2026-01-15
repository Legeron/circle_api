class SwaggerUiController < ApplicationController
  # Skip authentication and authorization for public API docs
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def index
    spec_content = YAML.load_file(Rails.root.join("specs", "openapi.yaml"))

    @config_object = {
      url: spec_content,
      dom_id: "#swagger-ui",
      validatorUrl: nil
    }
    render layout: "application"
  end
end
