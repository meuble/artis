Artis::App.controllers :pages do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :welcome do
    render "welcome"
  end

  get :intro do
    render "intro", :layout => "pages"
  end

  get :program do
    render "program", :layout => "pages"
  end

  get :musicians do
    @core_members = Musician.where(:is_core_member => true).order(:position => :asc)
    @other_members = Musician.where(:is_core_member => false).order(:position => :asc)
    render "musicians", :layout => "pages"
  end
end
