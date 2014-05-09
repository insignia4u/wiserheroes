Teamoti
=======

Dependencies
-------

 - Ruby 2.1.1
 - Bundler 1.5.3
 - Rails 4.1.1
 - MongoDB 2.4.9 or higher

Quick start
-------

If you satisfy all the dependencies you can clone the repository via git:

```
$ git clone git@github.com:insignia4u/wiserheroes.git
```

And then go to your project folder and run:

```
$ bundle install
```

You also have to set up all environment variables and config your database settings, you can do it creating the following files (we have created sample files inside config folder as an example):

```
kickshouter/
└── config/
    ├── mongoid.yml       -> Default connection to MongoDB.
    └── application.yml   -> Environment variables here
```

Populate the database:

```
$ rake db:seed
```

This application uses Figaro for setting up configuration environment variables. You should create an application.yml file under config/, following the structure described on config/application.sample.yml

Now you can start the server with puma in any port that you like; for instance, port 3000 :

```
$ rails s
```

Then point your browser to **http://localhost:3000**, and start using the app!

This application is using [Mailcatcher][6] for dispaching emails on development. Be sure, you've launched this service before running the server.

Install Dependencies
-------
- **Ruby & Rails**

    If you don't have Ruby or Rails, I recommend you to use [rvm][1] to manage your Ruby versions and gems; you can follow instructions based on your operating system [here][2].


Coding Style
------
 - Use two spaces for indentation, not tabs.
 - Avoid trailing spaces.
 - Be sure all your specs are passing before pushing any commits to origin.

Testing
-------

We are using Capybara and Rspec for tests, both works out of the box once you run the bundle command. There is only one thing to consider: test files are under the `spec/` directory.

It's worth to mention that all features must provide a feature spec and model specs, all at green state.

This application is set up to skip the generation of controller specs, assets and helpers.

You can populate the database with sample users and companies by running:

```
$ rake db:populate
```

Contributing
-------

If you are going to contribute, clone the repo and make a pull request.



[1]: https://rvm.io/rvm/install
[2]: http://railsapps.github.io/installing-rails.html
[4]: https://github.com/thoughtbot/paperclip
[5]: https://gist.github.com/isaacs/579814
[6]: http://mailcatcher.me/
