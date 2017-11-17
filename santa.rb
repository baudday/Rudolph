require 'YAML'
require 'twilio-ruby'

class Santa
  attr_reader :message_draft, :list, :matches, :sms_client, :send_sms

  def initialize(send_sms: false)
    # Set to true when ready to send!
    @send_sms = send_sms
  end

  def make_a_list(list)
    data = get_list(list)
    @message_draft = data['message']
    @list = data['participants']
    @matches = {}

    # Make sure you set your Twilio Account SID and Auth Token in config.yml
    @sms_client = Twilio::REST::Client.new(
      config['TWILIO_SID'],
      config['TWILIO_AUTH_TOKEN']
    )
  end

  def check_it_twice
    shuffled_list = list.shuffle
    shuffled_list.each_with_index do |p, i|
      partner_id = i == list.length - 1 ? 0 : i + 1
      matches[id_for(p)] = shuffled_list[partner_id]
    end
  end

  def spread_cheer!
    list.each_with_index do |participant, id|
      name = participant[:first_name]
      partner_name = matches[id][:first_name]
      message = message_draft % { name: name, partner_name: partner_name }

      if send_sms
        sms_client.messages.create(
          from: config['TWILIO_NUMBER'],
          to: participant[:phone],
          body: message
        )
        print "Sent message #{id + 1} of #{list.count}...\r"
        sleep 1
      else
        puts "::TESTING::"
        puts message
      end
    end
  end

  private

  def id_for(participant)
    list.find_index do |p|
      "#{p[:first_name]} #{p[:last_name]}" == "#{participant[:first_name]} #{participant[:last_name]}"
    end
  end

  def get_list(list_name)
    path = File.join(Dir.pwd, "lists/#{list_name}.yml")
    file = File.open(path, 'r')
    data = YAML::load_stream(file)[0]
    file.close
    data
  end

  def config
    file = File.open('config.yml', 'r')
    data = YAML::load_stream(file)[0]
    file.close
    data
  end
end
