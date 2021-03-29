# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:blog) { create(:blog, title: 'hoge', body: 'body') }

  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end

    context '表示の確認' do
      it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: admins_blogs_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe "一覧画面のテスト" do
    before do
      visit admins_blogs_path
    end

    context '一覧の表示とリンクの確認' do
      it "blogのタイトルと内容を表示し、詳細のリンクが表示されているか" do
        (1..5).each do |i|
          Blog.create(title: 'hoge' + i.to_s, body: 'body' + i.to_s)
        end
        visit admins_blogs_pathbooks_path
        Blog.all.each_with_index do |blog, i|
          j = i * 3
          expect(page).to have_content blog.title
          expect(page).to have_content blog.body
          # Showリンク
          show_link = find_all('a')[j]
          expect(show_link.native.inner_text).to match(/show/i)
          expect(show_link[:href]).to admins_blog_path(blog)
        end
      end
      it '投稿するボタンが表示される' do
        expect(page).to have_button '投稿する'
      end
    end

    context '投稿処理に関するテスト' do
      it '投稿に失敗する' do
        click_button '投稿する'
        expect(page).to have_content 'error'
        expect(current_path).to eq('admins/blogs')
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'blog[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'blog[body]', with: Faker::Lorem.characters(number: 20)
        click_button '投稿する'
        expect(page).to have_current_path admins_blog_path(Blog.last)
      end
    end

    context 'blog削除のテスト' do
      it 'blogの削除' do
        expect { blog.destroy }.to change(Blog, :count).by(-1)
        # ※本来はダイアログのテストまで行うがココではデータが削除されることだけをテスト
      end
    end
  end

  describe '詳細画面のテスト' do
    before do
      visit admins_blog_path(blog)
    end

    context '表示の確認' do
      it '本のタイトルと感想が画面に表示されていること' do
        expect(page).to have_content blog.title
        expect(page).to have_content blog.body
      end
      it 'Editリンクが表示される' do
        edit_link = find_all('a')[0]
        expect(edit_link.native.inner_text).to match(/edit/i)
      end
    end

    context 'リンクの遷移先の確認' do
      it 'Editの遷移先は編集画面か' do
        edit_link = find_all('a')[0]
        edit_link.click
        expect(current_path).to eq('admins/blogs/' + blog.id.to_s + '/edit')
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_admins_blog_path(blog)
    end

    context '表示の確認' do
      it '編集前のタイトルと感想がフォームに表示(セット)されている' do
        expect(page).to have_field 'book[title]', with: blog.title
        expect(page).to have_field 'book[body]', with: blog.body
      end
      it '変更を保存ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end

    context '更新処理に関するテスト' do
      it '更新に失敗しエラーメッセージが表示されるか' do
        fill_in 'blog[title]', with: ""
        fill_in 'blog[body]', with: ""
        click_button '変更を保存'
        expect(page).to have_content 'error'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'blog[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'blog[body]', with: Faker::Lorem.characters(number: 20)
        click_button '変更を保存'
        expect(page).to have_current_path admins_blog_path(blog)
      end
    end
  end
end
