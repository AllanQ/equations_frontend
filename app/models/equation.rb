class Equation < ApplicationRecord
  require 'openssl'
  require 'base64'

  def self.define_authorization(body, uri)
    public_key = read_public_key
    computed_signature = compute_signature(body, uri)
    "#{public_key}:#{computed_signature}"
  end

  private

  def self.read_public_key
    File.read(Rails.root + 'config/.keys/key.pub').split(' ')[1]
  end

  def self.compute_signature(body, uri)
    private_key = read_private_key
    Base64.encode64(OpenSSL::HMAC
      .digest(OpenSSL::Digest.new('sha512'), uri + body, private_key))
      .strip.gsub(/\n/, '')
  end

  def self.read_private_key
    str = ''
    File.readlines(Rails.root + 'config/.keys/key').each do |line|
      str << line if line[0] != '-'
    end
    str.gsub(/\n/, '')
  end
end
