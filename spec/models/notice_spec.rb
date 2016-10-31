require 'rails_helper'

RSpec.describe Notice, type: :model do

  # notice is a model for use of admins, so no validations / regression testing for this model
  it 'should save a simple notice' do
    Notice.create_notice('sample notice text ', 'https://sample_notice.url')
  end
end
