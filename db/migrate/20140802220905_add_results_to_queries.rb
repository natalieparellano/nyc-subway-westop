class AddResultsToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :results, :text
  end
end
