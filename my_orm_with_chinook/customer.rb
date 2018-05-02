require_relative "./environment.rb"
require 'pry'
require 'active_support/inflector'


class Customer

    def initialize(options={})
        options.each do |key, value|
            if key.class != Fixnum
                self.send("#{key}=", value)
            end
        end
    end
    def self.table_name
        self.to_s
    end

    def self.column_names
        sql = "pragma table_info('#{self.table_name}')"
        db_rows = DB[:conn].execute(sql)
        db_rows.map{|value| value["name"]}
    end
    self.column_names.each do|column_name|
        attr_accessor column_name.to_sym
    end

    def self.new_from_db(id)
        sql = "select * from #{self.table_name} where #{self.column_names[0]} = #{id} LIMIT 1"
        parameter = "#{self.column_names[0]} = #{id}"
        db_rows = DB[:conn].execute(sql)
        cust = self.new(db_rows[0])
    end

    def save
        if new_cus.send("#{self.column_names[0]}")
            sql = "UPDATE "
        end
    end
end


new_cus = Customer.new_from_db(5)
binding.pry
puts ""
