class PicturesController < ApplicationController
  def new
    @picture = Picture.new
  end

  def create

  end

  private

  def picture_params
    params.require(:picture).permit(:comment, :uploaded_picture)
  end
end
