require 'active_record'

module Filterism
  attr_accessor :filterable_fields

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
  
  def filter(params)

    #remove non filter params
    params.delete_if { |key, value| key.to_s.index('_is_').nil? }

    where_clause = ""
    values = []

    params.each do |key, value|
      keysplit = key.to_s.split('_is_')
      unless @filterable_fields and not @filterable_fields.include?(keysplit[0].to_sym)

        if COMPARATORS.keys.include?(keysplit[1])
          column = keysplit[0]
          comparator = COMPARATORS[keysplit[1]]

          where_mark = '?'

          if comparator == 'LIKE'
            values << "%#{value}%"
          elsif comparator == 'IN'
            where_mark = '(?)'
            values << value.split(',')
          else
            values << convert_if_string_is_boolean(value)
          end

          where_clause << " AND" unless where_clause.empty?

          where_clause << " #{column} #{comparator} #{where_mark}"
        end
      end

    end

    where(where_clause, *values)
  end

  def filterable_fields(*fields)
    @filterable_fields = fields
  end
  
  private
  def convert_if_string_is_boolean(value)
    if value == "true" || value == "false"
      value = "true" ? true : false
    end
    return value
  end

end

ActiveRecord::Base.extend Filterism
