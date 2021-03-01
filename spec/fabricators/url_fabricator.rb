# frozen_string_literal: true

Fabricator(:url) do
  link { "https://example#{rand(1..1000)}.org" }
end
