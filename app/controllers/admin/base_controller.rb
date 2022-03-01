class Admin::BaseController < ApplicationController
  layout "admin/layouts/application"
  before_action :check_role_admin
end
