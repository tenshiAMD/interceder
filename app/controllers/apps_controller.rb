class AppsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create]

  def create
    @app = App.find_puid(params[:id])

    body = params
    body = params[:_json].first if params[:_json].present? && params[:_json].is_a?(Array)
    body = body.to_json

    @payload = @app.payloads.new(body: body)
    @payload.save
  end
end
