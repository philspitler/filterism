require 'active_record'

module Filterism
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

    'like' => 'LIKE'
  }
  
  def filter(params)

    #remove non filter params
    params.delete_if { |key, value| key.to_s.index('_is_').nil? }

    where_clause = ""
    values = []

    params.each do |key, value|
      keysplit = key.to_s.split('_is_')
      column = keysplit[0]
      comparator = COMPARATORS[keysplit[1]]

      where_clause << " AND" unless where_clause.empty?
      where_clause << " #{column} #{comparator} ?"
      if comparator == 'LIKE'
        values << "%#{value}%"
      else
        if value.index(/true|false/)
          values << true if value == "true"
          values << false if value == "false"
        else
          values << value
        end
      end

    end

    where(where_clause, *values)

  end

end

ActiveRecord::Base.extend Filterism
