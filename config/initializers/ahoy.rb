class Ahoy::Store < Ahoy::Stores::ActiveRecordTokenStore
  Ahoy.track_visits_immediately = true

  def exclude?
    bot?
  end
end
