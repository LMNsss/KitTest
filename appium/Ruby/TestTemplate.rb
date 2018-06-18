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


class AppiumTest < Test::Unit::TestCase
    def setup
        opts = {
            caps: {
                userName: RTK_USERNAME,
                password: RTK_PASSWORD,
                platform: 'ANDROID',
                deviceName: 'Nexus 5',
                platformName: 'Android',
                browserName: 'Chrome'
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

    def run_test
        puts @driver.capabilities['snapshotUrl'])
        driver = @driver

        # put the generated appium code here!
        # ------


        # ------

    end
end
