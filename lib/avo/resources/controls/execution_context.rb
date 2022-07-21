require "dry-initializer"

# This object holds some data tha is usually needed to compute blocks around the app.
module Avo
  module Resources
    module Controls
      class ExecutionContext
        extend Dry::Initializer

        option :context, default: proc { Avo::App.context }
        option :params, default: proc { Avo::App.params }
        option :view_context, default: proc { Avo::App.view_context }
        option :current_user, default: proc { Avo::App.current_user }
        option :items_holder, default: proc { Avo::Resources::Controls::ItemsHolder.new }
        option :resource, optional: true
        option :model, optional: true
        option :view, optional: true
        option :block, optional: true

        delegate :authorize, to: Avo::Services::AuthorizationService

        def handle
          instance_exec(&block)
        end

        private

        def back_button(**args)
          items_holder.add_item Avo::Resources::Controls::BackButton.new(**args)
        end

        def delete_button(**args)
          items_holder.add_item Avo::Resources::Controls::DeleteButton.new(**args)
        end

        def edit_button(**args)
          items_holder.add_item Avo::Resources::Controls::EditButton.new(**args)
        end

        def actions_list(**args)
          items_holder.add_item Avo::Resources::Controls::ActionsList.new(**args)
        end

        def action(klass, **args)
          # abort model.inspect
          items_holder.add_item Avo::Resources::Controls::Action.new(klass, model: model, resource: resource, view: view, **args)
        end
      end
    end
  end
end
