class Notice < ActiveRecord::Base

  def self.create_notice(text, url)
    notice = Notice.new(notice_text: text, notice_url: url)
    notice.save!
  end
end
