class Api::V1::ProfileEntity < BaseEntity
  expose :name, :lang, :birthday, :phone

  private

  def birthday
    object[:birthday].strftime('%F')
  end
end
