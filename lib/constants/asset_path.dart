final String imageAssetRoot = "assets/";
final String network = _getImagePath("network.json");
final String invite = _getImagePath("invite.json");
final String sms = _getImagePath("sms.png");
final String logowhite = _getImagePath("logo_white.png"); 
final String logoblue = _getImagePath("logo_blue.png");
final String support = _getImagePath("support.png");
final String applePayLogo = _getImagePath("applePayLogo.png");
final String googlePayLogo = _getImagePath("googlePayLogo.png");


String _getImagePath(String imageName) => imageAssetRoot + imageName;
