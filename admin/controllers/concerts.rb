Artis::Admin.controllers :concerts do
  get :index do
    @title = "Concerts"
    @concerts = Concert.all
    render 'concerts/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'concert')
    @concert = Concert.new
    @musicians = Musician.all
    render 'concerts/new'
  end

  post :create do
    ap params
    @concert = Concert.new(params[:concert])
    if @concert.save
      @title = pat(:create_title, :model => "concert #{@concert.id}")
      flash[:success] = pat(:create_success, :model => 'Concert')
      params[:save_and_continue] ? redirect(url(:concerts, :index)) : redirect(url(:concerts, :edit, :id => @concert.id))
    else
      @title = pat(:create_title, :model => 'concert')
      @musicians = Musician.all
      flash.now[:error] = pat(:create_error, :model => 'concert')
      render 'concerts/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "concert #{params[:id]}")
    @concert = Concert.find(params[:id])
    @musicians = Musician.all
    if @concert
      render 'concerts/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'concert', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "concert #{params[:id]}")
    @concert = Concert.find(params[:id])
    if @concert
      if @concert.update_attributes(params[:concert])
        flash[:success] = pat(:update_success, :model => 'Concert', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:concerts, :index)) :
          redirect(url(:concerts, :edit, :id => @concert.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'concert')
        @musicians = Musician.all
        render 'concerts/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'concert', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Concerts"
    concert = Concert.find(params[:id])
    if concert
      if concert.destroy
        flash[:success] = pat(:delete_success, :model => 'Concert', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'concert')
      end
      redirect url(:concerts, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'concert', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Concerts"
    unless params[:concert_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'concert')
      redirect(url(:concerts, :index))
    end
    ids = params[:concert_ids].split(',').map(&:strip)
    concerts = Concert.find(ids)
    
    if Concert.destroy concerts
    
      flash[:success] = pat(:destroy_many_success, :model => 'Concerts', :ids => "#{ids.to_sentence}")
    end
    redirect url(:concerts, :index)
  end
end
