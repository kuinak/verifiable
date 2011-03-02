class VerifiableMigration < ActiveRecord::Migration
  def self.up
    create_table :verifications do |t|
      t.integer :object_id
      t.string :object_type
      t.integer :verifiable_id
      t.string :verifiable_type
      t.datetime :verified_at
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :verifications
  end
end
