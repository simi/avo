module Avo
  module Resources
    module Controls
      class BackButton < BaseControl
        def initialize(**args)
          @args = args
          @label = args[:label] || I18n.t("avo.go_back")
        end
      end
    end
  end
end
