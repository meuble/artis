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
    @setting = Setting.where(:key => "home_picture").first
    render "welcome"
  end

  get :intro do
    @setting = Setting.where(:key => "intro_picture").first
    render "intro", :layout => "pages"
  end

  get :contact do
    render "contact", :layout => "pages"
  end

  get :program do
    @sections = Section.order(:position => :asc).all
    @section = params[:r]
    @programs = Program.where(:section_id => Section.where(:title => params[:r]).first.try(:id)).order(:position => :asc).all
    @repertoires = Repertoire.order(:position => :asc).all
    render "program", :layout => "pages"
  end

  get :musicians do
    @core_members = Musician.where(:is_core_member => true).order(:position => :asc)
    @other_members = Musician.where(:is_core_member => false).order(:position => :asc)
    render "musicians", :layout => "pages"
  end

  get :concerts do
    @years = Concert.select(:date).order(:date => :asc).all.map {|c| c.date.year }.uniq.sort[-2..-1]
    if params[:time]
      if params[:time] == "archives"
        @concerts = Concert.where("YEAR(date) < ?", Time.now.year - 1).order(:date => :desc).all
        @title = "#{@time}"
      else
        @time = params[:time]
        @concerts = Concert.where("YEAR(date) = ?", @time).order(:date => :desc).all
        @title = "#{@time}"
      end
    else
      @time = Time.now.year
      @concerts = Concert.where("YEAR(date) = ? or YEAR(date) = ?", @time, @time.to_i - 1).order(:date => :desc).all
      @title = ""
    end

    render "concerts", :layout => "pages"
  end

  get :gallery do
    if Media.where(:kind => "Videos").exists?
      redirect(url('pages/videos'))
    else
      redirect(url('pages/photos'))
    end
  end
  
  ["Photos", "Videos", "Presse", "Audio"].each do |kind|
    get kind.downcase do
      @kinds = Media.select("distinct(kind)").all.map {|m| m.kind }
      @medium = Media.order(:position => :asc)
      @medium = @medium.where(:kind => kind)
      @medium = @medium.all
      render kind.downcase, :layout => "pages"
    end
  end
end
