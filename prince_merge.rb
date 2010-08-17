require 'rubygems'
require 'bundler'

Bundler.setup

require 'ostruct'
require 'haml'
require 'prince-ruby'
require 'fastercsv'

class Recipient < OpenStruct
  def self.load_from_csv(file)
    recipients = []
    FasterCSV.foreach(file, :headers => true) do |row|
      recipients << new(row.to_hash.delete_if {|k,v| k == nil})
    end
    recipients
  end
end

template = File.read(ARGV[2] || 'standard_envelope.haml')
html     = Haml::Engine.new(template).render(Object.new, :recipients => Recipient.load_from_csv(ARGV[0]))

Prince.new.html_to_file(html, ARGV[1])
