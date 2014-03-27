# encoding: utf-8
class CreateLabs < ActiveRecord::Migration
  def up
    create_table :labs do |t|
      t.string :name
      t.string :name_ja
      t.integer :room_number
    end

    Lab.create name: "ahara", name_ja: "阿原"
    Lab.create name: "arakawa", name_ja: "荒川"
    Lab.create name: "igarasi", name_ja: "五十嵐"
    Lab.create name: "kikuchi", name_ja: "菊池"
    Lab.create name: "kobayasi", name_ja: "小林"
    Lab.create name: "komatsu", name_ja: "小松"
    Lab.create name: "saitou", name_ja: "斉藤"
    Lab.create name: "sagayama", name_ja: "嵯峨山"
    Lab.create name: "suzuki", name_ja: "鈴木"
    Lab.create name: "nakamura", name_ja: "中村"
    Lab.create name: "fukuchi", name_ja: "福地"
    Lab.create name: "miyasita", name_ja: "宮下"
    Lab.create name: "watanabe", name_ja: "渡邊"
  end

  def down
    drop_table :labs
  end
end
