require 'active_record'

module Filterism
  extend ActiveSupport::Concern

  module ClassMethods
    def filterable_fields(*fields)
      @filterable_fields = fields.to_s
    end
    def unfilterable_fields(*fields)
      @unfilterable_fields = fields.to_s
    end
    def filter(conditions)
      where_clause = ""
      values = []
      where_mark = '?'
      conditions.each do |condition|
        unless (@filterable_fields and not @filterable_fields.include?(condition[:key])) or (@unfilterable_fields and @unfilterable_fields.include?(condition[:key]))
          if condition[:comparator] == 'LIKE'
            values << "%#{condition[:value]}%"
          elsif condition[:comparator] == 'IN'
            where_mark = '(?)'
            values << condition[:value].split(',')
          else
            values << convert_if_string_is_boolean(condition[:value])
          end

          where_clause << " AND" unless where_clause.empty?

          where_clause << " #{condition[:key]} #{condition[:comparator]} #{where_mark}"
        end
      end

      where(where_clause, *values)
    end

    private
    def convert_if_string_is_boolean(value)
      if value == "true" || value == "false"
        value = (value == "true" ? "t" : "f")
      end
      return value
    end
  end
end
