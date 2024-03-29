# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110919064725) do

  create_table "games", :force => true do |t|
    t.date     "date"
    t.integer  "team1id"
    t.integer  "team2id"
    t.integer  "team1score", :default => 0
    t.integer  "team2score", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "nickname"
    t.string   "number"
    t.integer  "score",      :default => 0
    t.integer  "assist",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players_teams", :id => false, :force => true do |t|
    t.integer  "player_id",  :null => false
    t.integer  "team_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "score",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
