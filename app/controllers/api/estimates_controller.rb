class Api::EstimatesController < ApplicationController
  def create
    if (@price = Zillow.estimate(params[:downpayment], params[:annualincome]))
      render json: {price: @price}, status: :created
    else
      render json: nil, status: :unprocessable_entity
    end
  end
end
