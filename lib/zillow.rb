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

      conn = Faraday.new(url: BASE_URL) do |x|
        x.request  :url_encoded             # form-encode POST params
        x.response :logger                  # log requests to STDOUT
        x.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end

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
  end
end
