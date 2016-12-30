class AppConfig
  include Singleton

  def vars
    @vars ||= load_config('config/app_config.yml')
  end

  def get(key)
    return unless key.present?
    vars[key.to_s]
  end

  private

  def load_config(file_path)
    file = Rails.root + file_path
    return unless File.exist?(file)
    YAML.load_file(file)[Rails.env]
  end
end

