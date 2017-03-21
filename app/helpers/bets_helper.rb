module BetsHelper
  def creator?
    current_user == @bet.creator
  end

  def resolved?
    @bet.active
  end
end
