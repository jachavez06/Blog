# Updates the cached list of published tags
class UpdatePublishedTagsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
