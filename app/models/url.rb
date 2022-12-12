class Url < ApplicationRecord
    validates_presence_of :input_url
    validates_uniqueness_of :input_url
end
