class Utils

  # Check if params has all the keys
  def self.params_have_all_keys?(params, keys)
    keys.each do |key|
      return false if params.exclude?(key) || params[key].strip.empty?
    end
    return true
  end

  def self.sanitize_page_number(page_number)
    if page_number.class == Fixnum
      return page_number
    elsif page_number.class == String
      if page_number.to_i == 0
        return 1
      else
        return page_number.to_i
      end
    end
  end
end
