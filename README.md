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

So as you see above, the syntax is [field]_is_[comparator]=value

### Controller
This gem adds the ".filter" class method to any active record class.  You can pass in any hash, it doesn't have to operate from params.  It will only look at keys that have the "\_is\_" syntax.

``` ruby
users = User.filter(params).all
```

## Comparators
The current list of comparators are as follows. (taken right from the code)

``` ruby
COMPARATORS = {
    'equal_to' => '=',
    'not_equal_to' => '!=',

    'greater_than' => '>',
    'gt' => '>',
    'after' => '>',
    'greater_than_or_equal_to' => '>=',
    'gtet' => '>=',

    'less_than' => '<',
    'lt' => '<',
    'before' => '<',
    'less_than_or_equal_to' => '<=',
    'ltet' => '<=',

    'like' => 'LIKE',

    'in' => 'IN'
  }
```

You can see that you can do things like [field]_is_gt=4000 or [field]_is_in=4,66,19

Please see https://github.com/philspitler/filterism/blob/master/spec/filterism_spec.rb for more examples of using ".filter"