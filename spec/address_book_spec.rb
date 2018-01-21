require_relative '../models/address_book'

RSpec.describe AddressBook do
  let(:book) { AddressBook.new }

  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eq expected_name
    expect(entry.phone_number).to eq expected_number
    expect(entry.email).to eq expected_email
  end

  context "attributes" do
    it "responds to entries" do
      expect(book).to respond_to(:entries)
    end

    it "initializes entries as an array" do
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries as empty" do
      expect(book.entries.size).to eq(0)
    end
  end

  context "#add_entry" do
    it "adds only one entry to the address book" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]

      expect(new_entry.name).to eq('Ada Lovelace')
      expect(new_entry.phone_number).to eq('010.012.1815')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  context "#remove_entry" do
    it "removes one entry to the address book" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Ada Lovelace2', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Ada Lovelace3', '010.012.1815', 'augusta.king@lovelace.com')
      before = book.entries.length
      book.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      entry = book.entries.find do |entry|
        entry.name=='Ada Lovelace'&&entry.phone_number=='010.012.1815'&&entry.email=='augusta.king@lovelace.com'
      end
      after = book.entries.length
      expect(entry).to eq(nil)
      expect(after).to eq(before == 0 ? 0 : before-1)
      book.entries.clear
    end
  end

  context "#import_from_csv" do
    it "imports the correct number of entries" do
      book.import_from_csv("entries.csv")
      book_size = book.entries.size

      # Check the size of the entries in AddressBook
      expect(book_size).to eq 5
    end

    it "imports the 1st entry" do
      book.import_from_csv("entries.csv")
      entry_one = book.entries[0]
      check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "imports the 2nd entry" do
      book.import_from_csv("entries.csv")
      entry_two = book.entries[1]
      check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "imports the 3rd entry" do
      book.import_from_csv("entries.csv")
      entry_three = book.entries[2]
      check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "imports the 4th entry" do
      book.import_from_csv("entries.csv")
      entry_four = book.entries[3]
      check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "imports the 5th entry" do
      book.import_from_csv("entries.csv")
      entry_five = book.entries[4]
      check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

    it "imports the correct number of entries from second csv" do
      book.import_from_csv("entries2.csv")
      book_size = book.entries.size
      expect(book_size).to eq 7
    end

    it "imports the 3rd entry from second csv" do
      book.import_from_csv("entries2.csv")
      entry_one = book.entries[0]
      check_entry(entry_one, "Abercrombe", "433-343-1212", "aber@gmail.com")
    end

    it "imports the 1st entry from second csv" do
      book.import_from_csv("entries2.csv")
      entry_two = book.entries[1]
      check_entry(entry_two, "Blotto", "123-456-2323", "blotto@bluto.com")
    end

    it "imports the 4th entry from second csv" do
      book.import_from_csv("entries2.csv")
      entry_three = book.entries[2]
      check_entry(entry_three, "Bouchard", "555-555-1212", "Boo@hotmail.com")
    end

    it "imports the 5th entry from second csv" do
      book.import_from_csv("entries2.csv")
      entry_four = book.entries[3]
      check_entry(entry_four, "Dormond", "234-232-2347", "Dormond@workmail.com")
    end

    it "imports the 5th entry from second csv" do
      book.import_from_csv("entries2.csv")
      entry_five = book.entries[4]
      check_entry(entry_five, "Felix", "434-343-5896", "Felix@gmail.com")
    end
    it "imports the 5th entry from second csv" do

      book.import_from_csv("entries2.csv")
      entry_six = book.entries[5]
      check_entry(entry_six, "Francois", "(21)233-34858568", "Frankie@overseas.com")
    end

    it "imports the 2nd entry from second csv" do
      book.import_from_csv("entries2.csv")
      entry_seven = book.entries[6]
      check_entry(entry_seven, "Zelinski", "344-232-2323", "zelinski@yahoo.com")
    end
  end # import from csv

  context "#binary_search" do
    it "binary iterative searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Dan")
      expect(entry).to be_nil
    end

    it "binary iterative searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bill")
      expect(entry).to be_a Entry
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "binary iterative searches AddressBook for Bob" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bob")
      expect(entry).to be_a Entry
      check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "binary iterative searches AddressBook for Joe" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Joe")
      expect(entry).to be_a Entry
      check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "binary iterative searches AddressBook for Sally" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Sally")
      expect(entry).to be_a Entry
      check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "binary iterative searches AddressBook for Sussie" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Sussie")
      expect(entry).to be_a Entry
      check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

    it "binary iterative searches AddressBook for Billy" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Billy")
      expect(entry).to be_nil
    end
  end # binary search

  context "#iterative_search" do
    it "iterative searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Dan")
      expect(entry).to be_nil
    end

    it "iterative searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bill")
      expect(entry).to be_a Entry
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "iterative searches AddressBook for Bob" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bob")
      expect(entry).to be_a Entry
      check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "iterative searches AddressBook for Joe" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Joe")
      expect(entry).to be_a Entry
      check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "iterative searches AddressBook for Sally" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Sally")
      expect(entry).to be_a Entry
      check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "iterative searches AddressBook for Sussie" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Sussie")
      expect(entry).to be_a Entry
      check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

    it "iterative searches AddressBook for Billy" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Billy")
      expect(entry).to be_nil
    end
  end # iterative search

end
