describe Fastlane::Actions::FindFirebaseAppIdAction do
  describe '#run' do
    let(:ios_app_id) { "##Some iOS App ID##" }
    let(:android_app_id) { "##Some Android App ID##" }
    it 'should return Firebase App ID from GoogleService-Info.plist' do
      Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME] = :ios
      app_id = Fastlane::Actions::FindFirebaseAppIdAction.run(nil)
      expect(app_id).to eq(ios_app_id)
    end
    it 'should return Firebase App ID from google-services.json' do
      Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME] = :android
      params = {
        app_identifier: "com.example.app"
      }
      app_id = Fastlane::Actions::FindFirebaseAppIdAction.run(params)
      expect(app_id).to eq(android_app_id)
    end
    it 'should set GOOGLE_APP_ID shared variable for iOS' do
      Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME] = :ios
      Fastlane::Actions::FindFirebaseAppIdAction.run(nil)
      expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::GOOGLE_APP_ID]).to eq(ios_app_id)
    end
    it 'should set GOOGLE_APP_ID shared variable for Android' do
      Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME] = :android
      params = {
        app_identifier: "com.example.app"
      }
      Fastlane::Actions::FindFirebaseAppIdAction.run(params)
      expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::GOOGLE_APP_ID]).to eq(android_app_id)
    end
  end
end
