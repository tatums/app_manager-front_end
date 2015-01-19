# encoding: utf-8
require 'rubygems'
require 'bundler'
Bundler.require

require "sinatra/base"
require 'sinatra/assetpack'
require "sinatra/namespace"
require "sinatra/json"
require "sinatra/reloader"

class App < Sinatra::Base
  helpers Sinatra::JSON
  register Sinatra::AssetPack
  register Sinatra::Namespace
  configure :development do
    register Sinatra::Reloader
  end

  assets do
    #http://recipes.sinatrarb.com/p/asset_management/sinatra_assetpack
    css :application, [
      '/css/style.css',
      '/css/bootstrap.min.css'
    ]

    js :application, [
      '/js/vendor/angular.min.js',
      '/js/vendor/angular-route.min.js',
      '/js/vendor/angular-resource.min.js',
      '/js/app.js',
      '/js/controllers/index.js',
      '/js/controllers/show.js',
      '/js/controllers/form.js',
      '/js/services/site.js'
    ]
  end

  set :slim, :format => :html
  set :sessions, true

  namespace '/api' do
    get "/sites" do
      @sites = AppManager::Site.all
      json @sites.map {|s| {name: s.name, status: s.status, port: s.port} }
    end

    post "/sites/:name/start" do
      @site = AppManager::Site.all.find { |s| s.name == params[:name] }
      @site.start
      {site: {name: @site.name, status: @site.status, port: @site.port} }.to_json
    end

    post "/sites/:name/stop" do
      @site = AppManager::Site.all.find { |s| s.name == params[:name] }
      @site.stop
      {site: {name: @site.name, status: @site.status, port: @site.port} }.to_json
    end

    get "/sites/:name" do
      @site = AppManager::Site.all.find { |s| s.name == params[:name] }
      {site: {name: @site.name, status: @site.status, port: @site.port} }.to_json
    end
  end

  get "/" do
    @sites = AppManager::Site.all
    slim :index
  end

end
