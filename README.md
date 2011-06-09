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