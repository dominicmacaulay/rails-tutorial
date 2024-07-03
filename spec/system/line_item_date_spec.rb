require 'rails_helper'

RSpec.describe 'line_item_date' do
  let!(:quote) { create(:quote) }
  let!(:today) { create(:line_item_date, quote:) }
  let!(:next_week) { create(:line_item_date, quote:, date: (Date.current + 1.week)) }
  it "previous_date returns the quote's previous date when it exitsts" do
    expect(next_week.previous_date).to eq today
  end

  it 'previous_date returns nil when the quote has no previous date' do
    expect(today.previous_date).to be nil
  end
end

RSpec.describe 'line_item_date system', type: :system do # rubocop:disable Metrics/BlockLength
  include Warden::Test::Helpers
  include ActionView::Helpers::NumberHelper

  let!(:user) { create(:user) }
  let!(:quote) { create(:quote, company: user.company) }
  let!(:line_item_date) { create(:line_item_date, quote:) }
  before do
    login_as user
    visit quote_path(quote)
  end

  it 'Creating a new line item date', :js do
    expect(page).to have_selector('h1', text: 'Sample quote')

    click_on 'New date'
    expect(page).to have_selector('h1', text: 'Sample quote')
    fill_in 'Date', with: Date.current + 1.day

    click_on 'Create date'
    expect(page).to have_text I18n.l(Date.current + 1.day, format: :long)
  end

  it 'Updating a line item date', :js do
    expect(page).to have_selector 'h1', text: 'Sample quote'

    within id: dom_id(line_item_date, :edit) do
      click_on 'Edit'
    end

    expect(page).to have_selector 'h1', text: 'Sample quote'

    fill_in 'Date', with: Date.current + 1.day
    click_on 'Update date'

    expect(page).to have_text I18n.l(Date.current + 1.day, format: :long)
  end

  it 'Destroying a line item date', :js do
    expect(page).to have_text I18n.l(Date.current, format: :long)

    accept_confirm do
      within id: dom_id(line_item_date, :edit) do
        click_on 'Delete'
      end
    end

    expect(page).to have_no_text I18n.l(Date.current, format: :long)

    expect(page).to have_text number_to_currency(quote.total_price)
  end
end
