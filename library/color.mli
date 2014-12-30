(**     Color module 
    @ja 色モジュール *)

type t
(** @en [Color.t] : the type of colors 
    @ja [Color.t] : 色の型 *)

val make_color : int -> int -> int -> t
(** @en [make_color r g b] : creates a color from RGB
    @ja [make_color r g b] : RGB から色を作る *)

val to_string : t -> string
(** @en [to_string color] : converts [color] into a string form "#RRGGBB"
    @ja [to_string color] : 色を "#RRGGBB" という文字列に変換する *)

(**     A list of predefined colors
    @ja 提供されている色 *)

val snow : t
val ghostWhite : t
val whiteSmoke : t
val gainsboro  : t
val floralWhite : t
val oldLace : t
val linen : t
val antiqueWhite : t
val papayaWhip : t
val blanchedAlmond : t
val bisque : t
val peachPuff : t
val navajoWhite : t
val moccasin : t
val cornsilk : t
val ivory : t
val lemonChiffon : t
val seashell : t
val honeydew : t
val mintCream : t
val azure : t
val aliceBlue : t
val lavender : t
val lavenderBlush : t
val mistyRose : t
val white : t
val black : t
val darkSlateGray : t
val dimGray : t
val slateGray : t
val lightSlateGray : t
val gray : t
val lightGray : t
val midnightBlue : t
val navy : t
val navyBlue : t
val cornflowerBlue : t
val darkSlateBlue : t
val slateBlue : t
val mediumSlateBlue : t
val lightSlateBlue : t
val mediumBlue : t
val royalBlue : t
val blue : t
val dodgerBlue : t
val deepSkyBlue : t
val skyBlue : t
val lightSkyBlue : t
val steelBlue : t
val lightSteelBlue : t
val lightBlue : t
val powderBlue : t
val paleTurquoise : t
val darkTurquoise : t
val mediumTurquoise : t
val turquoise : t
val cyan : t
val lightCyan : t
val cadetBlue : t
val mediumAquamarine : t
val aquamarine : t
val darkGreen : t
val darkOliveGreen : t
val darkSeaGreen : t
val seaGreen : t
val mediumSeaGreen : t
val lightSeaGreen : t
val paleGreen : t
val springGreen : t
val lawnGreen : t
val green : t
val chartreuse : t
val mediumSpringGreen : t
val greenYellow : t
val limeGreen : t
val yellowGreen : t
val forestGreen : t
val oliveDrab : t
val darkKhaki : t
val khaki : t
val paleGoldenrod : t
val lightGoldenrodYellow : t
val lightYellow : t
val yellow : t
val gold : t
val lightGoldenrod : t
val goldenrod : t
val darkGoldenrod : t
val rosyBrown : t
val indianRed : t
val saddleBrown : t
val sienna : t
val peru : t
val burlywood : t
val beige : t
val wheat : t
val sandyBrown : t
val tan : t
val chocolate : t
val firebrick : t
val brown : t
val darkSalmon : t
val salmon : t
val lightSalmon : t
val orange : t
val darkOrange : t
val coral : t
val lightCoral : t
val tomato : t
val orangeRed : t
val red : t
val hotPink : t
val deepPink : t
val pink : t
val lightPink : t
val paleVioletRed : t
val maroon : t
val mediumVioletRed : t
val violetRed : t
val magenta : t
val violet : t
val plum : t
val orchid : t
val mediumOrchid : t
val darkOrchid : t
val darkViolet : t
val blueViolet : t
val purple : t
val mediumPurple : t
val thistle : t
val snow1 : t
val snow2 : t
val snow3 : t
val snow4 : t
val seashell1 : t
val seashell2 : t
val seashell3 : t
val seashell4 : t
val antiqueWhite1 : t
val antiqueWhite2 : t
val antiqueWhite3 : t
val antiqueWhite4 : t
val bisque1 : t
val bisque2 : t
val bisque3 : t
val bisque4 : t
val peachPuff1 : t
val peachPuff2 : t
val peachPuff3 : t
val peachPuff4 : t
val navajoWhite1 : t
val navajoWhite2 : t
val navajoWhite3 : t
val navajoWhite4 : t
val lemonChiffon1 : t
val lemonChiffon2 : t
val lemonChiffon3 : t
val lemonChiffon4 : t
val cornsilk1 : t
val cornsilk2 : t
val cornsilk3 : t
val cornsilk4 : t
val ivory1 : t
val ivory2 : t
val ivory3 : t
val ivory4 : t
val honeydew1 : t
val honeydew2 : t
val honeydew3 : t
val honeydew4 : t
val lavenderBlush1 : t
val lavenderBlush2 : t
val lavenderBlush3 : t
val lavenderBlush4 : t
val mistyRose1 : t
val mistyRose2 : t
val mistyRose3 : t
val mistyRose4 : t
val azure1 : t
val azure2 : t
val azure3 : t
val azure4 : t
val slateBlue1 : t
val slateBlue2 : t
val slateBlue3 : t
val slateBlue4 : t
val royalBlue1 : t
val royalBlue2 : t
val royalBlue3 : t
val royalBlue4 : t
val blue1 : t
val blue2 : t
val blue3 : t
val blue4 : t
val dodgerBlue1 : t
val dodgerBlue2 : t
val dodgerBlue3 : t
val dodgerBlue4 : t
val steelBlue1 : t
val steelBlue2 : t
val steelBlue3 : t
val steelBlue4 : t
val deepSkyBlue1 : t
val deepSkyBlue2 : t
val deepSkyBlue3 : t
val deepSkyBlue4 : t
val skyBlue1 : t
val skyBlue2 : t
val skyBlue3 : t
val skyBlue4 : t
val lightSkyBlue1 : t
val lightSkyBlue2 : t
val lightSkyBlue3 : t
val lightSkyBlue4 : t
val slateGray1 : t
val slateGray2 : t
val slateGray3 : t
val slateGray4 : t
val lightSteelBlue1 : t
val lightSteelBlue2 : t
val lightSteelBlue3 : t
val lightSteelBlue4 : t
val lightBlue1 : t
val lightBlue2 : t
val lightBlue3 : t
val lightBlue4 : t
val lightCyan1 : t
val lightCyan2 : t
val lightCyan3 : t
val lightCyan4 : t
val paleTurquoise1 : t
val paleTurquoise2 : t
val paleTurquoise3 : t
val paleTurquoise4 : t
val cadetBlue1 : t
val cadetBlue2 : t
val cadetBlue3 : t
val cadetBlue4 : t
val turquoise1 : t
val turquoise2 : t
val turquoise3 : t
val turquoise4 : t
val cyan1 : t
val cyan2 : t
val cyan3 : t
val cyan4 : t
val darkSlateGray1 : t
val darkSlateGray2 : t
val darkSlateGray3 : t
val darkSlateGray4 : t
val aquamarine1 : t
val aquamarine2 : t
val aquamarine3 : t
val aquamarine4 : t
val darkSeaGreen1 : t
val darkSeaGreen2 : t
val darkSeaGreen3 : t
val darkSeaGreen4 : t
val seaGreen1 : t
val seaGreen2 : t
val seaGreen3 : t
val seaGreen4 : t
val paleGreen1 : t
val paleGreen2 : t
val paleGreen3 : t
val paleGreen4 : t
val springGreen1 : t
val springGreen2 : t
val springGreen3 : t
val springGreen4 : t
val green1 : t
val green2 : t
val green3 : t
val green4 : t
val chartreuse1 : t
val chartreuse2 : t
val chartreuse3 : t
val chartreuse4 : t
val oliveDrab1 : t
val oliveDrab2 : t
val oliveDrab3 : t
val oliveDrab4 : t
val darkOliveGreen1 : t
val darkOliveGreen2 : t
val darkOliveGreen3 : t
val darkOliveGreen4 : t
val khaki1 : t
val khaki2 : t
val khaki3 : t
val khaki4 : t
val lightGoldenrod1 : t
val lightGoldenrod2 : t
val lightGoldenrod3 : t
val lightGoldenrod4 : t
val lightYellow1 : t
val lightYellow2 : t
val lightYellow3 : t
val lightYellow4 : t
val yellow1 : t
val yellow2 : t
val yellow3 : t
val yellow4 : t
val gold1 : t
val gold2 : t
val gold3 : t
val gold4 : t
val goldenrod1 : t
val goldenrod2 : t
val goldenrod3 : t
val goldenrod4 : t
val darkGoldenrod1 : t
val darkGoldenrod2 : t
val darkGoldenrod3 : t
val darkGoldenrod4 : t
val rosyBrown1 : t
val rosyBrown2 : t
val rosyBrown3 : t
val rosyBrown4 : t
val indianRed1 : t
val indianRed2 : t
val indianRed3 : t
val indianRed4 : t
val sienna1 : t
val sienna2 : t
val sienna3 : t
val sienna4 : t
val burlywood1 : t
val burlywood2 : t
val burlywood3 : t
val burlywood4 : t
val wheat1 : t
val wheat2 : t
val wheat3 : t
val wheat4 : t
val tan1 : t
val tan2 : t
val tan3 : t
val tan4 : t
val chocolate1 : t
val chocolate2 : t
val chocolate3 : t
val chocolate4 : t
val firebrick1 : t
val firebrick2 : t
val firebrick3 : t
val firebrick4 : t
val brown1 : t
val brown2 : t
val brown3 : t
val brown4 : t
val salmon1 : t
val salmon2 : t
val salmon3 : t
val salmon4 : t
val lightSalmon1 : t
val lightSalmon2 : t
val lightSalmon3 : t
val lightSalmon4 : t
val orange1 : t
val orange2 : t
val orange3 : t
val orange4 : t
val darkOrange1 : t
val darkOrange2 : t
val darkOrange3 : t
val darkOrange4 : t
val coral1 : t
val coral2 : t
val coral3 : t
val coral4 : t
val tomato1 : t
val tomato2 : t
val tomato3 : t
val tomato4 : t
val orangeRed1 : t
val orangeRed2 : t
val orangeRed3 : t
val orangeRed4 : t
val red1 : t
val red2 : t
val red3 : t
val red4 : t
val deepPink1 : t
val deepPink2 : t
val deepPink3 : t
val deepPink4 : t
val hotPink1 : t
val hotPink2 : t
val hotPink3 : t
val hotPink4 : t
val pink1 : t
val pink2 : t
val pink3 : t
val pink4 : t
val lightPink1 : t
val lightPink2 : t
val lightPink3 : t
val lightPink4 : t
val paleVioletRed1 : t
val paleVioletRed2 : t
val paleVioletRed3 : t
val paleVioletRed4 : t
val maroon1 : t
val maroon2 : t
val maroon3 : t
val maroon4 : t
val violetRed1 : t
val violetRed2 : t
val violetRed3 : t
val violetRed4 : t
val magenta1 : t
val magenta2 : t
val magenta3 : t
val magenta4 : t
val orchid1 : t
val orchid2 : t
val orchid3 : t
val orchid4 : t
val plum1 : t
val plum2 : t
val plum3 : t
val plum4 : t
val mediumOrchid1 : t
val mediumOrchid2 : t
val mediumOrchid3 : t
val mediumOrchid4 : t
val darkOrchid1 : t
val darkOrchid2 : t
val darkOrchid3 : t
val darkOrchid4 : t
val purple1 : t
val purple2 : t
val purple3 : t
val purple4 : t
val mediumPurple1 : t
val mediumPurple2 : t
val mediumPurple3 : t
val mediumPurple4 : t
val thistle1 : t
val thistle2 : t
val thistle3 : t
val thistle4 : t
val gray0 : t
val gray1 : t
val gray2 : t
val gray3 : t
val gray4 : t
val gray5 : t
val gray6 : t
val gray7 : t
val gray8 : t
val gray9 : t
val gray10 : t
val gray11 : t
val gray12 : t
val gray13 : t
val gray14 : t
val gray15 : t
val gray16 : t
val gray17 : t
val gray18 : t
val gray19 : t
val gray20 : t
val gray21 : t
val gray22 : t
val gray23 : t
val gray24 : t
val gray25 : t
val gray26 : t
val gray27 : t
val gray28 : t
val gray29 : t
val gray30 : t
val gray31 : t
val gray32 : t
val gray33 : t
val gray34 : t
val gray35 : t
val gray36 : t
val gray37 : t
val gray38 : t
val gray39 : t
val gray40 : t
val gray41 : t
val gray42 : t
val gray43 : t
val gray44 : t
val gray45 : t
val gray46 : t
val gray47 : t
val gray48 : t
val gray49 : t
val gray50 : t
val gray51 : t
val gray52 : t
val gray53 : t
val gray54 : t
val gray55 : t
val gray56 : t
val gray57 : t
val gray58 : t
val gray59 : t
val gray60 : t
val gray61 : t
val gray62 : t
val gray63 : t
val gray64 : t
val gray65 : t
val gray66 : t
val gray67 : t
val gray68 : t
val gray69 : t
val gray70 : t
val gray71 : t
val gray72 : t
val gray73 : t
val gray74 : t
val gray75 : t
val gray76 : t
val gray77 : t
val gray78 : t
val gray79 : t
val gray80 : t
val gray81 : t
val gray82 : t
val gray83 : t
val gray84 : t
val gray85 : t
val gray86 : t
val gray87 : t
val gray88 : t
val gray89 : t
val gray90 : t
val gray91 : t
val gray92 : t
val gray93 : t
val gray94 : t
val gray95 : t
val gray96 : t
val gray97 : t
val gray98 : t
val gray99 : t
val gray100 : t
val darkGray : t
val darkBlue : t
val darkCyan : t
val darkMagenta : t
val darkRed : t
val lightGreen : t
