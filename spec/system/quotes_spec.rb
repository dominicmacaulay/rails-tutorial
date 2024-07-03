# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quotes', type: :system do # rubocop:disable Metrics/BlockLength
  include Warden::Test::Helpers

  describe 'visits the quotes site' do # rubocop:disable Metrics/BlockLength
    let!(:user) { create(:user, company: create(:company, :kpmg)) }
    let!(:quote) { create(:quote, company: user.company) }
    before do
      login_as user
    end

    it 'creates a new quote', :js do
      visit quotes_path
      expect(page).to have_selector('h1', text: 'Quotes')

      click_on 'New quote'
      fill_in 'Name', with: 'Capybara quote'
      expect(page).to have_selector('h1', text: 'Quotes')
      click_on 'Create quote'

      expect(page).to have_selector('h1', text: 'Quotes')
      expect(page).to have_content('Capybara quote')
    end

    it 'shows a quote' do
      visit quotes_path
      click_on quote.name

      expect(page).to have_selector('h1', text: quote.name)
    end

    it 'Updating a quote', :js do
      visit quotes_path
      expect(page).to have_selector('h1', text: 'Quotes')

      click_on 'Edit', match: :first
      fill_in 'Name', with: 'Updated quote'
      expect(page).to have_selector('h1', text: 'Quotes')
      click_on 'Update quote'

      expect(page).to have_selector('h1', text: 'Quotes')
      expect(page).to have_content('Updated quote')
    end

    it 'Destroying a quote' do
      visit quotes_path
      expect(page).to have_content(quote.name)

      click_on 'Delete', match: :first
      expect(page).not_to have_content(quote.name)
    end
  end
end
