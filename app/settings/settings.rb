class Settings < Settingslogic
  source Rails.root.join('config', 'settings', 'settings.yml')
  namespace Rails.env
end
