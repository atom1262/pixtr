class GroupMembershipActivity < Activity 

  def email
    actor.email
  end

  def group
    target
  end

  def group_name
    group.name
  end
end