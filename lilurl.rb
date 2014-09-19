require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'json'
require './translate.rb'

set :bind, '0.0.0.0'

get '/:hash' do
  begin
    if params[:hash] != "favicon.ico"
      newurl=geturl(params[:hash])
      redirect to(newurl)
    end
  rescue ArgumentError => e
    erb :index, :locals => {:error => e.to_s}
  end
end

post '/' do
  if settings.development?
     port = ":" + settings.port.to_s
  else
    port = ""
  end

  begin
    oldurl = params[:url]
    postfix = params[:postfix]
    newurl=makeurl(oldurl, postfix)
    newurl_hash = { 'newurl' => newurl }
    respond_with :index do |format|
      #format.html { erb :index, :locals => {:domain => request.host + port, :newurl => newurl, :error => nil}}
      format.json { "{url: http://#{request.host}#{port}/#{newurl},pass: yes}" }
    end
  rescue ArgumentError => e
    respond_with :index do |format|
      #format.html { erb :index, :locals => {:error => e.to_s }}
      format.json { "{error: #{e.to_s},{pass :no}}" }
    end
  rescue SQLite3::Exception => e
    erb :index, :locals => {:error => "Database error: " + e.to_s }
  end
end
