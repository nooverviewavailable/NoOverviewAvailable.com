# frozen_string_literal: true

require 'i18n'

require 'parallel'

I18n.config.available_locales = :en

module Jekyll
  module Sanitizer
    def sanitize_file_path_component(name)
      I18n.transliterate(name.to_s).downcase.strip.gsub(' ', '-').gsub(/[^\w.-]/, '')
    end
  end

  class OverviewPage < Page
    include Sanitizer

    def initialize(site, base, frameworks)
      @site = site
      @base = base

      @dir = '/'
      @name = 'index.md'

      process(@name)
      read_yaml(File.join(base, '_templates'), 'overview.html')

      data['frameworks'] = frameworks
    end
  end

  class FrameworkPage < Page
    include Sanitizer

    def initialize(site, base, framework)
      @site = site
      @base = base

      @dir = framework['permalink']
      @name = 'index.md'

      process(@name)
      read_yaml(File.join(base, '_templates'), 'framework.html')
      framework['title'] = framework['name']

      data.merge!(framework)
    end
  end

  class DataPagesGenerator < Generator
    include Sanitizer
    safe true

    def generate(site)
      frameworks = Parallel.map(site.data['frameworks']) do |key, value|
        slug = sanitize_file_path_component(key)
        value['external_url'] = "https://developer.apple.com/documentation/#{slug.gsub(/-/, '')}"
        value['id'] = slug
        value['permalink'] = "/#{slug}/"
        value
      end

      frameworks.each do |framework|
        site.pages << FrameworkPage.new(site, site.source, framework)
      end

      site.pages << OverviewPage.new(site, site.source, frameworks.sort_by { |v| v['name'].downcase })
    end
  end
end
