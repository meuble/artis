Artis::Admin.controllers :programs do
  get :index do
    @title = "programs"
    @programs = Program.all
    render 'programs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'program')
    @program = Program.new
    render 'programs/new'
  end

  post :create do
    @program = Program.new(params[:program])
    if @program.save
      @title = pat(:create_title, :model => "program #{@program.id}")
      flash[:success] = pat(:create_success, :model => 'program')
      params[:save_and_continue] ? redirect(url(:programs, :index)) : redirect(url(:programs, :edit, :id => @program.id))
    else
      @title = pat(:create_title, :model => 'program')
      flash.now[:error] = pat(:create_error, :model => 'program')
      render 'programs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "program #{params[:id]}")
    @program = Program.find(params[:id])
    if @program
      render 'programs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'program', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "program #{params[:id]}")
    @program = Program.find(params[:id])
    if @program
      if @program.update_attributes(params[:program])
        flash[:success] = pat(:update_success, :model => 'program', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:programs, :index)) :
          redirect(url(:programs, :edit, :id => @program.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'program')
        render 'programs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'program', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "programs"
    program = Program.find(params[:id])
    if program
      if program.destroy
        flash[:success] = pat(:delete_success, :model => 'program', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'program')
      end
      redirect url(:programs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'program', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "programs"
    unless params[:program_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'program')
      redirect(url(:programs, :index))
    end
    ids = params[:program_ids].split(',').map(&:strip)
    programs = Program.find(ids)
    
    if program.destroy programs
    
      flash[:success] = pat(:destroy_many_success, :model => 'programs', :ids => "#{ids.to_sentence}")
    end
    redirect url(:programs, :index)
  end
end
