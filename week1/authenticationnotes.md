Summary of how authentication is expected to work:

1) If the user it not signed in, all "internal pages" (all pages other than the front landing page, 
   register page and sign in page) should redirect to the front landing page.

2) the /register path should take users to a register page (mock up of this page is also under /ui).
   User can create an account here, which will then redirect them to the sign in page.

3) Once the user is signed in, we will take the user to the home page (the very first page we built).

Rails 4:
1. when you use `has_secure_password` you should do `has_secure_password validations: false`, 
   otherwise it'll assume you also need password validation.

2. Rails 4 introduced a more efficient way of doing the same that you should use instead: 
   `User.find_by(email: params[:email])`. 
   In general, find_by is a better query that is both easier to write and faster to execute, 
   so you should use it instead of where(...).first.