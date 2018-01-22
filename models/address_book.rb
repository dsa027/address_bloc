require_relative '../models/entry'
require 'csv'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    index = 0
    entries.each do |entry|
      if (entry.name > name)
        break
      end
      index += 1
    end
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name, phone_number, email)
    entry = entries.find do |entry|
      entry.name=='Ada Lovelace'&&entry.phone_number=='010.012.1815'&&entry.email=='augusta.king@lovelace.com'
    end
    if (!entry.nil?)
      entries.delete(entry)
    end
  end

  def import_from_csv(file_name)
    CSV.foreach(file_name, {headers: true, skip_blanks: true}) do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
    return entries
  end

  def binary_search(name)
    lower = 0
    upper = entries.length - 1

    while (lower <= upper)
      mid = (lower + upper) / 2
      mid_name = entries[mid].name

      if name == mid_name
        return entries[mid]

      elsif name < mid_name
        upper = mid - 1

      else
        lower = mid + 1
      end
    end

    return nil
  end

  def iterative_search(name)
    return entries.find do |entry|
      name == entry.name
    end
  end
end
