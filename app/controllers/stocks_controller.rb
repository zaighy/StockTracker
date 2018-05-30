class StocksController < ApplicationController

  def search

    if StocksHelper::empty_string params[:stock]
      flash.now[:danger] = "Entered Empty Search String"
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "Incorrent Symbol for Stock" unless @stock
    end

    respond_to do |format|
      format.js { render partial: 'users/result' }
    end

  end

end
