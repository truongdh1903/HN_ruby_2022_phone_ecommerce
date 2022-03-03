module Admin::ProductHelper
  def convert_param_to_date param, subkey
    param && param[subkey]&.to_date
  end
end
