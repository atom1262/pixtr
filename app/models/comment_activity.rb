class CommentActivity < Activity 

  def email
    subject.user.email
  end

  def image
    subject.image
  end

  def image_name
    subject.image.name
  end
end