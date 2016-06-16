class CitiesController < ApplicationController
  autocomplete :city, :name
end
