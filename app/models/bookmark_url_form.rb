class BookmarkUrlForm
  include ActiveModel::Model

  def persisted?
    false
  end

  attr_accessor :url
  validate :verify_url_length
  validate :verify_url_format

  def verify_url_length
    if url.nil? or url.empty?
      errors.add :url, "should not be empty"
    end
  end

  def verify_url_format
    unless URI.regexp.match(url)
      errors.add :url, "is invalid format"
    end
  end
end
