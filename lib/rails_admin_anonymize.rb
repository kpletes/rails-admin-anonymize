require "rails_admin_anonymize/engine"

module RailsAdminAnonymize
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Anonymize < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          bindings[:abstract_model].model.respond_to?(:anonymize_all) || bindings[:abstract_model].new.respond_to?(:anonymize!)
        end

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:post]
        end

        register_instance_option :controller do
          proc do
            if params[:confirm]
              @objects = list_entries(@model_config, :update)
              anonymized = 0
              if @objects.respond_to?(:anonymize_all)
                anonymized = @objects.anonymize_all
              else
                @objects.each do |object|
                  begin
                    object.reload.anonymize!
                    anonymized += 1
                    @auditing_adapter && @auditing_adapter.update_object(object, @abstract_model, _current_user, { anonymized: true })
                  rescue Exception
                  end
                end
              end
              flash[:success] = t('admin.flash.successful', name: pluralize(anonymized, @model_config.label), action: t('admin.actions.anonymize.done')) unless anonymized == 0
              flash[:error] = t('admin.flash.error', name: pluralize(@objects.length - anonymized, @model_config.label), action: t('admin.actions.anonymize.done')) unless anonymized == @objects.count
              redirect_to back_or_index
            else
              @objects = list_entries(@model_config, :update)
              render @action.template_name
            end
          end
        end

        register_instance_option :bulkable? do
          true
        end

        register_instance_option :link_icon do
          'fa fa-shield'
        end
      end
    end
  end
end

