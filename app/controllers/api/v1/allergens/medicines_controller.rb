# frozen_string_literal: true

class Api::V1::Allergens::MedicinesController < Api::V1::ApplicationController
  before_action :setup_allergen

  def index
    medicines = if params[:linked]
                  @allergen.medicines
                else
                  current_user.medicines.not_in(@allergen.medicines.pluck(:id))
                end
    per_page = params[:per_page] || Medicine::PER_PAGE

    serialize_response(:medicine_summary, medicines.page(params[:page]).per(per_page))
  end

  def add
    @medicines = current_user.medicines.where(id: params[:medicine_ids])
    @allergen.medicines += @medicines
    return error_response(:add_or_remove_error) unless @allergen.save

    success_response(:ok)
  end

  def remove
    @medicines = current_user.medicines.where(id: params[:medicine_ids])
    @allergen.medicines -= @medicines
    return error_response(:add_or_remove_error) unless @allergen.save

    success_response(:ok)
  end

  private

  def setup_allergen
    @allergen = current_user.allergens.find_by(id: params[:allergen_id])
    return error_response(:allergen_not_found) if @allergen.nil?
  end
end
