class BuilderController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper, UsersHelper
  include Builder::SitesHelper, Builder::PageTypesHelper, Builder::PagesHelper

  before_filter :init_options

  def home
    if user_signed_in?
      if has_sites? || admin?
        redirect_to(has_multiple_sites? ? builder_sites_path : builder_site_path(only_site))
      else
        sign_out_and_redirect(current_user)
      end
    end
  end

  private

    def init_options
      @options = {
        'sidebar' => true,
        'body_classes' => ''
      }
    end

end
