class Paste < ActiveRecord::Base
  validates_presence_of :language
  validates_presence_of :source
end
