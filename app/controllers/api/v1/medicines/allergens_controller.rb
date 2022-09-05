# frozen_string_literal: true

class Api::V1::Medicines::AllergensController < Api::V1::ApplicationController
  before_action :setup_medicine

  def index
    allergens = if params[:linked]
                  @medicine.allergens
                else
                  current_user.allergens.not_in(@medicine.allergens.pluck(:id))
                end
    per_page = params[:per_page] || Allergen::PER_PAGE

    serialize_response(:allergen_summary, allergens.page(params[:page]).per(per_page))
  end

  def add
    @allergens = current_user.allergens.where(id: params[:allergen_ids])
    @medicine.allergens += @allergens
    return error_response(:add_or_remove_error) unless @medicine.save

    success_response(:ok)
  end

  def remove
    @allergens = current_user.allergens.where(id: params[:allergen_ids])
    @medicine.allergens -= @allergens
    return error_response(:add_or_remove_error) unless @medicine.save

    success_response(:ok)
  end

  private

  def setup_medicine
    @medicine = current_user.medicines.find_by(id: params[:medicine_id])
    return error_response(:medicine_not_found) if @medicine.nil?
  end
end
