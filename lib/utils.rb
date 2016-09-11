class Utils

  # Check if params has all the keys
  def self.params_have_all_keys?(params, keys)
    keys.each do |key|
      return false if params.exclude?(key) || params[key].strip.empty?
    end
    return true
  end

  # Make sure page_number is always a number, whether out of range or inside range
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

  # password or random key generator of length 'len'
  def self.key_generator(len)
    return "Invalid param, must be an integer" unless len.class == Fixnum

    random_key = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    random_key_length = random_key.length
    key = ""
    len.times do |i|
      key+= random_key[(rand*100)%random_key_length]
    end
    key
  end
end
