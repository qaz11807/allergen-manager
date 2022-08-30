# frozen_string_literal: true

# resource controller, define common response and checkers
class Api::V1::ApplicationController < Api::ApplicationController
  # include CheckHelper

  def pagination(records)
    # return records if records.empty?

    page = params[:page] || 1
    per_page = params[:per_page] || 10
    items = records.page(page).per(per_page)
    {
      items: items,
      current_page: items.current_page,
      limit_value: items.limit_value,
      total_page: items.total_pages
    }
  end

  private

  def bulk_params
    params.require(:ids)
    params.permit(ids: [])
  end
end
