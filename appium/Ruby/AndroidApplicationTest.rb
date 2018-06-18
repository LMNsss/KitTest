# Please add apk file(/appium/apk/RTKdemo.apk) to "Remote testKit web(https://webapp.appkitbox.com) -> Rapid Tester -> Mobile App(Add)" before this test

# gem install selenium-webdriver
# gem install appium_lib
# export RTK_USERNAME=xxxx
# export RTK_PASSWORD=xxxx

require 'rubygems'
require 'test/unit'
require 'selenium-webdriver'
require 'appium_lib'

# get userName, password from Environment variable
RTK_USERNAME = ENV['RTK_USERNAME']
RTK_PASSWORD = ENV['RTK_PASSWORD']
unless RTK_USERNAME && RTK_PASSWORD then
    puts "Environment variable error"
    exit(0)
end


class ContactsAndroidTests < Test::Unit::TestCase
    def setup
        opts = {
            caps: {
              	# get userName, password from Environment variable
                userName: RTK_USERNAME,
                password: RTK_PASSWORD,
                platform: 'ANDROID',
                deviceName: 'Nexus 5',
                platformName: 'Android',
                unicodeKeyboard: 'true',
                resetKeyboard: 'true',
                # set application from RemoteTestKit storage
                # app: 'RTKdemo.apk',
                # set application from HTTP Url
                app: 'https://github.com/remotetestkit/sample-code/raw/master/appium/apk/RTKdemo.apk',
                appPackage: 'com.example.remotetestkit.demo',
                appActivity: 'MainActivity',
            },
            appium_lib: {
              server_url: 'https://gwjp.appkitbox.com/wd/hub',
              wait: 60
            }
        }
        @driver = Appium::Driver.new(opts).start_driver
    end

    def teardown
        @driver.quit()
    end

    def test_google_search
        puts @driver.capabilities['snapshotUrl'])
        @driver.save_screenshot('capture_01.png')

        # get text fields and set text in it
        textfields = @driver.find_elements(:class_name, 'android.widget.EditText')
        textfields[0].send_keys('RTK')
        textfields[1].send_keys('Remote TestKing')
        @driver.save_screenshot('capture_02.png')

        # click Save button
        element = @driver.find_element(:id,'com.example.remotetestkit.demo:id/Save')
        element.click()

        # set text from Login display
        result = @driver.find_element(:id,'com.example.remotetestkit.demo:id/title4')
        puts 'Login Result : ' + result.text
        assert_equal('Password Error', result.text)
        @driver.save_screenshot('capture_03.png')

        # press return key
    		@driver.press_keycode(4)

        # delete and set text to text fields
        textfields[1].clear()
        textfields[1].send_keys('Remote TestKit')
        @driver.save_screenshot('capture_04.png')

        # click Save button
        element.click()

        # get text from Login display
    		result = @driver.find_element(:id,'com.example.remotetestkit.demo:id/title2')
        puts 'Login Result : ' + result.text
        assert_equal('Logged in', result.text)
        @driver.save_screenshot('capture_05.png')
    end
end
