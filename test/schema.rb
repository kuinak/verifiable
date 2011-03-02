ActiveRecord::Schema.define :version => 0 do

  create_table "users", :force => true do |t|
    t.integer "id"
  end

  create_table "phone_numbers", :force => true do |t|
    t.integer "id"
  end

  create_table "verifications", :force => true do |t|
    t.integer  "object_id"
    t.string   "object_type"
    t.integer  "verifiable_id"
    t.string   "verifiable_type"
    t.datetime "verified_at"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
