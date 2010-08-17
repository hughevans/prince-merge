require 'rubygems'
require 'bundler'

Bundler.setup

require 'haml'
require 'prince-ruby'
require 'fastercsv'

class Recipient
  attr_accessor :name, :address_one, :address_two, :address_three, :city, :state, :postal_code, :country

  def initialize(args)
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil? || v == ''
    end
  end

  def self.load_from_csv(file)
    recipients = []
    FasterCSV.foreach(file, :headers => true) do |row|
      recipients << self.new(
        :name          => row['name'],
        :address_one   => row['address_one'],
        :address_two   => row['address_two'],
        :address_three => row['address_three'],
        :city          => row['city'],
        :state         => row['state'],
        :postal_code   => row['postal_code'],
        :country       => row['country']
      )
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
