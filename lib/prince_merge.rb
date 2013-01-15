require 'rubygems'

require 'ostruct'
require 'haml'
require 'prince-ruby'
require 'csv'

class PrinceMerge
  attr_accessor :input, :output, :template

  def initialize(input, output, template = nil)
    @input = input
    @output = output
    @template = File.expand_path(File.dirname(__FILE__) + "/../templates/#{template || 'standard_envelope.haml'}")
  end

  def template
    File.read(@template)
  end

  def html
    Haml::Engine.new(template).render(Object.new, :recipients => Recipient.load_from_csv(input))
  end

  def render
    Prince.new.html_to_file(html, output)
  end

  class Recipient < OpenStruct
    def self.load_from_csv(file)
      recipients = []
      CSV.foreach(file, :headers => true) do |row|
        recipients << new(row.to_hash.delete_if {|k,v| k == nil})
      end
      recipients
    end
  end
end