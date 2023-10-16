/// A class containing all available font familes for the app.
/// Note that in almost all cases, a specific text widget
/// should be used instead of referencing this.
abstract class FontFamilies {
  static const __nunito = "packages/interview_demo/Nunito",
      __montserratAlt = "packages/interview_demo/MontserratAlt";

  static get body => __nunito;
  static get label => __nunito;
  static get headline => __montserratAlt;
  static get display => __nunito;
  static get huge => __nunito;
}