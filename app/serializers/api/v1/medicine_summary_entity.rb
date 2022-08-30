class Api::V1::MedicineSummaryEntity < BaseSummaryEntity
  present_collection true

  expose :medicine_entities, as: :medicines

  private

  def medicine_entities
    @medicine_entities ||= Api::V1::MedicineEntity.represent(pagination_items, options.merge({ batch: true }))
  end
end
