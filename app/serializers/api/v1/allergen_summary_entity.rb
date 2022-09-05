class Api::V1::AllergenSummaryEntity < BaseSummaryEntity
  present_collection true

  expose :allergen_entities, as: :allergens

  private

  def allergen_entities
    @allergen_entities ||= Api::V1::AllergenEntity.represent(pagination_items, options.merge({ batch: true }))
  end
end
