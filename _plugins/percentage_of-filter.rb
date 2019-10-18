# frozen_string_literal: true

require 'active_support/all'

module Jekyll
  module PercentageOfFilter
    def percentage_of(part, whole)
      return 'n/a' if whole.zero?

      ActiveSupport::NumberHelper.number_to_percentage(((part.to_f / whole.to_f) * 100.0), precision: 3, significant: true)
    end
  end
end

Liquid::Template.register_filter(Jekyll::PercentageOfFilter)
