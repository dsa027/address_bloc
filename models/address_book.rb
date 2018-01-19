require_relative '../models/entry'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    index = 0
    entries.each do |entry|
      if (name < entry.name)
        break
      end
      ++index
    end
    entries.insert(index, Entry.new(name, phone_number, email))
  end
end
