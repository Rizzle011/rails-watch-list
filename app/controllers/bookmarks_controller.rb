class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    # list_id = params[:list_id]
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    # @bookmark.list_id = list_id
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  # we want a user to be able to remove a movie from the list and
  # destroy the bookmark at the same time
  def destroy
    bookmark = Bookmark.find(params[:id])
    list = bookmark.list
    bookmark.destroy
    redirect_to list_path(list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :photo)
  end


end
