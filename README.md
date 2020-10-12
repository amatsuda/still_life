# still_life

## What's This?

still_life is a testing framework enhancements for test-unit, minitest, RSpec, and Capybara that records all HTML response body texts that are rendered during E2E or unit test executions.


## So What?

You can compare actually rendered HTML results before and after any app updates.


## For What?

By comparing all these HTML files that are processed before and after any kind of code change, you can make sure that you did not (or you did) introduce any new user-facing incompatibilities.
This may greatly help you for example, refactoring your app, replacing external libraries, or upgrading libraries.
My personal use case that made me gemifying still_life was that I wanted to make sure that [my own template engine](https://github.com/amatsuda/himl) renders the same HTML as the one that I was using.

But indeed, the real sweet spot of this tiny library is IMO "Rails upgrade".
In fact, The first original version of this tool was implemented as an RSpec monkeypatch while we were upgrading a huge Rails application from Rails 2 to Rails 3.


## Installation

Bundle `still_life` gem to your Rails app's `:test` environment.

```ruby
gem 'still_life', group: :test
```


## Usage

Run tests with an envvar `STILL_LIFE`. Then still_life creates some HTML files under `tmp/html/#{ENV['STILL_LIFE']}/` directory.
Each .html file is named from the location in your test code where the request was made.

For instance, if you run the tests against a simple scaffold app, the generated files will be like this:

```sh
% STILL_LIFE=rails52 rails test:system test
% tree tmp/html
tmp/html
└── rails52
    └── test
        ├── controllers
        │   ├── users_controller_test.rb-14.html
        │   ├── users_controller_test.rb-20.html
        │   ├── users_controller_test.rb-27.html
        │   ├── users_controller_test.rb-32.html
        │   ├── users_controller_test.rb-37.html
        │   ├── users_controller_test.rb-43.html
        │   └── users_controller_test.rb-9.html
        └── system
            ├── users_test.rb-14.html
            ├── users_test.rb-18.html
            ├── users_test.rb-21.html
            ├── users_test.rb-25.html
            ├── users_test.rb-26.html
            ├── users_test.rb-29.html
            ├── users_test.rb-32.html
            ├── users_test.rb-36.html
            ├── users_test.rb-37.html
            └── users_test.rb-9.html

4 directories, 17 files
```

And each file content is just an HTML.
```html
% cat tmp/html/rails52/test/system/users_test.rb-18.html
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml"><head>
    <title>StillLifeTest</title>
    
    

    <link rel="stylesheet" media="all" href="/assets/application-35729bfbaf9967f119234595ed222f7ab14859f304ab0acc5451afb387f637fa.css" data-turbolinks-track="reload" />
    <script src="/assets/application-3c2e77f06bf9a01c87fc8ca44294f3d3879d89483d83b66a13a89fc07412dd59.js" data-turbolinks-track="reload"></script>
  </head>

  <body>
    <p id="notice">User was successfully created.</p>

<p>
  <strong>Name:</strong>
  MyString
</p>

<a href="/users/980190963/edit">Edit</a> |
<a href="/users">Back</a>

  

</body></html>
```


## Usage Scenario

Consider you have a well-tested Rails 5.2 app, and you want to upgrade its Rails version to 6.0 without introducing any user-facing incompatibilities.
Then the workflow will be as follows:

### 1. Draw a still_life with the 5.2 app

```sh
% STILL_LIFE=rails52 rails test:system test
```

### 2. Do the upgrade job

```sh
% bundle u
% rails app:update
```
and push some more commits...

### 3. Draw another still_life with the 6.0 app

```sh
% STILL_LIFE=rails60 rails test:system test
```

### 4. Compare the results, and make sure there's no unexpected diffs

```sh
% git diff --no-index --color-words tmp/html/rails52/ tmp/html/rails60/
```


## Notes
### git diff
As written in the above example, `git diff --no-index --color-words` should perfectly work for recursively comparing two output directories.

### Random Values

If your response includes some kind of random values, the test results may change between each test runs.
In such case, maybe you could specify a random seed, or mock the random source in your app.


## TODOs / Known Issues
- The Capybara monkeypatch sometimes fails to get the `page.body` due to Capybara timing problem
- Support older versions of Rails, Capybara, and Ruby
- Fix the CI with RSpec + headless Chrome


## Contributing

Pull requests are welcome on GitHub at https://github.com/amatsuda/still_life.


## Credit

The original idea of this library was implemented as a 10 LOC anonymous module by [@hotchpotch](https://github.com/hotchpotch) at Cookpad Inc. back in 2011 as written in [this slide](https://speakerdeck.com/a_matsuda/the-recipe-for-the-worlds-largest-rails-monolith?slide=129).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
