class FiguresController < ApplicationController
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/figures' do
    erb :'/figures/index'
  end

  post '/figures' do
    # binding.pry
    figure = Figure.new(params[:figure])

    if params[:title][:name] != ""
      title = Title.new(params[:title])
      figure.titles << title
    end

    if params[:landmark][:name] != ""
      landmark = Landmark.new(params[:landmark])
      figure.landmarks << landmark
    end
    # binding.pry
    figure.save

    redirect '/figures'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  post '/figures/:id' do
    binding.pry
    @figure = Figure.find(params[:id])

    # @figure.name = params[:figure][:name] if params[:figure][:name] != ""

    # params[:figure][:title_ids].each do |title_id|
    #   title = Title.find(title_id)

    old_landmarks = @figure.landmarks.collect{|l| l.id}
    l.each{|old| !params[:figure][:landmark_ids].include?(old) ? old : nil}

  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

end
