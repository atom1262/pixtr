class LikeActivity < Activity

  def email
    subject.user.email
  end

  def likeable
    subject.likeable
  end

  def likeable_name
    likeable.name
  end
end