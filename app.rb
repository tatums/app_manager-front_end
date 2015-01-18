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
      '/js/angular.min.js',
      '/js/angular-resource.min.js',
      '/js/app.js',
      '/js/controllers/index.js',
      '/js/services/site.js'
    ]
  end

  set :slim, :format => :html
  set :sessions, true

  namespace '/api' do
    get "/sites" do
      @sites = Site.all
      @sites.map{|s| {name: s.name, status: s.status, port: s.port} }.to_json
    end
  end

  get "/" do
    @sites = Site.all
    slim :index
  end

  #get "/servers/new" do
  #  @servers = Server.all
  #  haml :new
  #end

  post "/sites/:name/on" do
    @site = Site.all.find { |s| s.name == params[:name] }
    @site.start
    redirect to('/')
  end

  post "/sites/:name/off" do
    @site = Site.all.find { |s| s.name == params[:name] }
    @site.stop
    redirect to('/')
  end

end
