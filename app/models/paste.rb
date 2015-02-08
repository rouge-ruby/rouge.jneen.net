class Paste < ActiveRecord::Base
  validates_presence_of :language
  validates_presence_of :source

  def to_param
    HASHIDS.encode(id)
  end
end
