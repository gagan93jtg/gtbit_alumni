class Utils

  # Check if params has all the keys
  def self.params_have_all_keys?(params, keys)
    keys.each do |key|
      return false if params.exclude?(key) || params[key].strip.empty?
    end
    return true
  end
end
