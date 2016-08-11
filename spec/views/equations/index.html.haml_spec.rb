require 'rails_helper'

RSpec.describe 'equations/index.html.haml', type: :view do
  context 'with render templates' do
    it 'type' do
      render
      expect(view).to render_template(partial: 'equations/shared_index/_type')
    end
    it 'params' do
      render
      expect(view).to render_template(partial: 'equations/shared_index/_params')
    end
    it 'result' do
      render
      expect(view).to render_template(partial: 'equations/shared_index/_result')
    end
    it 'authorization params' do
      render
      expect(view)
        .to render_template(partial: 'equations/shared_index/_authorization_params')
    end
  end

  context 'with radio' do
    it 'input' do
      render
      expect(rendered).to have_selector('div#radio') do |div|
        expect(div).to have_selector('input[type=radio]').twice
      end
    end
    it 'label' do
      render
      expect(rendered).to have_selector('div#radio') do |div|
        expect(div).to have_selector('label[text=linear]')
        expect(div).to have_selector('label[text=quadratic]')
      end
    end
  end

  context 'with params input fields' do
    it 'a' do
      render
      expect(rendered).to have_selector('div#a-group') do |div|
        expect(div).to have_selector('input#a[type=radio]')
      end
    end
    it 'b' do
      render
      expect(rendered).to have_selector('div#b-group') do |div|
        expect(div).to have_selector('input#b[type=radio]')
      end
    end
    it 'c' do
      render
      expect(rendered).to have_selector('div#c-group') do |div|
        expect(div).to have_selector('input#c[type=radio]')
      end
    end
  end

  context 'with result displays' do
    it 'equation' do
      render
      expect(rendered).to have_selector('h3#equation') do |h3|
        expect(h3).to have_selector('div#liner_equation')
        expect(h3).to have_selector('div#quadratic_equation')
      end
    end
    it 'progress bar' do
      render
      expect(rendered).to have_selector('div.progress') do |div|
        expect(div).to have_selector('div.progress-bar')
      end
    end
    it 'roots' do
      render
      expect(rendered).to have_selector('h2#result')
    end
    it 'error' do
      render
      expect(rendered).to have_selector('h3#error') do |h3|
        expect(h3).to have_selector('div.alert-danger') do |div|
          expect(div).to have_selector('span#error-message')
        end
      end
    end
  end

  context 'with authorization hidden fields' do
    it 'url' do
      render
      expect(rendered).to have_selector('div#auth') do |div|
        expect(div).to have_selector('input#url[type=hidden]')
      end
    end
    it 'authorization' do
      render
      expect(rendered).to have_selector('div#auth') do |div|
        expect(div).to have_selector('input#authorization[type=hidden]')
      end
    end
  end
end
