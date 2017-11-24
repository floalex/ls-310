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

