# Filterism

A DSL for filtering active record results based on hash keys with the
term _is_ in them.

## Installation

### Bundler
gem 'filterism'

### Other
gem install filterism

## Usage
Filterism was developed to fill the need of being able to filter Active Record results by aguments passed in the URL, however, it basically takes in a hash.  Usually that hash would be "params" passed from the controller.  The syntax of the keys in the hash control how the data is filtered.

It also adds a ".filterable_fields" method for you to limit by which fields
the records may be filtered.

## Example
### URL
    http://whatever.com/whatever/?name_is_in=Dave,Jamis,David&salary_is_greater_than=10000

### Controller
This gem adds the ".filter" class method to any active record class.  You can pass in any hash, it doesn't have to operate from params.  It will only look at keys that have the "_is_" syntax.
``` ruby
users = User.filter(params).all
```