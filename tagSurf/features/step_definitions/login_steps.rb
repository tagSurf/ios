Given /^I am on the Welcome Screen$/ do
  element_exists("view")
  element_exists("UIWebView css:'form#new_user'")
  sleep(STEP_PAUSE)
end

Given(/^I enter the credentials "(.*?)" "(.*?)"$/) do |email, password|
  qstr = "webView css:'input#user_email'"

  wait_for{ !query(qstr).empty? }

  touch(qstr)
  wait_for_keyboard
  keyboard_enter_text(email)

  qstr = "webView css:'input#user_password'"

  touch(qstr)
  wait_for_keyboard
  keyboard_enter_text(password)
end

When(/^I press the login button$/) do
  qstr = "webView css:'input#ts-login-btn'"  
  touch(qstr)
end

Then(/^I should see the main page in (\d*) seconds$/) do |timeout|
  sleep(timeout.to_i) #wait 5s for pageload
  qstr = "webView css:'div#nav'"
  screen = query(qstr)

  raise "not logged in" if !screen.any?

end