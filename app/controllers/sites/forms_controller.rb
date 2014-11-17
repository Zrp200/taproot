class Sites::FormsController < SitesController

  include Sites::FormsHelper

  def new
    @current_form = Heartwood::Form.new
  end

  def create
    @current_form = Heartwood::Form.new(form_params)
    if current_form.save
      redirect_to site_route([current_form], :index), 
        :notice => t('notices.created', :item => 'Form')
    else
      render 'new'
    end
  end

  def update
    if current_form.update(form_params)
      redirect_to site_route([current_form], :index), 
        :notice => t('notices.updates', :item => 'Form')
    else
      render 'edit'
    end
  end

  def destroy
    current_form.destroy
    redirect_to site_route([site_forms], :index), 
      :notice => t('notices.deleted', :item => 'Form')
  end

  private

    def form_params
      params.require(:form).permit(
        :title,
        :description,
        :body,
        :thank_you_body,
        :notification_emails
      ).merge(
        :site => current_site
      )
    end

end
