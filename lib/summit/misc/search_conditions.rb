class Summit::Misc::SearchConditions

  def initialize(config, params)
    @params = params
    @condition_terms = []
    @condition_values = []

    config.each do |param_name, value|
      add_condition(param_name, value[0], value[1])
    end
  end

  def to_a
    ary = []
    ary.push @condition_terms.join(' and ') unless @condition_terms.empty?
    return ary + @condition_values
  end

  private

  def add_condition(param_name, where_str, func)
    @condition_terms.push where_str
    @condition_values.push func.call(@params[param_name])
  end

end
