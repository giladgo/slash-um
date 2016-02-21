require './lib/utils'

class Restaurant < ActiveRecord::Base
  has_many :declarations

  scope :in_team, ->(team) { where(team_id: team) }

  def self.by_input(input)
		puts "#{Utils.emoji?(input)} #{self.by_emoji(input).name} #{self.by_name(input).name}"
    Utils.emoji?(input) ? self.by_emoji(input) : self.by_name(input)
  end

  def self.by_name(input)
    self.where('lower(name) = ?', input.downcase).first_or_create(name: input.downcase)
  end

  def self.by_emoji(emoji)
    self.first_or_create(emoji: emoji, name: Utils.unemojify(emoji))
  end

  def init_declaration(user_id, user_name, channel_id)
    declarations.for_today.create_with(user_name: user_name).find_or_initialize_by(
      user_id:    user_id,
      channel_id: channel_id,
      team_id:    self.team_id
    )
  end

  def display_name
    title_name = self.name.present? ? self.name.titleize : ''
    self.emoji.present? ? "#{self.emoji} #{title_name}" : title_name
  end

end
