class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
      t.string :name
      t.datetime :term_from
      t.datetime :term_to

      t.timestamps
    end
  end
  
  def self.down 
	drop_table :terms
  end
end
