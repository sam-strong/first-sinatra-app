class Comment
  include DataMapper::Resource

  property :id, Serial
  property :note, String
  property :name, String
  property :time, DateTime

  belongs_to :contact, :required => false
end