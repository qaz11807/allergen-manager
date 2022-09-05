# frozen_string_literal: true

class Api::V1::Allergens::BaseController < Api::V1::ApplicationController
  before_action :setup_allergen, only: [:update, :destroy]

  def index
    per_page = params[:per_page] || Allergen::PER_PAGE

    serialize_response(:allergen_summary, current_user.allergens.page(params[:page]).per(per_page))
  end

  def create
    allergen = current_user.allergens.create!(allergen_params)

    serialize_response(:allergen, allergen)
  end

  def update
    @allergen.update!(allergen_params)

    serialize_response(:allergen, @allergen)
  end

  def destroy
    @allergen.destroy!

    success_response(:ok)
  end

  def bulk_destroy
    current_user.allergens.where(id: params[:allergen_ids]).destroy_all

    success_response(:ok)
  end

  private

  def setup_allergen
    @allergen = current_user.allergens.find_by(id: params[:id])
    return error_response(:allergen_not_found) if @allergen.nil?
  end

  def allergen_params
    params.permit(:name)
  end
end
