class Comic < ActiveRecord::Base
  #attr_accessible :title, :issue, :publisher

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     Comic.create! title: row['Title'], issue: row['Issue'], publisher: row['Publisher']
  #   end
  # end


  def self.import(file)

    require 'csv'

    require 'roo'
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      Comic.create! title: row['Title'], issue: row['Issue'], publisher: row['Publisher']
    end
 end



  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv' then Roo::Csv.new(file.path)
      when '.xls' then Roo::Excel.new(file.path)
      when '.xlsx' then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end



end
