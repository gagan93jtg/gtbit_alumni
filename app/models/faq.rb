class Faq < ActiveRecord::Base
  validates :question, length: { maximum: 65535 }
  validates :answer, length: { maximum: 65535 }
end
