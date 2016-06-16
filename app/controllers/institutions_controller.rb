class InstitutionsController < ApplicationController
  autocomplete :institution, :name
end
