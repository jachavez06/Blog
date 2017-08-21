#app/controllers/exceptions_controller.rb
class ExceptionsController < ApplicationController
  helper_method :details

  def exception
    @exception  = request.env['action_dispatch.exception']
    @status     = ActionDispatch::ExceptionWrapper.new(request.env, @exception).status_code
    @message    = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]

    if @status == 500
      render 'layouts/error'
    end

  end

  def details
    @details ||= {}.tap do |h|
       I18n.with_options scope: [:exception, :show, @response], exception_name: @exception.class.name, exception_message: @exception.message do |i18n|
               h[:name]    = i18n.t "#{@exception.class.name.underscore}.title", default: i18n.t(:title, default: @exception.class.name)
               h[:message] = i18n.t "#{@exception.class.name.underscore}.description", default: i18n.t(:description, default: @exception.message)
           end
      end
  end
end
