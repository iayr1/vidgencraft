REM Create directories step by step (Windows CMD or PowerShell)

REM CORE
mkdir core
mkdir core\constants
mkdir core\themes
mkdir core\widgets

echo // TODO: Add app-wide constants > core\constants\constants.dart
echo // TODO: Define light & dark themes > core\themes\app_theme.dart
echo // TODO: Custom app bar widget > core\widgets\custom_app_bar.dart
echo // TODO: Reusable feature tile widget > core\widgets\feature_tile.dart

REM CONFIG
mkdir config
echo // TODO: Define app navigation routes > config\app_router.dart
echo // TODO: Dependency bindings (optional) > config\bindings.dart

REM AUTH
mkdir features
mkdir features\auth
mkdir features\auth\presentation
mkdir features\auth\presentation\screens
mkdir features\auth\presentation\widgets
mkdir features\auth\domain

echo // TODO: Login screen UI > features\auth\presentation\screens\login_screen.dart
echo // TODO: Signup screen UI > features\auth\presentation\screens\signup_screen.dart
echo // TODO: Login form widget > features\auth\presentation\widgets\login_form.dart

REM DASHBOARD
mkdir features\dashboard
mkdir features\dashboard\presentation
mkdir features\dashboard\presentation\screens
mkdir features\dashboard\presentation\widgets

echo // TODO: Dashboard screen UI > features\dashboard\presentation\screens\dashboard_screen.dart
echo // TODO: Dashboard header widget > features\dashboard\presentation\widgets\dashboard_header.dart

REM TEXT TO VIDEO
mkdir features\text_to_video
mkdir features\text_to_video\presentation
mkdir features\text_to_video\presentation\screens
echo // TODO: Text to Video screen UI > features\text_to_video\presentation\screens\text_to_video_screen.dart

REM IMAGE TO VIDEO
mkdir features\image_to_video
mkdir features\image_to_video\presentation
mkdir features\image_to_video\presentation\screens
echo // TODO: Image to Video screen UI > features\image_to_video\presentation\screens\image_to_video_screen.dart

REM TEXT TO IMAGE
mkdir features\text_to_image
mkdir features\text_to_image\presentation
mkdir features\text_to_image\presentation\screens
echo // TODO: Text to Image screen UI > features\text_to_image\presentation\screens\text_to_image_screen.dart

REM LIBRARY
mkdir features\library
mkdir features\library\presentation
mkdir features\library\presentation\screens
echo // TODO: Library screen UI > features\library\presentation\screens\library_screen.dart

REM GALLERY
mkdir features\gallery
mkdir features\gallery\presentation
mkdir features\gallery\presentation\screens
echo // TODO: Gallery screen UI > features\gallery\presentation\screens\gallery_screen.dart

REM PROFILE
mkdir features\profile
mkdir features\profile\presentation
mkdir features\profile\presentation\screens
echo // TODO: Profile screen UI > features\profile\presentation\screens\profile_screen.dart

REM BILLING
mkdir features\billing
mkdir features\billing\presentation
mkdir features\billing\presentation\screens
echo // TODO: Billing screen UI > features\billing\presentation\screens\billing_screen.dart

REM NOTIFICATIONS
mkdir features\notifications
mkdir features\notifications\presentation
mkdir features\notifications\presentation\screens
echo // TODO: Notifications screen UI > features\notifications\presentation\screens\notifications_screen.dart

REM ROOT FILES
echo // TODO: Root MaterialApp setup > app.dart
echo // TODO: Entry point for the app > main.dart
