# http://www.zillow.com/howto/api/CalculateAffordability.htm
class Zillow
  BASE_URL = 'http://www.zillow.com/'

  class << self
=begin
  Estimate what you can afford based on your annual income or monthly payment

  Zillow.calculate_affordability(10000, 0, annualincome: 50000)
  =>
{
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
=end
    def calculate_affordability(down, debts, options={})
      return unless down && debts
      return unless options[:annualincome] || options[:monthlypayment]

      conn = Faraday.new(url: BASE_URL)

      params = {
        'zws-id' => ENV['ZILLOW_ZWSID'],
        output: :json,
        down: down,
        monthlydebts: debts,
      }.merge(options)

      response = conn.get '/webservice/mortgage/CalculateAffordability.htm', params

      case response.status
      when 200
        JSON.parse(response.body)['response']
      else
        # TODO: handle the unthinkable
      end
    end

    # estimate what you can afford based on your available downpayment and annual income
    # estimate(10000, 50000)
    # => 340000
    def estimate(down_payment, annual_income, options={})
      hash = self.calculate_affordability(down_payment, 0, annualincome: annual_income)
      rounded = hash['affordabilityAmount'].to_i.round(-4) # round to nearist 10k
      rounded < 10000 ? 10000 : rounded
    end
  end
end
