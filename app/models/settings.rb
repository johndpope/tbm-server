class Settings < Settingslogic
  source "#{Rails.root}/config/app_config.yml"
  namespace Rails.env
end
