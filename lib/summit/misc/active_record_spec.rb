module Summit::Misc::ActiveRecordSpec
  # methods for ActiveRecord validation
  def validate_timestamps_protected(obj, timestamps=[:created_at, :updated_at])
    timestamps.each do |field|
      validate_attr_protected obj, field, Time.now
    end
  end

  def validate_attr_accessible(obj, field, value)
    # verify original value is not equal to new value
    orig_value = obj.send field
    orig_value.should_not eql(value), "Value of #{field} must be set to a value other than '#{value}' before the test of attr_protected."

    obj.attributes = { field => value }
    obj.send("#{field}").should eql(value), "Value of #{field} should have changed with mass assignment but did not."
  end

  def validate_attr_protected(obj, field, value)
    # verify original value is not equal to new value
    orig_value = obj.send field
    orig_value.should_not eql(value), "Value of #{field} must be set to a value other than '#{value}' before the test of attr_protected."

    obj.attributes = { field => value }
    obj.send("#{field}").should eql(orig_value), "Value of #{field} should not have changed with mass assignment."
  end

  def validate_exclusion_of(obj, field, value, params={})
    params[:in].each do |invalid_value|
      obj.send "#{field}=", nil
      obj.valid?
      obj.errors[field.to_sym].length.should be > 0, "#{field} = #{invalid_value} should not be valid but is."
    end

    obj.send "#{field}=", value
    obj.valid?
    obj.errors[field.to_sym].length.should be(0), "#{field} = #{value} should be valid but is not."
  end

  def validate_uniqueness_of(obj, field, value, params={})
    lower_value = value.downcase
    upper_value = value.upcase

    obj.send "#{field}=", lower_value
    obj.valid?
    obj.errors[field.to_sym].length.should be(0), "#{field} = #{lower_value} should be valid but is not."

    existing_obj = obj.class.new
    existing_obj.initialize_dup obj
    existing_obj.send("#{field}=", lower_value)
    existing_obj.save :validate => false

    obj.send "#{field}=", lower_value
    obj.valid?
    obj.errors[field.to_sym].length.should be > 0, "#{field} = #{lower_value} should not be valid but is."

    if params[:case_sensitive] == false
      obj.send "#{field}=", upper_value
      obj.valid?
      obj.errors[field.to_sym].length.should be > 0, "#{field} = #{upper_value} should not be valid but is."
    end

  end

  def validate_presence_of(obj, field, value, params={})
    def test_presence_of(the_obj, field, value)
      the_obj.send "#{field}=", nil
      the_obj.valid?
      # the object might set the field in a callback
      if the_obj.send(field).nil?
        the_obj.errors[field.to_sym].length.should be > 0, "#{field} = nil should not be valid but is."
      end

      the_obj.send "#{field}=", value
      the_obj.valid?
      the_obj.errors[field.to_sym].length.should be(0), "#{field} = #{value} should be valid but is not."
    end

    # validate on create
    if params.has_key?(:on) == false or [:save, :create].include?(params[:on])
      new_obj = obj
      unless (obj.new_record?)
        new_obj = obj.class.new
        new_obj.initialize_dup(obj)
      end
      test_presence_of(new_obj, field, value)
    end

    # validate on save
    if params.has_key?(:on) == false or [:save, :update].include?(params[:on])
      existing_obj = obj
      if obj.new_record?
        existing_obj = obj.class.new
        existing_obj.initialize_dup(obj)
        existing_obj.send "#{field}=", value
        existing_obj.save! :validate => false
      end
      test_presence_of(existing_obj, field, value)
    end
  end

  def validate_length_of(obj, field, params={})
    params.each do |key, value|
      if key == :maximum
        # set field to max length, should be OK
        obj.send "#{field}=", 'x'*value
        obj.valid?
        obj.errors[field.to_sym].length.should be(0), "#{field} length #{value} should be valid but is not."

        # set field to 1 more than max length, should be an error
        obj.send "#{field}=", 'x'*(value+1)
        obj.valid?
        obj.errors[field.to_sym].length.should be > 0, "#{field} length #{value + 1} should not be valid but is."
      elsif key == :minimum
        # set field to min length, should be OK
        obj.send "#{field}=", 'x'*value
        obj.valid?
        obj.errors[field.to_sym].length.should be(0), "#{field} length #{value} should be valid but is not."

        # set field to 1 less than max length, should be an error
        obj.send "#{field}=", 'x'*(value-1)
        obj.valid?
        obj.errors[field.to_sym].length.should be > 0, "#{field} length #{value - 1} should not be valid but is."
      elsif key == :allow_nil
        obj.send "#{field}=", nil
        obj.valid?
        if value
          obj.errors[field.to_sym].length.should be == 0, "#{field} = nil should be valid but is not."
        else
          obj.errors[field.to_sym].length.should be > 0, "#{field} = nil should not be valid but is."
        end
      else
        key.should_not eql(key), "Unknown parameter: #{key}"
      end
    end
  end
end
