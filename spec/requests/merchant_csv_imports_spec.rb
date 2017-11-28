require 'rails_helper'
require 'rake'

describe "merchant CSV" do
  it "successfully imports to database" do
    Rake::Task[import].invoke

    expect(Merchant.count).to eq(100)
  end
end