class ImageSearcher

  def initialize(search_params)
    @query = search_params[:query]
    @search_params = search_params
  end

  def images
  Image.where("name ILIKE :query OR description ILIKE :query OR id IN (:image_ids)", query: "%#{@query}%", image_ids: image_ids_from_tags)
  end

  private
  attr_reader :search_params, :query

  def image_ids_from_tags
    Tagging.where(tag_id: tags).pluck(:image_id)
  end

  def tags
    tag_searcher.tags
  end

  def tag_searcher
    TagSearcher.new(search_params)
  end
end
