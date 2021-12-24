require 'sidekiq-scheduler'
require 'json'
# Sidekiq Worker for load users
class ReqresWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2
  def perform
    Timeout.timeout(2.minutes) do
      reqres_routine
    end
  end

  # Load users from reqres.in
  def reqres_routine
    ReqresImporter.new.create_users
  end
end
