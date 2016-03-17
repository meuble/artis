Artis::Admin.controllers :repertoires do
  get :index do
    @title = "Repertoires"
    @repertoires = Repertoire.all
    render 'repertoires/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'repertoire')
    @repertoire = Repertoire.new
    render 'repertoires/new'
  end

  post :create do
    @repertoire = Repertoire.new(params[:repertoire])
    if @repertoire.save
      @title = pat(:create_title, :model => "repertoire #{@repertoire.id}")
      flash[:success] = pat(:create_success, :model => 'Repertoire')
      params[:save_and_continue] ? redirect(url(:repertoires, :index)) : redirect(url(:repertoires, :edit, :id => @repertoire.id))
    else
      @title = pat(:create_title, :model => 'repertoire')
      flash.now[:error] = pat(:create_error, :model => 'repertoire')
      render 'repertoires/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "repertoire #{params[:id]}")
    @repertoire = Repertoire.find(params[:id])
    if @repertoire
      render 'repertoires/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'repertoire', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "repertoire #{params[:id]}")
    @repertoire = Repertoire.find(params[:id])
    if @repertoire
      if @repertoire.update_attributes(params[:repertoire])
        flash[:success] = pat(:update_success, :model => 'Repertoire', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:repertoires, :index)) :
          redirect(url(:repertoires, :edit, :id => @repertoire.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'repertoire')
        render 'repertoires/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'repertoire', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Repertoires"
    repertoire = Repertoire.find(params[:id])
    if repertoire
      if repertoire.destroy
        flash[:success] = pat(:delete_success, :model => 'Repertoire', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'repertoire')
      end
      redirect url(:repertoires, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'repertoire', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Repertoires"
    unless params[:repertoire_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'repertoire')
      redirect(url(:repertoires, :index))
    end
    ids = params[:repertoire_ids].split(',').map(&:strip)
    repertoires = Repertoire.find(ids)
    
    if Repertoire.destroy repertoires
    
      flash[:success] = pat(:destroy_many_success, :model => 'Repertoires', :ids => "#{ids.to_sentence}")
    end
    redirect url(:repertoires, :index)
  end
end
