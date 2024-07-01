# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quotes', type: :system do # rubocop:disable Metrics/BlockLength
  before do
    driven_by(:rack_test)
  end

  describe 'visits the quotes site' do # rubocop:disable Metrics/BlockLength
    let!(:quote) { create(:quote) }
    # When we visit the Quotes#quotes page
    # we expect to see a title with the text "Quotes"
    it 'creates a new quote' do
      visit quotes_path
      expect(page).to have_selector('h1', text: 'Quotes')

      # When we click on the link with the text "New quote"
      # we expect to land on a page with the title "New quote"
      click_on 'New quote'
      expect(page).to have_selector('h1', text: 'New quote')

      # When we fill in the name input with "Capybara quote"
      # and we click on "Create Quote"
      fill_in 'Name', with: 'Capybara quote'
      click_on 'Create quote'

      # We expect to be back on the page with the title "Quotes"
      # and to see our "Capybara quote" added to the list
      expect(page).to have_selector('h1', text: 'Quotes')
      expect(page).to have_content('Capybara quote')
    end

    it 'shows a quote' do
      visit quotes_path
      click_on quote.name

      expect(page).to have_css('h1', text: quote.name)
    end

    it 'Updating a quote' do
      visit quotes_path
      expect(page).to have_css('h1', text: 'Quotes')

      click_on 'Edit', match: :first
      expect(page).to have_css('h1', text: 'Edit quote')

      fill_in 'Name', with: 'Updated quote'
      click_on 'Update quote'

      expect(page).to have_css('h1', text: 'Quotes')
      expect(page).to have_content('Updated quote')
    end

    it 'Destroying a quote' do
      visit quotes_path
      expect(page).to have_content(quote.name)

      click_on 'Delete', match: :first
      expect(page).not_to have_content quote.name
    end
  end
end
