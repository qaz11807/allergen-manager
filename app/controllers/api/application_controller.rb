# frozen_string_literal: true

# Api controller, handle error and auth
class Api::ApplicationController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :validate_params

  rescue_from ArgumentError do |exception|
    error_response(
      :unknown,
      error_message: "#{exception.class.name}: #{exception.message}"
    )
  end

  rescue_from RailsParam::InvalidParameterError do |e|
    error_response(:missing_params, error_message: "#{e.message} (#{e.backtrace.first})")
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    error_response(:missing_params, error_message: "#{e.class.name}: #{e.message}")
  end

  def doorkeeper_unauthorized_render_options(opts)
    error_response = ErrorResponse.to_api(:invalid_grant, opts[:error].description)
    { json: error_response[:json] }
  end

  private

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
  end

  def success_response(data)
    render status: :ok, json: { data: data }
  end

  def error_response(key, error_message = nil)
    render_content = ErrorResponse.to_api(key, error_message).deep_dup
    render_content[:json].delete('app_code')
    render(render_content)
  end

  def serialize_response(serializer_name, resource, **options)
    controller_name = controller_path.classify
    serializer_class_name = "#{serializer_name.to_s.camelize}Serializer"
    serializer_class = controller_name.gsub(/Api::(\w+)::\S+$/, "Api::#{'\1'}::#{serializer_class_name}").safe_constantize || serializer_class_name.safe_constantize
    serializer = serializer_class.new(current_member: @member)
    render status: 200, json: { data: serializer.represent(resource, options) }
  end

  def validate_params
    validator_name = "#{controller_path.to_s.camelize}Validator"
    validator_class = validator_name.safe_constantize
    return if validator_class.nil?

    validator = validator_class.new(params)
    validator.send(action_name) if validator.respond_to?(action_name)
  end
end
