class ReviewController < ApplicationController


   get '/review/new' do
     if logged_in?
       @restrooms = Restroom.all
       erb :'/review/write_review'
     else
       redirect to '/login'
     end
   end

   get '/reviews/:id' do
     if logged_in?
       if @review = Review.find_by(id: params[:id])
         erb :'/review/show_review'
        else
          redirect to "/index"
       end

     else
      @review = Review.find_by(id: params[:id])
      erb :'/review/show_review'
     end
   end

   post '/restrooms/:restroom_id/review' do
     if logged_in?
       if stars_bod?
        review = Review.create(params[:review])
        current_user.reviews << review
        review.restroom_id = params[:restroom_id]
        if review.save
         redirect to "/reviews/#{review.id}"
        else
          flash[:message] = "Hmm something is not right, let's try that again"
          redirect to "/restrooms/#{params[:restroom_id]}"
        end
       else
        flash[:message] = "It seems you forgot to pick a star rating, please try again."
        redirect to "/restrooms/#{params[:restroom_id]}"
       end
     else
       flash[:message] = "please login first"
       redirect to "/login"
     end
   end

   post '/review' do
     if logged_in?
       binding.pry
       if all_good?
         binding.pry
         review = current_user.reviews.build(params[:review])
         if review.save
           binding.pry
           redirect to "/reviews/#{review.id}"
         else
           binding.pry
          flash[:message] = "Hmm something is not right, let's try that again"
          redirect to "review/new"
         end
       else
         binding.pry
         flash[:message] = "Please make sure to either choose a restroom OR fillout both fields to add a new restaurant. Dont forget a star review!"
         redirect to "review/new"
       end
     else
       flash[:message] = "please login first"
       redirect to "/login"
     end
   end

   delete '/delete/:id' do
     if logged_in?
       @review = Review.find(params[:id])
       if current_user.reviews.include?(@review)
         @review.destroy
       end
       redirect to "/user/#{current_user.slug}"
     else
       redirect to '/login'
     end
   end

   get '/reviews/:id/edit' do
     if logged_in?
       @review = Review.find(params[:id])
       if current_user.reviews.include?(@review)
         erb :'/review/edit_review'
       else
         flash[:message] = "You can't edit a review you did not create."
         redirect to "/reviews/#{@review.id}"
       end
     else
       flash[:message] = "please login first"
       redirect to "/login"
     end
   end

   put '/review/:id' do
     if logged_in?
       binding.pry
       if stars_bod?
         @review= Review.find(params[:id])
         if current_user.reviews.include?(@review)
           @review.update(params[:review])
         end
         redirect to "reviews/#{@review.id}"
       else
         flash[:message] = "Please choose a star raiting"
         redirect to "/reviews/#{params[:id]}/edit"
       end
     else
       flash[:message] = "please login first"
       redirect to "/login"
     end
   end

end
