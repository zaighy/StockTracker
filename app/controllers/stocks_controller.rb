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

  def refresh_prices
    @user_stocks = current_user.stocks
    if @user_stocks.size > 0
      @user_stocks.each do |user_stock|
        current_ticker = user_stock.ticker
        stock = Stock.new_from_lookup(current_ticker)
        latest_price = stock.last_price
        if user_stock.last_price != latest_price
          user_stock.update(last_price: latest_price)
        end
      end
      flash[:success] = "Refresh Successful!"
    else
      flash[:notice] = "No item in the Stock Tracking List"
    end
    redirect_to portfolio_path
  end

end
