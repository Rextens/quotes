class QuotesController < ApplicationController
  def index
    @quotes = Quote.new
  end

  def create
    if  Quote.maximum("quoteindex") != nil
      @quotes = Quote.new(title: quote_params[:title], quoteindex: Quote.maximum("quoteindex") + 1)
    else
      @quotes = Quote.new(title: quote_params[:title], quoteindex: 0)
    end

    if @quotes.save
      redirect_to index
    else
      render :index
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:title)
  end
end
