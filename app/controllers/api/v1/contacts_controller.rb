# frozen_string_literal: true

class Api::V1::ContactsController < Api::V1::ApplicationController
  before_action :setup_contact, only: [:update, :destroy]

  def index
    per_page = params[:per_page] || Contact::PER_PAGE

    serialize_response(
      :contact_summary,
      current_user.contacts.by_order.page(params[:page]).per(per_page)
    )
  end

  def create
    contact = current_user.contacts.create!(contact_params)

    serialize_response(:contact, contact)
  end

  def update
    @contact.update!(contact_params)

    serialize_response(:contact, @contact)
  end

  def update_orders
    current_user.contacts.update_orders(params[:contact_ids])

    serialize_response(:contact, @contact)
  end

  def destroy
    @contact.destroy!

    success_response(:ok)
  end

  def bulk_destroy
    current_user.contacts.where(id: params[:contact_ids]).destroy_all

    success_response(:ok)
  end

  private

  def setup_contact
    @contact = current_user.contacts.find_by(id: params[:id])
    return error_response(:contact_not_found) if @contact.nil?
  end

  def contact_params
    params.permit(:name, :phone, :description)
  end
end
