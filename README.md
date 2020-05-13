## Installation

Add the folowing line to your Gemfile

```ruby
gem 'stardust_rails-reports'
```


Create reports table in the database

```sh
rake db:migrate
```


#Pass an array of roles that are permitted to manage the hooks
Stardust::Hooks.configure do |config|
  config.manager_roles = []
end

### GraphQL

#### Mutations

Create `stardust_rails_reports.rb` in the `app/graph/mutations` directory.

It should have the following content:

```ruby
load 'stardust_rails/reports/graph/mutations.rb'
```

#### Queries
Create `stardust_rails_reports.rb` in the `app/graph/queries` directory.

It should have the following content:

```ruby
load 'stardust_rails/reports/graph/queries.rb'
```

#### Types

Create `stardust_rails_reports.rb` in the `app/graph/types` directory.

It should have the following content:

```ruby
load 'stardust_rails/reports/graph/types.rb'
```


### Report Authoring

To be written...
