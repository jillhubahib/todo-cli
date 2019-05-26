# Create a CLI gem with bundler

## Learning Objective
- Know Rubygems and bundler
- How to create and package a gem
- Know ActiveRecord, a Ruby ORM
- TDD with RSpec and Aruba

## [What is a gem](https://guides.rubygems.org/what-is-a-gem/)?
**RubyGems** is a package manager for the Ruby programming language that provides a standard format for distributing Ruby programs and libraries (in a self-contained format called a "gem"), a tool designed to easily manage the installation of gems, and a server for distributing them.

## [Bundler](https://bundler.io/v2.0/#getting-started)
Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed.

## Todo CLI
Let's create a gem that is a command line interface (CLI) version of a todo list.
### Requirements
- [ ] User can add a todo
- [ ] User can complete a todo
- [ ] User can remove a todo or clear all todos
- [ ] User can show all todos
- [ ] User can import and export a todo from and to a file (assignment)

## [Test Driven Development](https://www.theodinproject.com/courses/ruby-programming/lessons/test-driven-development)
![alt Red green refactor cycle][red-green-refactor]

[red-green-refactor]: http://165.227.208.227/posts/wp-content/uploads/2016/02/image022-1.png

## Dependencies

### Deployment

- [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html)
  - is the M in MVC - the model - which is the layer of the system responsible for representing business data and logic
  - Active Record was described by Martin Fowler in his book Patterns of Enterprise Application Architecture
  - Object Relational Mapping, commonly referred to as its abbreviation ORM, is a technique that connects the rich objects of an application to tables in a relational database management system. Using ORM, the properties and relationships of the objects in an application can be easily stored and retrieved from a database without writing SQL statements directly and with less overall database access code.
- [SQLite](https://github.com/sparklemotion/sqlite3-ruby) - local data storage
- [Standalone Migrations](https://github.com/thuss/standalone-migrations) - A gem to use Rails Database Migrations in non Rails projects

### Development

- [Aruba](https://github.com/cucumber/aruba) - use to test CLI applications
- [Bundler](https://bundler.io/) - manage gems
- [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner) - used to ensure a clean state of database for testing.
- [Cucumber](https://github.com/cucumber/cucumber-ruby) - tool for running automated tests
- [FactoryBot](https://github.com/thoughtbot/factory_bot) - provides a framework and DSL for defining and using factories - less error-prone, more explicit, and all-around easier to work with than fixtures.
- [Faker](https://github.com/stympy/faker) - library for generating fake data such as names, addresses, and phone numbers
- [Rake](https://www.rubyguides.com/2019/02/ruby-rake/) - popular task runner in Ruby.
- [Rspec](https://www.rubyguides.com/2018/07/rspec-tutorial) - test framework

## Data Planning

|Task|
|---|
|name|
|completed_at

## [Code Walkthrough](https://github.com/jillhubahib/todo-cli/commits)

### Scaffold structure
```
├── CODE_OF_CONDUCT.md
├── Gemfile
├── LICENSE.txt
├── README.md
├── Rakefile
├── bin
│   ├── console
│   └── setup
├── lib
│   ├── todo
│   │   └── version.rb
│   └── todo.rb
├── spec
│   ├── spec_helper.rb
│   └── todo_spec.rb
└── todo.gemspec
```

## Try `todo`
```
> bundle exec exe/todo

Usage: todo [options] COMMAND

Commands:
  add TODO        Adds a todo
  delete NUM      Removes a todo
  done NUM        Completes a todo
  clear           Removes all todo
  list [FILTER]   Lists all active todos
```
Why do we need `bundle exec` prepended? It is to make sure that the version specified in the app's Gemfile is used.

## Releasing the gem

To build the gem, run `bundle exec rake build`. This will create a file `pkg/todo-0.1.0.gem` that you may use to share your gem or publish or relase in rubygems.org.

You may install the gem by running command `gem install pkg/todo-0.1.0.gem`.

## Improvement items
- Follow [rubygems pattern](https://guides.rubygems.org/patterns)
  - Name
  - Requiring code
  - Upgrade scenario
- Code documentation
- Continuous Integration
- Code coverage

## Resources

- [Rubygems Guides](https://guides.rubygems.org)
- [How to create a Ruby gem with Bundler](https://bundler.io/v2.0/guides/creating_gem.html)
- [The Ultimate Guide to Ruby Gems, Gemfiles & Bundler](https://www.rubyguides.com/2018/09/ruby-gems-gemfiles-bundler/)