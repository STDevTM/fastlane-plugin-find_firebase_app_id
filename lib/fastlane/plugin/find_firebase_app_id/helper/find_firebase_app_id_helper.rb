require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class FindFirebaseAppIdHelper
      # class methods that you define here become available in your action
      # as `Helper::FindFirebaseAppIdHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the find_firebase_app_id plugin helper!")
      end
    end
  end
end
