require 'open-uri'

class Amazon
  def initialize
    @request = Vacuum.new('GB')
    @request.configure(
      aws_access_key_id: AppConfig.instance.get(:aws_access_key_id),
      aws_secret_access_key: AppConfig.instance.get(:aws_secret_access_key),
      associate_tag: 'tag'
    )
    @retry_time = 0
    @max_retry  = 3
  end

  def import_products(number_of_pages)
    number_of_pages.times do |index|
      page = index + 1
      res = search('*', item_page: page)
      next unless res
      res.each do |item|
        next unless valid_item(item) && !Product.exists?(asin: item.asin)
        p = Product.new(
          asin: item.asin,
          name: item.item_attributes['title'],
          price: item.offer_summary["lowest_new_price"]["amount"],
          description: product_description(item),
          brand: res.first.item_attributes['brand']
        )
        p.image = open(product_image(item)) if product_image(item).present?
        p.save
      end
    end
  end

  def product_description(item)
    return unless item.editorial_review && item.editorial_review["editorial_review"]
    item.editorial_reviews["editorial_review"]["content"]
  end

  def product_image(item)
    if item.large_image
      item.large_image['url']
    elsif item.medium_image
      item.medium_image['url']
    end
  end

  def search(keyword, options={})
    options.reverse_merge!({
      search_index: 'All',
      response_group: 'ItemAttributes,Images,Offers,EditorialReview',
      item_page: 1
    })

    begin
      @response = @request.item_search(
        query: {
          'Keywords' => keyword,
          'SearchIndex' => options[:search_index],
          'ResponseGroup' => options[:response_group],
          'ItemPage' => options[:item_page]
        }
      ).to_h

      items = @response['ItemSearchResponse']['Items']['Item']
      return unless items
      items.map do |item_hash|
        OpenStruct.new(item_hash.deep_transform_keys(&:underscore))
      end
    rescue Excon::Errors::BadRequest => error
      return if check_stop_trying(error.response.body)
      p 'Retrying ....'
      @retry_time += 1
      search(keyword, options)
    end
  end

  private

  def valid_item(item)
    item.asin && item.item_attributes['title']    &&
      item.offer_summary                          &&
      item.offer_summary["lowest_new_price"]
  end

  def check_stop_trying(message)
    return false if @retry_time < @max_retry
    p "Exited - Error: #{message}"
    @retry_time = 0
    return true
  end
end

