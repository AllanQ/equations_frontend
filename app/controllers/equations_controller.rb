class EquationsController < ApplicationController
  require 'openssl'
  require 'base64'

  def index
  end

  def create
    host = 'http://localhost:4567'
    uri = '/'
    @url = host + uri
    public_key = File.read(Rails.root + 'config/.keys/key.pub').split(' ')[1]
    type = eq_params[:type]
    a = eq_params[:a]
    b = eq_params[:b]
    c = eq_params[:c]
    body = "{\"type\"=>\"#{type}\", \"a\"=>\"#{a}\", \"b\"=>\"#{b}\", \"c\"=>\"#{c}\"}"
    str = ''
    File.readlines(Rails.root + 'config/.keys/key').each do |line|
      str << line if line[0] != '-'
    end
    private_key = str.gsub(/\n/, '')
    computed_signature = Base64.encode64(OpenSSL::HMAC
      .digest(OpenSSL::Digest.new('sha512'), uri + body, private_key))
      .strip.gsub(/\n/, '')
    @authorization = "#{public_key}:#{computed_signature}"
    respond_to :js
  end

  private

  def eq_params
    params.require(:home).permit(:type, :a, :b, :c)
  end
end
