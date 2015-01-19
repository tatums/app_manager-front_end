# encoding: utf-8
require 'rubygems'
require "json"
require 'bundler'
Bundler.require

require "sinatra/base"
require 'sinatra/assetpack'
require "sinatra/namespace"
require "sinatra/reloader"

class App < Sinatra::Base
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
      '/js/controllers/form.js',
      '/js/services/site.js'
    ]
  end

  set :slim, :format => :html
  set :sessions, true

  namespace '/api' do
    get "/sites" do
      @sites = AppManager::Site.all
      @sites.map {|s| {name: s.name, status: s.status, port: s.port} }.to_json
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
    post "/sites/:name" do
      port = AppManager::Site.all.last.port + 1
      @site = AppManager::Site.new(params[:name], port)
      @site.save
      {site: {name: @site.name, status: @site.status, port: @site.port} }.to_json
    end
  end

  get "/" do
    @sites = AppManager::Site.all
    slim :index
  end

  #get "/servers/new" do
  #  @servers = Server.all
  #  haml :new
  #end

  post "/sites/:name/on" do
    @site = AppManager::Site.all.find { |s| s.name == params[:name] }
    @site.start
    redirect to('/')
  end

  post "/sites/:name/off" do
    @site = AppManager::Site.all.find { |s| s.name == params[:name] }
    @site.stop
    redirect to('/')
  end

end
