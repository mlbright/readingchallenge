module BooksHelper
  def safe_book_url(url)
    return nil if url.blank?

    # The URL is already validated by the model, but we sanitize for extra safety
    uri = URI.parse(url)
    return nil unless %w[http https].include?(uri.scheme)

    url
  rescue URI::InvalidURIError
    nil
  end
end
