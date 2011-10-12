class Summit::Tools::Configuration
  attr_reader :configuration

  def initialize(config_file)
    @configuration = symbolize_keys!(YAML.load(File.new(config_file).read))
    configuration.each_value{|value| value.is_a? Hash and symbolize_keys!(value)}
  end

  def doit(x)
    return x*2
  end

  def method_missing(method, *args)
    # make top-level keys into methods
    return self.configuration[method.to_sym]
  end

  private

  def symbolize_keys!(obj)
    if obj.is_a? Hash
      obj.keys.each do |key|
        symbolize_keys!(obj[key])
        obj[(key.to_sym rescue key) || key] = obj.delete(key)
      end
    elsif obj.is_a? Array
      obj.each{|item| symbolize_keys! item}
    end
    obj
  end
end
