class AddressesController < ApplicationController
  autocomplete :address, :street

  def autocomplete_address_street
    addresses = Address.where('lower(street) like ?', "%#{params[:term].downcase}%")
    render json: addresses.map(&:street).uniq.sort
  end
end
