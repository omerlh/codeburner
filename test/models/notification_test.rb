#
#The MIT License (MIT)
#
#Copyright (c) 2016, Groupon, Inc.
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.
#
require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test "notifies and destroys itself" do
    assert_difference('Notification.count', -1) do
      notification_email = mock('notification_email')
      notification_email.expects(:deliver_now).returns(true).once
      NotificationMailer.expects(:notification_email).returns(notification_email).once

      notifications(:one).burn = burns(:one).id
      notifications(:one).notify(burns(:one).id, {})
    end
  end

  test "fails and destroys itself" do
    assert_difference('Notification.count', -1) do
      failure_email = mock('failure_email')
      failure_email.expects(:deliver_now).returns(true).once
      NotificationMailer.expects(:failure_email).returns(failure_email).once

      notifications(:one).burn = burns(:one).id
      notifications(:one).fail(burns(:one).id)
    end
  end
end
