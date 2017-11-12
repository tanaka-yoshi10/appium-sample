require 'appium_lib'

describe 'setup' do
  before do
    caps   = { caps:       { platformName: 'Android',
                             deviceName: 'Nexus 7',
                             appActivity: '.StartActivity',
                             appPackage: 'com.twitter.android',
                             unicodeKeyboard:  'true',
    },

               appium_lib: { sauce_username: nil,
                             sauce_access_key: nil } }
    driver = Appium::Driver.new(caps, true)
    Appium.promote_appium_methods self.class
    driver.start_driver.manage.timeouts.implicit_wait = 20 # seconds
  end

  after do
    driver_quit
  end

  it '通知を表示' do
    scroll_to('OK').click
    find_element(:id, 'com.twitter.android:id/notifications').click
    scroll_to('達人').click
    sleep 5
    text = find_element(:id, 'com.twitter.android:id/content_text').text
    expect(text).to include 'ディープラーニング'
  end

  it '中断できること' do
    scroll_to('OK').click
    find_element(:id, 'com.twitter.android:id/composer_write').click
    find_element(:id, 'com.twitter.android:id/tweet_text').send_keys 'プログラミング合宿最高!! #nshgrb'
    driver.save_screenshot('aaa.png')
    sleep 5
    find_element(:id, 'com.twitter.android:id/up_button').click
    scroll_to('削除').click
  end
end
