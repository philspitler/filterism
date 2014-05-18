# Filterism

A DSL for filtering items (usually returned from some form of data store).

## Installation

### Bundler
gem 'filterism'

### Other
gem install filterism

## Usage
All examples use the ActiveRecordAdapter which is included with the gem.  Other adapters may be created to meet your needs.  These adapters generate the syntax to speak to whatever data store you need.

### Globally
Adds .filter, .filterable_fields and .unfilterable_fields methods to all of you models
Somewhere in your apps bootstrap/startup code:

``` ruby
ActiveRecord::Base.include(Filterism)
```

### Locally (in a model)
Adds .filter, .filterable_fields and .unfilterable_fields methods to only the User model

``` ruby
class User < ActiveRecord::Base
	include Filterism
end
```

Filterism was developed to fill the need of being able to filter Active Record results by aguments passed in the URL, however, it basically takes in a hash.  Usually that hash would be "params" passed from the controller.  The syntax of the keys in the hash control how the data is filtered.

It also adds a ".filterable_fields" method for you to limit by which fields
the records may be filtered.

## Example
### URL
    http://whatever.com/whatever/?name_is_in=Dave,Jamis,David&salary_is_greater_than=10000

So as you see above, the syntax is [field]\_is\_[comparator]=value.

In the first argument, name is the [field] and [in] is the comparator.

In the second argument, salary is the [field] and [greater_than] is the comparator.

### Model
#### Filterable Fields
In the model you can limit which fields are filterable.  This is optional.  If this isn't in your model, all fields are filterable.

``` ruby
class User < ActiveRecord::Base
  filterable_fields :name
end
```

#### Unfilterable Fields

``` ruby
class User < ActiveRecord::Base
  unfilterable_fields :salary
end
```
The examples above are equivalent.  If you have a long list of fields, you can use either a whitelist or blacklist depending on your needs


### Controller
This gem adds the ".filter" class method to any active record class.  You can pass in any hash, it doesn't have to operate from params.  It will only look at keys that have the "\_is\_" syntax.

``` ruby
parser = Filterism::ParamsParser.new
parsed_params = parser.parse(params)
users = User.filter(parsed_params).all
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

## Contributing

1. Fork it ( https://github.com/[my-github-username]/filterism/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
