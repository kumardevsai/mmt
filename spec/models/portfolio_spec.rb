require "rails_helper"

describe Portfolio, type: :model do
  let(:portfolio) { create :portfolio }
  let(:user) { portfolio.user }
  let(:next_portfolio) { build :portfolio, user: user }

  it "can only have one live portfolio per user" do
    expect { next_portfolio.save! }.to raise_error ActiveRecord::RecordNotUnique
  end

  it "sets the next_portfolio_at when setting the next_portfolio" do
    expect(portfolio.next_portfolio_at).to be_blank

    portfolio.update(next_portfolio: next_portfolio)

    expect(portfolio.reload.next_portfolio).to eq next_portfolio
    expect(portfolio.next_portfolio_at).to_not be_blank
  end

  describe "#btc_value", mocked_rates: true do
    let(:eth) { create :coin, code: "ETH" }
    let(:btc) { create :coin, code: "BTC" }

    before do
      create :holding, quantity: 10, coin: eth, portfolio: portfolio
      create :holding, quantity: 1, coin: btc, portfolio: portfolio
      portfolio.reload
    end

    it "sums the holdings in BTC" do
      expect(portfolio.btc_value).to eq(10 * @btc_eth_bid + 1)
    end
  end
end
