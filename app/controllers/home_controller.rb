class HomeController < ApplicationController
  def index
  end

  def estimate
    @price = Zillow.estimate(params[:downpayment], params[:annualincome])
  end
end
