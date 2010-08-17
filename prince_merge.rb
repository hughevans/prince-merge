require 'rubygems'
require 'bundler'

Bundler.setup

require 'haml'
require 'prince-ruby'
require 'fastercsv'

class Recipient
  @@attributes = %w{
    name
    address_one
    address_two
    address_three
    city
    state
    postal_code
    country
  }

  attr_accessor *@@attributes

  def self.load_from_csv(file)
    recipients = []
    FasterCSV.foreach(file, :headers => true) do |row|
      recipient = self.new
      @@attributes.each {|attr| recipient.send("#{attr}=", row[attr])}
      recipients << recipient
    end
    recipients
  end
end

csv         = ARGV[0]
pdf         = ARGV[1]
recipients  = Recipient.load_from_csv(csv)
prince      = Prince.new
template    = File.read(ARGV[2] || 'standard_envelope.haml')
haml_engine = Haml::Engine.new(template)
html        = haml_engine.render(Object.new, :recipients => recipients)

prince.html_to_file(html, pdf)
