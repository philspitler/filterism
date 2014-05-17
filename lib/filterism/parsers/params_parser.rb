module Filterism
  class ParamsParser
    attr_accessor :comparators
    def initialize
      @comparators = {
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
    end

    def parse(params)
      conditions = []
      params.each do |key, value|
        keysplit = key.to_s.split('_is_')
        if @comparators.keys.include?(keysplit[1])
          conditions <<
          {
            key: keysplit[0],
            comparator: @comparators[keysplit[1]],
            value: value
          }
        end
      end
      return conditions
    end

    def add_comparator(comparator)
      @comparators = @comparators.merge(comparator)
    end

    def delete_comparator(comparator_key)
      @comparators.delete(comparator_key)
    end
  end
end
