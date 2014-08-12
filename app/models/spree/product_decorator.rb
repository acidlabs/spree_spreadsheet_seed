module Spree
  Product.class_eval do
    def self.import(file)
      column_errors = []
      not_taxonomies = ["name", "description", "price", "deleted", "prototype", "web"]
      
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      
      taxonomies = header.map(&:downcase) - not_taxonomies
      
      (2..spreadsheet.last_row).each do |i|
        begin 
          row = Hash[[header.map(&:downcase), spreadsheet.row(i)].transpose]
          product = find_or_create_by(name: row["name"].strip.split.map(&:capitalize)*' ')
          product.attributes = { description: row["description"] }
        
          #Shipping Category por default
          product.shipping_category_id = 1
        
          #Está disponible
          product.available_on = Time.now
        
          #Precio del producto
          product.price = row["price"]
        
          #Producto aparecerá borrado?
          product.delete if row["deleted"] == 1
          
          product.prototype_id = Spree::Prototype.find_or_create_by(name: row["prototype"].strip.mb_chars.capitalize.to_s).id if row["prototype"]
          
          taxonomies.each do |taxonomy_name|
            unless row[taxonomy_name].blank?
              taxonomy = Spree::Taxonomy.find_or_create_by(name: taxonomy_name.strip.mb_chars.capitalize.to_s)
              row[taxonomy_name].split('/').each do |taxon_name|
                taxon = Spree::Taxon.find_or_create_by name: taxon_name.strip.mb_chars.capitalize.to_s  
                taxon.parent = taxonomy.root unless taxon.parent
                taxon.taxonomy = taxonomy unless taxon.taxonomy
                taxon.save!
                
                product.taxons << taxon unless product.taxons.include? taxon
              end
            end
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