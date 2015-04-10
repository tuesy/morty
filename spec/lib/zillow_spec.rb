require 'rails_helper'

describe Zillow, '.estimate' do
  before do
    @json = {
      "affordabilityAmount"=>"341277",
      "monthlyPrincipalAndInterest"=>"1500",
      "monthlyPropertyTaxes"=>"0",
      "monthlyHazardInsurance"=>"0",
      "monthlyPmi"=>"0",
      "monthlyHoaDues"=>"0",
      "totalMonthlyPayment"=>"1500",
      "totalPayments"=>"540000",
      "totalInterestPayments"=>"208723",
      "totalPrincipal"=>"331277",
      "totalTaxesFeesAndInsurance"=>"0",
      "monthlyIncome"=>"4167",
      "monthlyDebts"=>"0",
      "monthlyIncomeTax"=>"1250",
      "monthlyRemainingBudget"=>"1417"
    }
    allow(Zillow).to receive(:calculate_affordability){@json}
  end

  it "should round the affordability amount" do
    expect(Zillow.estimate(10000, 50000)).to eq(340000)
  end

  it "should handle small affordability amounts" do
    allow(Zillow).to receive(:calculate_affordability){@json.merge('affordabilityAmount' => '15000')}
    expect(Zillow.estimate(10000, 50000)).to eq(20000)
  end

  it "should have a 10k minimum" do
    allow(Zillow).to receive(:calculate_affordability){@json.merge('affordabilityAmount' => '400')}
    expect(Zillow.estimate(10000, 50000)).to eq(10000)
  end
end
