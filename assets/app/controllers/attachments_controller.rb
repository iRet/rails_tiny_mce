class AttachmentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def manage
    @attachments = "tiny_#{params[:media]}".classify.constantize.page(params[:page]).order('created_at DESC').per(10)
    respond_to :js
  end
  


  def create
    @attachment = "tiny_#{params[:media]}".classify.constantize.new params[params[:media]]
    
    if @attachment.save
      GC.start
      responds_to_parent do
        render :update do |page|
          page << "upload_callback();"
        end
      end
    else
      responds_to_parent do
        render :update do |page|
          page.alert('Sorry, there was an error uploading the photo.')
        end
      end
    end
  end
end
