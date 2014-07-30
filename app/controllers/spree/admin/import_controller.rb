module Spree
  module Admin
    class ImportController < BaseController
    
      def new
      end
    
      def create
        Spree::Product.import(params[:file])
        flash[:success] = "Products imported."
        redirect_to admin_url
      end
  
      def image
        filename = File.basename(params[:image].original_filename, '.*')
        product = Spree::Product.find_by(name: filename)

        @image = Spree::Image.create(attachment: File.open(params[:image].path), :viewable => product.master) if product
      end
    end
  end
end