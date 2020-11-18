require 'fastlane/action'
require_relative '../helper/find_firebase_app_id_helper'

module Fastlane
  module Actions
    module SharedValues
      GOOGLE_APP_ID = :GOOGLE_APP_ID
    end

    class FindFirebaseAppIdAction < Action
      def self.run(params)
        platform = Actions.lane_context[Actions::SharedValues::PLATFORM_NAME]

        if platform == :ios || platform.nil?
          app_id = find_ios_app_id(params)
        end

        if platform == :android
          app_id = find_android_app_id(params)
        end

        if app_id.to_s == ''
          UI.user_error!("Can't find app id with provided information.")
        end

        # Store the id in the shared hash
        Actions.lane_context[SharedValues::GOOGLE_APP_ID] = app_id
        app_id
      end

      def self.find_ios_app_id(params)

        find_gsp_path(params)

        if !params[:gsp_path]
          UI.user_error!("#{filename} file is missing, please make sure you have added.")
        end

        GetInfoPlistValueAction.run(path: params[:gsp_path], key: 'GOOGLE_APP_ID')
      end

      def self.find_android_app_id(params)
        filename = "google-services.json"
        file_paths = Find.find('./').select { |p| p.include?(filename) }
        if file_paths.any?
          json_path = file_paths.first
          app_identifier = params[:app_identifier]
          begin
            json = File.read(json_path) # try to read json strong from file
            result = JSON.parse(json) # try to parse and see if it's valid JSON data
          rescue => ex
            UI.user_error!("Can't parse content of #{filename} as a json, please make sure you are using correct file: #{ex}")
          end
          client = result['client'].select { |c| c['client_info']['android_client_info']['package_name'] == app_identifier }
          if client.any?
            client.first['client_info']['mobilesdk_app_id']
          else
            UI.user_error!("#{filename} file doesn't contain configurations for #{app_identifier} application.")
          end
        else
          UI.user_error!("#{filename} file is missing, please make sure you have added.")
        end
      end

      def self.find_gsp_path(params)
        if params[:gsp_path].to_s.length > 0
          params[:gsp_path] = File.expand_path(params[:gsp_path])
        else
          gsp_path = Dir["./**/GoogleService-Info.plist"].first
          params[:gsp_path] = File.expand_path(gsp_path) unless gsp_path.nil?
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Helper plugin which will allow to find Firebase App ID from GoogleService-Info.plist [iOS] or google-services.json [Android]."
      end

      def self.authors
        ["Tigran Hambardzumyan"]
      end

      def self.output
        [
          ['GOOGLE_APP_ID', 'The Firebase App Id']
        ]
      end

      def self.return_value
        "Returns a Firebase App ID."
      end

      def self.details
        "Based on platform (ios or android) the plugin will search and find Firebase App ID from the GoogleService-Info.plist [iOS] or google-services.json [Android] files.\n" \
        "This plugin can be used when you are using same lane for distributing more than one apps. In this case the Firebase App IDs are not static and you require to find it from firebase configuration file to pass value to `firebase_app_distribution` plugin."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :app_identifier,
                                  env_name: "FIND_FIREBASE_APP_ID_APP_IDENTIFIER",
                               description: "The app identifier to find Firebase App ID (Required: for Android platform)",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :gsp_path,
                                  env_name: "GOOGLE_SERVICES_INFO_PLIST_PATH",
                        code_gen_sensitive: true,
                                description: "Path to GoogleService-Info.plist (only for iOS platform)",
                                  optional: true,
                              verify_block: proc do |value|
                                UI.user_error!("Couldn't find file at path '#{File.expand_path(value)}'") unless File.exist?(value)
                                UI.user_error!("No Path to GoogleService-Info.plist for Firebase Crashlytics given, pass using `gsp_path: 'path'`") if value.to_s.length == 0
                              end),
        ]
      end

      def self.example_code
        [
          <<-CODE
            app_id = find_firebase_app_id
          CODE
        ]
      end

      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
        true
      end
    end
  end
end
