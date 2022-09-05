class Api::V1::ContactSummaryEntity < BaseSummaryEntity
  present_collection true

  expose :contact_entities, as: :contacts

  private

  def contact_entities
    @contact_entities ||= Api::V1::ContactEntity.represent(pagination_items, options.merge({ batch: true }))
  end
end
