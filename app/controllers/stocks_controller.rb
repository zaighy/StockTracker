class StocksController < ApplicationController

  def search

    if StocksHelper::empty_string params[:stock]
      @stock = Stock.new_from_lookup(params[:stock])

      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
        else
        flash[:danger] = "Incorrent Symbol for Stock"
        redirect_to portfolio_path
      end

    else
      flash[:danger] = "Entered Empty Search String"
      redirect_to portfolio_path
    end

  end

end
