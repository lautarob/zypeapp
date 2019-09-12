class VideosController < ApplicationController

  def index
    @tag = query.fetch(:tags, 'all')
    @refresh_params = refresh_params
    @videos, @errors = Zype::Video.list(query, clear_cache)
  end

  def show
    @video = Zype::Video.find(params[:id])
  end

  private
  def query
    params.fetch(:query, {})
  end

  def clear_cache
    params[:clear_cache].present?
  end

  def refresh_params
    refresh = { clear_cache: true }
    refresh.merge!({ query: query }) if query.present?
    refresh
  end
end
