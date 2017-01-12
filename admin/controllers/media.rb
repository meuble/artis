Artis::Admin.controllers :media do
  get :index do
    @title = "Media"
    @media = Media.all
    render 'media/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'media')
    @media = Media.new
    render 'media/new'
  end

  post :create do
    @media = Media.new(params[:media])
    if @media.save
      @title = pat(:create_title, :model => "media #{@media.id}")
      flash[:success] = pat(:create_success, :model => 'Media')
      params[:save_and_continue] ? redirect(url(:media, :index)) : redirect(url(:media, :edit, :id => @media.id))
    else
      @title = pat(:create_title, :model => 'media')
      flash.now[:error] = pat(:create_error, :model => 'media')
      render 'media/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "media #{params[:id]}")
    @media = Media.find(params[:id])
    if @media
      render 'media/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'media', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "media #{params[:id]}")
    @media = Media.find(params[:id])
    if @media
      if @media.update_attributes(params[:media])
        flash[:success] = pat(:update_success, :model => 'Media', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:media, :index)) :
          redirect(url(:media, :edit, :id => @media.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'media')
        render 'media/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'media', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Media"
    media = Media.find(params[:id])
    if media
      if media.destroy
        flash[:success] = pat(:delete_success, :model => 'Media', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'media')
      end
      redirect url(:media, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'media', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Media"
    unless params[:media_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'media')
      redirect(url(:media, :index))
    end
    ids = params[:media_ids].split(',').map(&:strip)
    media = Media.find(ids)
    
    if Media.destroy media
    
      flash[:success] = pat(:destroy_many_success, :model => 'Media', :ids => "#{ids.to_sentence}")
    end
    redirect url(:media, :index)
  end
end
