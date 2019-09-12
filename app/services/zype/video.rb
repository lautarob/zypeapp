module Zype
  class Video < Base
    attr_accessor :_id, :created_at, :deleted_at, :updated_at, :on_air, :purchase_price, :purchase_required,
                  :rating, :related_playlist_ids, :rental_duration, :rental_price, :rental_required,
                  :request_count, :site_id, :status, :crunchyroll_id, :hulu_id, :mrss_id, :kaltura_id,
                  :vimeo_id, :youtube_id,:thumbnails,:transcoded, :video_zobjects, :active,:discovery_url,
                  :custom_thumbnail_url, :subscription_ads_enabled, :title, :zobject_ids, :country,
                  :description, :short_description, :disable_at, :enable_at, :episode, :season,
                  :featured, :friendly_title, :keywords, :preview_ids, :mature_content, :pass_required,
                  :published_at, :subscription_required, :registration_required, :custom_attributes,
                  :categories_attributes, :segments, :images_attributes, :content_rules, :manifest, :duration

    CACHE_DEFAULTS = { expires_in: 7.days, force: false }

    def image_url
      thumbnail = self.thumbnails.find {|thumbnail| thumbnail['width'] == 1280}
      thumbnail['url']
    end

    def zype_id
      "zype_#{self._id}"
    end

    def zype_script
      "#{ENV['ZYPE_API_PLAYER_URL_EMBED']}/#{self._id}.js?autoplay=true&app_key=#{ENV['ZYPE_API_APP_KEY']}"
    end

    def self.list(query = {}, clear_cache)
      cache = CACHE_DEFAULTS.merge({ force: clear_cache })
      response = Request.where('videos', cache, query)
      videos = response.fetch('response', []).map { |video| Video.new(video) }
      [ videos, response[:errors] ]
    end

    def self.find(id)
      response = Request.get("videos/#{id}", CACHE_DEFAULTS)
      video = response.fetch('response')
      Video.new(video)
    end

    def initialize(args = {})
      super(args)
    end

  end
end
