RSpec.describe 'line_item' do
  it '#total_price returns the total price of the line item' do
    line_item = create(:line_item)
    expect(line_item.total_price).to eql 50
  end
end

RSpec.describe 'line_item', type: :system do
  include Warden::Test::Helpers
  include ActionView::Helpers::NumberHelper

  let!(:user) { create(:user) }
  let!(:quote) { create(:quote, company: user.company) }
  let!(:line_item_date) { create(:line_item_date, quote:) }
  let!(:line_item) { create(:line_item, line_item_date:) }

  before do
    login_as user
    visit quote_path(quote)
  end

  it 'Creating a new line item', :js do
    expect(page).to have_selector 'h1', text: 'Sample quote'

    within "##{dom_id(line_item_date)}" do
      click_on 'Add item', match: :first
    end
    expect(page).to have_selector 'h1', text: 'Sample quote'

    fill_in 'Name', with: 'Animation'
    fill_in 'Quantity', with: 1
    fill_in 'Unit price', with: 1234
    click_on 'Create item'

    expect(page).to have_selector 'h1', text: 'Sample quote'
    expect(page).to have_text 'Animation'
    expect(page).to have_text number_to_currency(1234)

    expect(page).to have_text number_to_currency(quote.total_price)
  end

  it 'Updating a line item', :js do
    expect(page).to have_selector 'h1', text: 'Sample quote'

    within "##{dom_id(line_item)}" do
      click_on 'Edit'
    end
    expect(page).to have_selector 'h1', text: 'Sample quote'

    fill_in 'Name', with: 'Capybara article'
    fill_in 'Unit price', with: 1234
    click_on 'Update item'

    expect(page).to have_text 'Capybara article'
    expect(page).to have_text number_to_currency(1234)

    expect(page).to have_text number_to_currency(quote.total_price)
  end

  it 'Destroying a line item', :js do
    within "##{dom_id(line_item_date)}" do
      expect(page).to have_text line_item.name
    end

    within "##{dom_id(line_item)}" do
      click_on 'Delete'
    end

    within "##{dom_id(line_item_date)}" do
      expect(page).to have_no_text line_item.name
    end

    expect(page).to have_text number_to_currency(quote.total_price)
  end
end
