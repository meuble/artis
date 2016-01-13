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

  get :contact do
    render "contact", :layout => "pages"
  end

  get :program do
    @sections = Section.all
    @programs = Program.where(:section_id => Section.where(:title => params[:r]).first.try(:id)).all
    render "program", :layout => "pages"
  end

  get :musicians do
    @core_members = Musician.where(:is_core_member => true).order(:position => :asc)
    @other_members = Musician.where(:is_core_member => false).order(:position => :asc)
    render "musicians", :layout => "pages"
  end

  get :concerts do
    @time = params[:time] || "2016"
    @years = Concert.select(:date).order(:date => :asc).all.map {|c| c.date.year }
    @years.pop
    @concerts = Concert.where("YEAR(date) = ?", @time).order(:date => :desc).all
    @title = "A venir"
    render "concerts", :layout => "pages"
  end
end
