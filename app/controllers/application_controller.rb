class ApplicationController < ActionController::Base
  include Pagy::Backend

  def render_flash
    render turbo_stream: turbo_stream.replace(:notifications, partial: 'shared/flash')
  end
  helper_method :render_flash
end
