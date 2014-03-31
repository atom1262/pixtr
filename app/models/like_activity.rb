class LikeActivity < Activity

  def email
    actor.email
  end

  def likeable
    target
  end

  def likeable_name
    likeable.name
  end
end