class EquationsController < ApplicationController

  def index
  end

  def auth
    host = 'http://localhost:4567'
    uri  = '/'
    @url = host + uri
    @authorization = Equation.define_authorization(comprise_body, uri)
    respond_to :js
  end

  private

  def equation_params
    params.require(:eq_params).permit(:type, :a, :b, :c)
  end

  def comprise_body
    type = equation_params[:type]
    a    = equation_params[:a]
    b    = equation_params[:b]
    c    = equation_params[:c]
    %Q({"type"=>"#{type}", "a"=>"#{a}", "b"=>"#{b}", "c"=>"#{c}"})
  end
end
