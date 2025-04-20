// api_string.dart

class ApiString {
  static const String baseUrl = "http://localhost:8001";

  // Auth Endpoints
  static const String signup = "/signup";
  static const String login = "/login";
  static const String logout = "/logout";
  static const String verifyToken = "/verify-token";
  static const String forgotPassword = "/forgot-password";
  static const String verifyOtp = "/verify-otp";
  static const String resetPassword = "/reset-password";
  static const String googleAuth = "/auth/google";

  // Stripe
  static const String createCheckoutSession = "/create-checkout-session";
  static const String stripeWebhook = "/webhook";
  static const String getPrices = "/get-prices";
  static const String getStripeConfig = "/config";

  // AI Tools
  static const String textSegmentor = "/text-segmentor";
  static const String processImages = "/process_images";
  static const String uploadCustomBackground = "/upload_custom_background";
  static const String generateAiBackground = "/generate_ai_background";
  static const String colorizeImage = "/colorize-image";
  static const String mergeBackground = "/merge_background";
  static const String generatePrompt = "/generate_prompt";
  static const String savePreferences = "/save_preferences";

  // Video & Audio (Static)
  static const String generateVideoThread = "/generate_video_thread";
  static const String generateVideo = "/api/video/generate";
  static const String uploadVideo = "/api/upload_video";
  static const String generateAudio = "/api/generate_audio";
  static const String getS3File = "/api/get_s3_file";

  // Dynamic URL Patterns (with placeholders)
  static const String testImagePath = "/api/test-path/{user_id}/{image_name}";
  static const String getAudioStatus = "/api/audio_status/{creation_id}";
  static const String extractAudio = "/api/extract_audio/{creation_id}";
  static const String getAudioStatusById = "/api/status/{creation_id}";
  static const String getOutputVideo = "/api/get_output_video/{creation_id}";
  static const String getUserLibrary = "/library/{user_id}";
  static const String deleteCreation = "/library/{creation_id}";
  static const String getCharacterScore = "/character/score/{user_id}";

  // Referral
  static const String generateReferral = "/referral/generate";
  static const String verifyReferral = "/referral/verify";

  // Extras
  static const String addWatermark = "/watermark";
  static const String combineClips = "/movie/clips";
  static const String healthCheck = "/utils/health";

  // Docs & Health
  static const String apiHealthCheck = "/api/health";
  static const String redirectToDocs = "/";
  static const String redirectToApiDocs = "/api";

}
