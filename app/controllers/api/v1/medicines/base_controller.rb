# frozen_string_literal: true

class Api::V1::Medicines::BaseController < Api::V1::ApplicationController
  before_action :setup_medicine, only: [:update, :update_image, :destroy]
  before_action :setup_active_storage_url, only: :update_image

  def index
    per_page = params[:per_page] || Medicine::PER_PAGE

    serialize_response(:medicine_summary, current_user.medicines.page(params[:page]).per(per_page))
  end

  def create
    medicine = current_user.medicines.create!(medicine_params)

    serialize_response(:medicine, medicine)
  end

  def update
    @medicine.update!(medicine_params)

    serialize_response(:medicine, @medicine)
  end

  def update_image
    @medicine.update_image(params[:image])

    serialize_response(:medicine, @medicine)
  end

  def destroy
    @medicine.destroy!

    success_response(:ok)
  end

  def bulk_destroy
    current_user.medicines.where(id: params[:medicine_ids]).destroy_all

    success_response(:ok)
  end

  private

  def setup_medicine
    @medicine = current_user.medicines.find_by(id: params[:id])
    return error_response(:medicine_not_found) if @medicine.nil?
  end

  def medicine_params
    params.permit(:name, :manufacture, :description, :expired_at)
  end
end
