# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Blog, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:blog)).to be_valid
    end
  end
	context "空白のバリデーションチェック" do
	  it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      blog = Blog.new(title: '', body:'hoge')
	      expect(blog).to be_invalid
	      expect(blog.errors[:title]).to include("can't be blank")
    end
	    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      blog = Blog.new(title: 'hoge', body:'')
	      expect(blog).to be_invalid
	      expect(blog.errors[:body]).to include("can't be blank")
	  end
  end
end