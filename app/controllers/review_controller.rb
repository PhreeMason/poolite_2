class ReviewController < ApplicationController


   get '/review/new' do
     if logged_in?
       @user = current_user
       @my_review = logged_in?
       erb :'/review/write_review'
     else
       redirect to '/login'
     end
   end

   get '/review/:id' do
     if logged_in?
       @review = Review.find(params[:id])
       @my_review = my_review?(@review)
       erb :'/review/show_review'
     else
       redirect to '/login'
     end
   end

   post '/new/review' do
     if !params[:review][:body].blank?
       review =review.create(params[:review])
       review.save
       redirect to '/review'
     else
       @my_review = my_review?(@review)
       redirect to '/review/new'
     end
   end

   post '/delete/:id' do
     if logged_in?
       @review = Review.find(params[:id])
       if current_user.reviews.include?(@review)
         @review.destroy
       end
       @my_review = my_review?(@review)
       redirect to "/user/#{current_user.id}"
     else
       redirect to '/login'
     end
   end

   get '/review/:id/edit' do
     if logged_in?
       @review = Review.find(params[:id])
       @my_review = my_review?(@review)
       erb :'/review/edit_review'
     else
       redirect to '/login'
     end
   end

   post '/review/:id/edit' do
     if !params[:review][:body].blank?
       @review= Review.find(params[:id])
       if current_user.reviews.include?(@review)
         @review.update(params[:review])
       end
       @my_review = my_review?(@review)
       redirect to "review/#{@review.id}"
     else
       redirect to "/review/#{@review.id}/edit"
     end
   end


end
