Artis::Admin.controllers :musicians do
  get :index do
    @title = "Musicians"
    @musicians = Musician.all
    render 'musicians/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'musician')
    @musician = Musician.new
    render 'musicians/new'
  end

  post :create do
    @musician = Musician.new(params[:musician])
    if @musician.save
      @title = pat(:create_title, :model => "musician #{@musician.id}")
      flash[:success] = pat(:create_success, :model => 'Musician')
      params[:save_and_continue] ? redirect(url(:musicians, :index)) : redirect(url(:musicians, :edit, :id => @musician.id))
    else
      @title = pat(:create_title, :model => 'musician')
      flash.now[:error] = pat(:create_error, :model => 'musician')
      render 'musicians/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "musician #{params[:id]}")
    @musician = Musician.find(params[:id])
    if @musician
      render 'musicians/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'musician', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "musician #{params[:id]}")
    @musician = Musician.find(params[:id])
    if @musician
      if @musician.update_attributes(params[:musician])
        flash[:success] = pat(:update_success, :model => 'Musician', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:musicians, :index)) :
          redirect(url(:musicians, :edit, :id => @musician.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'musician')
        render 'musicians/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'musician', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Musicians"
    musician = Musician.find(params[:id])
    if musician
      if musician.destroy
        flash[:success] = pat(:delete_success, :model => 'Musician', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'musician')
      end
      redirect url(:musicians, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'musician', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Musicians"
    unless params[:musician_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'musician')
      redirect(url(:musicians, :index))
    end
    ids = params[:musician_ids].split(',').map(&:strip)
    musicians = Musician.find(ids)
    
    if Musician.destroy musicians
    
      flash[:success] = pat(:destroy_many_success, :model => 'Musicians', :ids => "#{ids.to_sentence}")
    end
    redirect url(:musicians, :index)
  end
end
