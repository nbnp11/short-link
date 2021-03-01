# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validation' do
    context 'when invalid link' do
      it 'returns error' do
        url = described_class.new(link: 'Hello')
        expect(url.valid?).to be false
        expect(url.errors.messages).to eq({ link: ['is an invalid URL'] })
      end
    end

    context 'when same links' do
      let!(:url) { Fabricate(:url) }
      it 'returns error' do
        new_url = described_class.new(link: url.link)
        expect(new_url.valid?).to be false
        expect(new_url.errors.messages).to eq({ link: ['has already been taken'] })
      end
    end
  end
end
