# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'POST /' do
    before { post '/urls', params: { url: url_params } }

    shared_examples 'error request' do
      it 'returns error' do
        expect(JSON.parse(response.body)).to eq({ 'errors' => error_message })
      end
    end

    context 'with invalid params' do
      let(:url_params) { { link: 'hi', stat: -10 } }
      let(:error_message) { { 'link' => ['is an invalid URL'] } }

      include_examples 'error request'
    end

    context 'with empty params' do
      let(:url_params) { nil }
      let(:error_message) { 'param is missing or the value is empty: url' }

      include_examples 'error request'
    end

    context 'with valid params' do
      let(:url_params) { Fabricate.attributes_for(:url).slice(:link) }

      it 'returns short url' do
        short_link = Url.first.short_link
        expect(JSON.parse(response.body)).to eq('short_link' => short_link)
      end
    end
  end

  describe 'GET /:short_link' do
    let(:url) { Fabricate(:url) }

    before { get "/urls/#{short_link}" }

    context 'when valid shot_link' do
      let(:short_link) { url.short_link }

      it 'returns link and increment stat' do
        expect(JSON.parse(response.body)).to eq({ 'link' => url.link })
        expect(url.reload.stat).to eq(1)
      end

      it 'increment again on subsequent request' do
        get "/urls/#{short_link}"
        expect(url.reload.stat).to eq(2)
      end
    end

    context 'when invalid short_link' do
      let(:short_link) { 'hello' }

      it 'returns error' do
        expect(JSON.parse(response.body)).to eq({ 'errors' => 'Couldn\'t find Url' })
      end
    end
  end

  describe 'GET /:url_short_link/stats' do
    let(:url) { Fabricate(:url) }

    before { get "/urls/#{short_link}/stats" }

    context 'when valid shot_link' do
      let(:short_link) { url.short_link }

      it 'returns link and increment stat' do
        expect(JSON.parse(response.body)).to eq({ 'stats' => url.stat })
      end
    end

    context 'when invalid short_link' do
      let(:short_link) { 'hello' }

      it 'returns error' do
        expect(JSON.parse(response.body)).to eq({ 'errors' => 'Couldn\'t find Url' })
      end
    end
  end
end
