## How to deal with bugs, wrap bugs with tests, and use debugger to find solutions.
  - use `binding_pry`

## How to respond to feature changes with tests
 - think about the edge cases:
  * In ToDo app, we use "at" to add location tags
  * For "good at swimming", as this is part of the phrase we shouldn't add the location tags
    - user uppercase "AT" for parsing out location

## "mass update" in Rails
  - have to manually construct the params to post the controller action, and in the action we need to 
    iterate through this list of QueueItems to update them
  - also have to wrap this inside of a transaction so that if update of any QueueItem fails, we need to 
    roll back the entire operation and prompt the user with an error message.
  - "Parameter Naming Conventions" part of the Rails guide here: 
    http://guides.rubyonrails.org/form_helpers.html#understanding-parameter-naming-conventions
    Use that as the starting point to construct the params that hit the server.

  - `queue_items[][position]` => Parameters: "queue_items"=>[{"position"=>"1"}]

## Use high level thinking when you write tests
  - think about the context, e.g. valid/invalid data, user status, etc.

## Rails transaction
  - If one of the items does not pass the validation and can not be saved, we should use transaction method
    * Need to rollback the database altogether even the previous ones have been saved 
  - a protective wrapper around SQL statements to ensure changes to the database only occur when all actions succeed together
  - Transactions reset the state of records through a process called a rollback. In Rails, rollbacks are only triggered by an exception. 

## Skinny Controller, Fat Model is one of the most popular Rails architectural guidelines.

## Examples of fat controllers in some popular open source projects.

## Use macros to make the tests more readable and less duplication
  - Need to uncomment the `spec_rb` line in rails_help.rb

## Capybara gem: Feature tests
  - syntax closers to business levels 
  - Racktest: simulate browser experience 
  - OK to take baby steps to write the feature tests
  - 4 phased tests in a single level abstraction, example:
  ```
  scenario "updates todo as completed" do
    # setup
    sign_in
    create_todo "Buy milk"

    # exercise
    mark_complete "Buy milk"

    # verify
    expect(page).to have_completed_todo "Buy milk"
    
    # teardown not needed
  end

  def create_todo(name)
    click_on "Add new todo"
    fill_in "Name", with: name
    click_on "Submit"
  end

  def mark_complete(name)
    find(".todos li", text: name).click_on "Mark complete"
  end

  def have_completed_todo(name)
    have_css(".todos li.completed", text: name)
  end
  ```


## Launchy gem for debugging
  - `save_and_open_page` => save the page in a temporary directory and we can open it in browser
  