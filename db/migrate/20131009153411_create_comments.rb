# encoding: utf-8
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', comment: '博客评论表' do |t|
      t.text :content,    limit: 160,                               comment: "评论内容"
      t.integer :blog_id,             null: false,  default: 0,     comment: "博客ID"
      t.integer :user_id,             null: false,  default: 0,     comment: "用户ID"
      t.integer :pid,                                               comment: "回复的评论ID"
      t.boolean :publish_status,      null: false,  default: true,  comment: "发布状态"
      t.timestamps
    end
    add_index :comments,  :user_id
  end
end
