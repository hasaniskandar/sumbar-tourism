#module ActionView
#  module Helpers
#    def localize(*args)
#      I18n.localize(*args) unless args.first.nil?
#    end
#    alias l localize
#  end
#end

module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def prompt_sign_in?
    !!params[:prompt_sign_in]
  end
end
