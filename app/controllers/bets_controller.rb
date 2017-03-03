class BetsController < ApplicationController
  def new
    @bet = Bet.new
  end
end
