module Spree
  module Admin
    class ImportController < BaseController
    
      def new
      end
    
      def create
        redirect_to new_admin_import_path, notice: Spree::Product.import(params[:file])
      end
  
      def image
        filename = File.basename(params[:image].original_filename, '.*')
        product = Spree::Product.find_by(name: filename.strip.split.map(&:capitalize)*' ')

        @image = Spree::Image.create(attachment: File.open(params[:image].path), :viewable => product.master) if product
      end
    end
  end
end