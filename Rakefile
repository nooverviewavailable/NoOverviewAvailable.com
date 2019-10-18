# frozen_string_literal: true

require './lib/apple_developer_spider'

require 'rake/clean'

require 'oj'
require 'parallel'

directory 'tmp'
CLEAN << 'tmp'

directory '_data/frameworks'
CLOBBER << '_data/frameworks'

task scrape: ['tmp'] do
  AppleDeveloperSpider.crawl!
end

task generate: ['tmp', '_data/frameworks'] do
  symbols = Parallel.map(Dir['tmp/**/*.json']) do |file|
    Oj.load(File.read(file))
  end

  Parallel.each(symbols.group_by { |symbol| symbol['framework'] }) do |name, symbols|
    next if name.nil? || name.empty?
    next if symbols.empty?

    slug = name.downcase.strip.gsub(' ', '-').gsub(/[^\w.-]/, '')
    filepath = File.join('_data/frameworks', slug) + '.json'

    framework = {}
    framework[:name] = name
    framework[:url] = 'https://developer.apple.com/documentation/' + URI.parse(symbols.flat_map { |symbol| symbol['url'] }.first).path.split(%r{/})[1]
    framework[:number_of_documented_symbols] = symbols.filter { |s| s['is_documented'] }.count
    framework[:number_of_undocumented_symbols] = symbols.filter { |s| !s['is_documented'] }.count
    framework[:symbols] = Parallel.flat_map(symbols) do |symbol|
      unless symbol['is_documented'] || symbol['type'] == 'Article' || symbol['type'] == 'Sample Code'
        symbol['breadcrumbs'] = symbol['breadcrumbs'].select { |b| !b.empty? && b != 'Deprecated' }.uniq[1..-1]

        case symbol['type']
        when /Property/, /Method/, /Initializer/, /Subscript/, 'Enumeration Case'
          symbol['name'] = begin
                               symbol['breadcrumbs'][-2..-1].join('.')
                           rescue StandardError
                             next
                             end
        when /Operator/
          symbol['name'] = begin
                               symbol['breadcrumbs'][-2..-1].reverse.join(' ')
                           rescue StandardError
                             next
                             end
        end

        symbol.select { |key, _value| %w[type url name breadcrumbs].include?(key) }
      end
    end.compact.sort_by { |symbol| symbol['name'] }

    File.write(filepath, Oj.dump(framework, mode: :compat))
  end
end

file '_site/' => [:build]

task :build do
  sh 'JEKYLL_ENV=production bundle exec jekyll build'
end

CLEAN << '_site'

file '.netlify/state.json' do
  sh 'netlify link'
end

CLOBBER << '.netlify'

task deploy: ['_site/', '.netlify/state.json'] do
  sh 'netlify deploy -d _site'
end

task publish: ['_site/'] do
  sh 'netlify deploy -d _site --prod'
end
