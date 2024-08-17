# rubocop:disable Layout/LineLength
if !Rails.env.test? && !ENV['REDIS_URL'].nil?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'] }

    # Only setup jobs when the server runs (not every client/web/console session)
    jobs = [
      # Sidekiq::Cron::Job.new(name: 'DataImportJob', cron: '0 * * * *', class: 'DataImportJob'),
    ]
    Sidekiq::Cron::Job.destroy_all!
    jobs.each do |job|
      raise "Job has errors: #{job.errors.join('. ')}" unless job.valid?

      job.save
    end

    config.logger.level = Logger::INFO
  end
end
# rubocop:enable Layout/LineLength