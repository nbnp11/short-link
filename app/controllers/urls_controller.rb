# frozen_string_literal: true

class UrlsController < ApplicationController
  def create
    url = Url.new(url_create_params)
    url.save!

    render json: { short_link: url.short_link }
  rescue ActiveRecord::RecordInvalid
    render json: { errors: url.errors.messages }, status: 422
  rescue ActionController::ParameterMissing => e
    render json: { errors: e.message }, status: 422
  end

  def show
    url = Url.find_by!(short_link: params[:short_link])

    url.increment!(:stat)
    render json: { link: url.link }
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: 404
  end

  def stats
    url = Url.find_by!(short_link: params[:url_short_link])

    render json: { stats: url.stat }
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: 404
  end

  private

  def url_create_params
    params.require(:url).permit(:link)
  end
end
