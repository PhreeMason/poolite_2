class ReviewController < ApplicationController


   get '/review/new' do
     if logged_in?
       @restrooms = Restroom.all
       erb :'/review/write_review'
     else
       redirect to '/login'
     end
   end

   get '/restrooms/:restroom_id/review/new' do
     if logged_in?
       @restroom = Restroom.find_by(id: params[:restroom_id])
       erb :'/review/write_review'
     else
       @restroom = params[:id]
       erb :login
     end
  end

   get '/review/:id' do
     if logged_in?
       @review = Review.find(params[:id])
       @my_review = my_review?(@review)
       erb :'/review/show_review'
     else
      @review = Review.find(params[:id])
      erb :'/review/show_review'
     end
   end

   post '/restrooms/:restroom_id/reviews' do
     if !params[:review][:stars].blank?
       review = current_user.reviews.build(params[:review])
       review.restroom_id = params[]

       if !params[:restroom][:restaurant_name].blank? && !params[:restroom][:location].blank?
         review.restroom = Restroom.create(params[:restroom])
       end

       if review.save
         redirect to "/review/#{review.id}"
       else
         redirect to '/review/new'
       end
     else
      if !params[:review][:restroom_id].blank?
        flash[:message] = "Hmm it seems you forgot to put a star rating."
        redirect to "/review/new/#{params[:review][:restroom_id]}"
      else
        flash[:message] = "Please make sure to choose a location or add a new one and also a star rating"
        @my_review = my_review?(review)
        redirect to '/review/new'
      end
     end
   end

   delete '/delete/:id' do
     if logged_in?
       @review = Review.find(params[:id])
       if current_user.reviews.include?(@review)
         @review.destroy
       end
       @my_review = my_review?(@review)
       redirect to "/user/#{current_user.slug}"
     else
       redirect to '/login'
     end
   end

   get '/reviews/:id/edit' do
     if logged_in?
       @review = Review.find(params[:id])
       @my_review = my_review?(@review)
       if my_review?(@review)
         erb :'/review/edit_review'
       else
         flash[:message] = "You can't edit a review you did not create."
         redirect to "/review/#{@review.id}"
       end
     else
       redirect to '/login'
     end
   end

   put '/review/:id' do
     if !params[:review][:body].blank? && !params[:review][:stars].blank?
       @review= Review.find(params[:id])
       if current_user.reviews.include?(@review)
         @review.update(params[:review])
       end
       @my_review = my_review?(@review)
       redirect to "review/#{@review.id}"
     else
       flash[:message] = "Please choose a star raiting"
       redirect to "/review/#{@review.id}/edit"
     end
   end

end
