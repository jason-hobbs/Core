require 'test_helper'

class ReplyMailerTest < ActionMailer::TestCase
  test "new_reply" do
    mail = ReplyMailer.new_post
    assert_equal "New reply", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
