## Accept payments with custom form
Use Stripe JS to integrate the customer payment form within user interface

Note: Remember to include your payments.js javascript file inside your view template.
Also, make sure you DON'T include it in the application.js file. If you include it 
in both places, that javascript code is going to be executed twice and you'll get strange errors.

You should also create a file config/initializers/assets.rb with the following content 
(assuming your javascript file is called payments.js):
```
Rails.application.config.assets.precompile += ['payments.js']
```
This file will help to make sure that you add the payments.js file in the asset pipeline for 
all environments (dev, test and production), although in the development environment 
it doesn't really compress the assets for you.

Note: If you are using CircleCI at this point, your build may fail and you may need to 
set your stripe key environment variable on the CircleCI server as well, so it'll have access to it. 
(Project Settings -> Environment Variables)