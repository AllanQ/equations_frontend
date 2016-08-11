require 'rails_helper'

RSpec.describe 'layouts/application.html.haml', type: :view do
  it 'render header' do
    render
    expect(view).to render_template(partial: 'layouts/_top_header')
  end

  it 'displays title' do
    render
    expect(rendered)
      .to have_selector('h1', text: 'System for solving mathematical equations')
  end
end
