class SlashUmServer

  def ungo(rest, params)
    decl = Restaurant.in_team(params['team_id']).by_input(rest).declaration_for_user(params['user_id'], params['channel_id'])

    if decl.present?
      decl.destroy
      set_pinned_message(params['team_id'], params['channel_id'])
      respond "You don't want to got to #{decl.restaurant.display_name}."
    else
      respond "You can ungo to a place you didn't delcare for"
    end
  end

end