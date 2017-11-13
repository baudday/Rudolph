# Rudolph's Secret Santa Match-O-Matic 5000
This year, let Rudolph and his Ruby red nose (and a little bit of coding) help make your Secret Santa gift exchange a breeze!

## Installation
1. Run `bundle install`
2. Update `config.yml` with your [Twilio](https://twilio.com) credentials
3. Move `lists/nice.yml.example` to `lists/nice.yml`
4. Run `ruby rudolph.rb`

## Make a List
You can create as many lists as you'd like in the `lists` directory, using
[`nice.yml.example`](https://github.com/baudday/Rudolph/blob/master/lists/nice.yml.example) as a template. Lists must contain the
following:
1. `message` - The message being sent to your recipients.
    - This must have `%{name}` and `%{partner_name}` fields somewhere in the string. You can also specify a gifting limit here.
2. `participants` - The participants array.
    - A participant must at least have `first_name`, `last_name`, and `phone` fields.
    
## Check it Twice
When you've made your list, you can do a trial run and make sure everything looks good.
1. Modify [`rudolph.rb`](https://github.com/baudday/Rudolph/blob/master/rudolph.rb#L4) to tell Santa which list to check.
2. Run `ruby rudolph.rb`

## Spread Cheer!
Once you're sure everything looks good and you're ready to send out your messages, you can modify
[`rudolph.rb`](https://github.com/baudday/Rudolph/blob/master/rudolph.rb#L3) and set the `send_sms` flag. This will tell Santa to use
your Twilio credentials in `config.yml` to send an SMS to every person on your list with their Secret Santa assignment.

Enjoy!

<img src="https://media.giphy.com/media/l4JyVfrFu1mVAPF3q/giphy.gif" width="200" />

*Contributions are always encouraged!*
