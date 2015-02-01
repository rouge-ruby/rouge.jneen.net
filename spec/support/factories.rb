FactoryGirl.define do
  factory :paste do
    language :ruby
    source <<-RUBY
def greet(message)
  puts message
end
RUBY
  end
end
