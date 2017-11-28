## 1. Three styles of BDD with Rails
- Express the intention first, before the actual implementation
1. Start from mockups: Turn to view templates
2. controller tests
  - controller requires the routes and models for database setup and migration
3. model tests: drive from controller tests
4. feature specs/integration tests

inside-out vs. outside-in
models         integration
controller     controller
integration    models

## 2. HMT and HABTM

Two ways of doing many to many associations with Active Record
- prefer has_many :through

## 3. Self Referential Associations
Self referential associations with Active Record

## 4. Send emails with ActionMailer
Extend the actionmailer class on Rails
  - Create file app/mailers/app_mailer.rb
  
  ```
  class AppMailer < ActionMailer::Base
    def notify_on(user, item)
      @item = item
      mail from: 'example@example.com', to: user.email, subject: "Example subject"
    end
  end
  ```
  - Create the html file for the email template
  - Call the method from app_mailer.rb in controller `AppMailer.notify_on(user, item)`
  - Look at the service console to verify

## 5. Email Configurations
- gem: letter_opener: Can present the email in browser

## 6. Handling Sensitive Account Info
Ways to handle sensitive data: local file yml/figaro gem

## 7. Setting Random Tokens
How to set random tokens to identify resources
- run `rails g migration add_token_to_items`: add the token to the column as string
- Add `to_param` method in the model file: ActiveRecord by default gives "id" in this method, eg: /todos/1
- Generate token before create the item. User `before_create` instead of `before_save` since we only want to generate it once
- In Ruby, there is "SecureRandom" methods so that we can generate random strings: 
  ```
  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
  ```
- Modify the controller method after using token

##8 Reset Password
Hint: One of the difficult parts of this workflow is that when the user clicks on the link and sees the reset password form, 
we have to keep track of the user's identify so then when the server knows whose password to reset. The form itself only 
has a "password" field, so we need to create a hidden field with value set to the token in the URL 
- you can set the @token instance var in the controller that would render the reset password form, and set the hidden 
field's value to that.

There's actually a better way to do this: to have the token column totally empty after user creation, 
create and assign a token to the user as part of the password reset request, and then immediately 
delete the token after the password change has been saved. This way, even if the database is hacked, 
the attacker can't use the reset password functionality to gain someone's access.