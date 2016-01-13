Artis::Admin.controllers :sections do
  get :index do
    @title = "Sections"
    @sections = Section.all
    render 'sections/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'section')
    @section = Section.new
    render 'sections/new'
  end

  post :create do
    @section = Section.new(params[:section])
    if @section.save
      @title = pat(:create_title, :model => "Section #{@section.id}")
      flash[:success] = pat(:create_success, :model => 'Section')
      params[:save_and_continue] ? redirect(url(:sections, :index)) : redirect(url(:sections, :edit, :id => @section.id))
    else
      @title = pat(:create_title, :model => 'section')
      flash.now[:error] = pat(:create_error, :model => 'section')
      render 'sections/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "section #{params[:id]}")
    @section = Section.find(params[:id])
    if @section
      render 'sections/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'section', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "section #{params[:id]}")
    @section = Section.find(params[:id])
    if @section
      if @section.update_attributes(params[:section])
        flash[:success] = pat(:update_success, :model => 'section', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:sections, :index)) :
          redirect(url(:sections, :edit, :id => @section.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'section')
        render 'sections/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'section', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "sections"
    section = Section.find(params[:id])
    if section
      if section.destroy
        flash[:success] = pat(:delete_success, :model => 'section', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'section')
      end
      redirect url(:sections, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'section', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "sections"
    unless params[:section_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'section')
      redirect(url(:sections, :index))
    end
    ids = params[:section_ids].split(',').map(&:strip)
    sections = Section.find(ids)
    
    if Section.destroy sections
    
      flash[:success] = pat(:destroy_many_success, :model => 'sections', :ids => "#{ids.to_sentence}")
    end
    redirect url(:sections, :index)
  end
end
