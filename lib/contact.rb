class Contact
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :age, Integer
  property :sex, String

  has n, :comment
end