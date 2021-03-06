# frozen_string_literal: true

require "./spec/rails_helper"

describe Members::DashboardController do
  include_examples "with member"

  before { sign_in member }

  describe "#index" do
    let(:get_index) { get :index }

    it "returns a 200" do
      get_index
      expect(response.status).to eq 200
    end

    it "renders the index template" do
      expect(get_index).to render_template :index
    end
  end
end
