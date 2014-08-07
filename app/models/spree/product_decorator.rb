module Spree
  Product.class_eval do
    def self.import(file)
      column_errors = []
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        begin 
          row = Hash[[header, spreadsheet.row(i)].transpose]
          product = find_by(name: row["name"]) || new
          product.attributes = { name: row["name"], 
                                  description: row["description"] }
        
          #Shipping Category por default
          product.shipping_category_id = 1
        
          #Está disponible
          product.available_on = Time.now
        
          #Precio del producto
          product.price = row["price"]
        
          #Producto aparecerá borrado?
          product.delete if row["deleted"] == 1
        
          unless row["brand"].blank?
            brand = Spree::Taxon.find_or_create_by name: row["brand"] 
            brand.parent = Spree::Taxon.find_or_create_by name: 'Brand' unless brand.parent
          
            product.taxons << brand unless product.taxons.include? brand
          end
          
          product.save! 
                    
        rescue 
          column_errors << i
        end       
      end
      column_errors
    end
    
    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
      when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
      when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
      end  
    end
  end
end