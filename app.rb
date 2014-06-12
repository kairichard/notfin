require 'zq'
require 'znots'
require 'mail'
require 'redis'
require 'logger'
require_relative 'lib/extractor'

CLIENT = Redis.new(db: 1)
LOGGER = Logger.new('app.log', 'daily')

ZnotS.configure do |config|
  config.mail_from = 'test@test.org'
  config.template_path = 'templates/email.html'
  config.accounts_service = FileBackend.new('accounts.db')
end

Mail.defaults do
  delivery_method :smtp, :address => "smtp.gmail.com",
                         :port                 => 587,
                         :user_name            => 'kai.richard.koenig@googlemail.com',
                         :password             => 'r7e747!tgn04r',
                         :authentication       => 'plain',
                         :enable_starttls_auto => true
end

class Notifier
  def compose(raw_data, composite = nil)
    dex = ApiKeyExtractor.new(composite)
    ErrorNotification.new(dex.api_key, composite)
    composite
  end
end

class Source < ZQ::Sources::RedisTransactionalQueue
  def handle_error(item, error)
    LOGGER.error(error)
  end
end

class NotificationPIPE
  include ZQ::Orchestra
  source Source.new(CLIENT, ENV["LIST"])
  compose_with(
    ZQ::Composer::JsonParse.new,
    ZQ::Composer::UUID4Hash.new,
    ZQ::Composer::Tee.new($stdout),
    Notifier.new
  )

  desc "Read transform notify"
end
