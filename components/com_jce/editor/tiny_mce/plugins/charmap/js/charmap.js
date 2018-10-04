/* jce - 2.6.32 | 2018-08-15 | https://www.joomlacontenteditor.net | Copyright (C) 2006 - 2018 Ryan Demmer. All rights reserved | GNU/GPL Version 2 or later - http://www.gnu.org/licenses/gpl-2.0.html */
function renderCharMapHTML(){var i,charsPerRow=20,html='<ul class="charmap">',cols=-1;for(i=0;i<charmap.length;i++)1==charmap[i][2]&&(cols++,html+="<li><a onmouseover=\"previewChar('"+charmap[i][1].substring(1,charmap[i][1].length)+"','"+charmap[i][0].substring(1,charmap[i][0].length)+"','"+charmap[i][3]+"');\" onfocus=\"previewChar('"+charmap[i][1].substring(1,charmap[i][1].length)+"','"+charmap[i][0].substring(1,charmap[i][0].length)+"','"+charmap[i][3]+'\');" href="javascript:void(0)" onclick="insertChar(\''+charmap[i][1].substring(2,charmap[i][1].length-1)+'\');" onclick="return false;" onmousedown="return false;" title="'+charmap[i][3]+'">'+charmap[i][1]+"</a></li>",(cols+1)%charsPerRow==0&&(html+='</ul><ul class="charmap">'));if(cols%charsPerRow>0)for(var padd=charsPerRow-cols%charsPerRow,i=0;i<padd-1;i++)html+="<li>&nbsp;</li>";return html+="</ul>"}function insertChar(chr){tinyMCEPopup.execCommand("mceInsertContent",!1,"&#"+chr+";"),tinyMCEPopup.isWindow&&window.focus(),tinyMCEPopup.editor.focus(),tinyMCEPopup.close()}function previewChar(codeA,codeB,codeN){var elmA=document.getElementById("codeA"),elmB=document.getElementById("codeB"),elmV=document.getElementById("codeV"),elmN=document.getElementById("codeN");"#160;"==codeA?elmV.innerHTML="__":elmV.innerHTML="&"+codeA,elmB.innerHTML="&amp;"+codeA,elmA.innerHTML="&amp;"+codeB,elmN.innerHTML=codeN}var charmap=[["&nbsp;","&#160;",!0,"no-break space"],["&amp;","&#38;",!0,"ampersand"],["&quot;","&#34;",!0,"quotation mark"],["&cent;","&#162;",!0,"cent sign"],["&euro;","&#8364;",!0,"euro sign"],["&pound;","&#163;",!0,"pound sign"],["&yen;","&#165;",!0,"yen sign"],["&copy;","&#169;",!0,"copyright sign"],["&reg;","&#174;",!0,"registered sign"],["&trade;","&#8482;",!0,"trade mark sign"],["&permil;","&#8240;",!0,"per mille sign"],["&micro;","&#181;",!0,"micro sign"],["&middot;","&#183;",!0,"middle dot"],["&bull;","&#8226;",!0,"bullet"],["&hellip;","&#8230;",!0,"three dot leader"],["&prime;","&#8242;",!0,"minutes / feet"],["&Prime;","&#8243;",!0,"seconds / inches"],["&sect;","&#167;",!0,"section sign"],["&para;","&#182;",!0,"paragraph sign"],["&szlig;","&#223;",!0,"sharp s / ess-zed"],["&lsaquo;","&#8249;",!0,"single left-pointing angle quotation mark"],["&rsaquo;","&#8250;",!0,"single right-pointing angle quotation mark"],["&laquo;","&#171;",!0,"left pointing guillemet"],["&raquo;","&#187;",!0,"right pointing guillemet"],["&lsquo;","&#8216;",!0,"left single quotation mark"],["&rsquo;","&#8217;",!0,"right single quotation mark"],["&ldquo;","&#8220;",!0,"left double quotation mark"],["&rdquo;","&#8221;",!0,"right double quotation mark"],["&sbquo;","&#8218;",!0,"single low-9 quotation mark"],["&bdquo;","&#8222;",!0,"double low-9 quotation mark"],["&lt;","&#60;",!0,"less-than sign"],["&gt;","&#62;",!0,"greater-than sign"],["&le;","&#8804;",!0,"less-than or equal to"],["&ge;","&#8805;",!0,"greater-than or equal to"],["&ndash;","&#8211;",!0,"en dash"],["&mdash;","&#8212;",!0,"em dash"],["&macr;","&#175;",!0,"macron"],["&oline;","&#8254;",!0,"overline"],["&curren;","&#164;",!0,"currency sign"],["&brvbar;","&#166;",!0,"broken bar"],["&uml;","&#168;",!0,"diaeresis"],["&iexcl;","&#161;",!0,"inverted exclamation mark"],["&iquest;","&#191;",!0,"turned question mark"],["&circ;","&#710;",!0,"circumflex accent"],["&tilde;","&#732;",!0,"small tilde"],["&deg;","&#176;",!0,"degree sign"],["&minus;","&#8722;",!0,"minus sign"],["&plusmn;","&#177;",!0,"plus-minus sign"],["&divide;","&#247;",!0,"division sign"],["&frasl;","&#8260;",!0,"fraction slash"],["&times;","&#215;",!0,"multiplication sign"],["&sup1;","&#185;",!0,"superscript one"],["&sup2;","&#178;",!0,"superscript two"],["&sup3;","&#179;",!0,"superscript three"],["&frac14;","&#188;",!0,"fraction one quarter"],["&frac12;","&#189;",!0,"fraction one half"],["&frac34;","&#190;",!0,"fraction three quarters"],["&fnof;","&#402;",!0,"function / florin"],["&int;","&#8747;",!0,"integral"],["&sum;","&#8721;",!0,"n-ary sumation"],["&infin;","&#8734;",!0,"infinity"],["&radic;","&#8730;",!0,"square root"],["&sim;","&#8764;",!1,"similar to"],["&cong;","&#8773;",!1,"approximately equal to"],["&asymp;","&#8776;",!0,"almost equal to"],["&ne;","&#8800;",!0,"not equal to"],["&equiv;","&#8801;",!0,"identical to"],["&isin;","&#8712;",!1,"element of"],["&notin;","&#8713;",!1,"not an element of"],["&ni;","&#8715;",!1,"contains as member"],["&prod;","&#8719;",!0,"n-ary product"],["&and;","&#8743;",!1,"logical and"],["&or;","&#8744;",!1,"logical or"],["&not;","&#172;",!0,"not sign"],["&cap;","&#8745;",!0,"intersection"],["&cup;","&#8746;",!1,"union"],["&part;","&#8706;",!0,"partial differential"],["&forall;","&#8704;",!1,"for all"],["&exist;","&#8707;",!1,"there exists"],["&empty;","&#8709;",!1,"diameter"],["&nabla;","&#8711;",!1,"backward difference"],["&lowast;","&#8727;",!1,"asterisk operator"],["&prop;","&#8733;",!1,"proportional to"],["&ang;","&#8736;",!1,"angle"],["&acute;","&#180;",!0,"acute accent"],["&cedil;","&#184;",!0,"cedilla"],["&ordf;","&#170;",!0,"feminine ordinal indicator"],["&ordm;","&#186;",!0,"masculine ordinal indicator"],["&dagger;","&#8224;",!0,"dagger"],["&Dagger;","&#8225;",!0,"double dagger"],["&Agrave;","&#192;",!0,"A - grave"],["&Aacute;","&#193;",!0,"A - acute"],["&Acirc;","&#194;",!0,"A - circumflex"],["&Atilde;","&#195;",!0,"A - tilde"],["&Auml;","&#196;",!0,"A - diaeresis"],["&Aring;","&#197;",!0,"A - ring above"],["&AElig;","&#198;",!0,"ligature AE"],["&Ccedil;","&#199;",!0,"C - cedilla"],["&Egrave;","&#200;",!0,"E - grave"],["&Eacute;","&#201;",!0,"E - acute"],["&Ecirc;","&#202;",!0,"E - circumflex"],["&Euml;","&#203;",!0,"E - diaeresis"],["&Igrave;","&#204;",!0,"I - grave"],["&Iacute;","&#205;",!0,"I - acute"],["&Icirc;","&#206;",!0,"I - circumflex"],["&Iuml;","&#207;",!0,"I - diaeresis"],["&ETH;","&#208;",!0,"ETH"],["&Ntilde;","&#209;",!0,"N - tilde"],["&Ograve;","&#210;",!0,"O - grave"],["&Oacute;","&#211;",!0,"O - acute"],["&Ocirc;","&#212;",!0,"O - circumflex"],["&Otilde;","&#213;",!0,"O - tilde"],["&Ouml;","&#214;",!0,"O - diaeresis"],["&Oslash;","&#216;",!0,"O - slash"],["&OElig;","&#338;",!0,"ligature OE"],["&Scaron;","&#352;",!0,"S - caron"],["&Ugrave;","&#217;",!0,"U - grave"],["&Uacute;","&#218;",!0,"U - acute"],["&Ucirc;","&#219;",!0,"U - circumflex"],["&Uuml;","&#220;",!0,"U - diaeresis"],["&Yacute;","&#221;",!0,"Y - acute"],["&Yuml;","&#376;",!0,"Y - diaeresis"],["&THORN;","&#222;",!0,"THORN"],["&agrave;","&#224;",!0,"a - grave"],["&aacute;","&#225;",!0,"a - acute"],["&acirc;","&#226;",!0,"a - circumflex"],["&atilde;","&#227;",!0,"a - tilde"],["&auml;","&#228;",!0,"a - diaeresis"],["&aring;","&#229;",!0,"a - ring above"],["&aelig;","&#230;",!0,"ligature ae"],["&ccedil;","&#231;",!0,"c - cedilla"],["&egrave;","&#232;",!0,"e - grave"],["&eacute;","&#233;",!0,"e - acute"],["&ecirc;","&#234;",!0,"e - circumflex"],["&euml;","&#235;",!0,"e - diaeresis"],["&igrave;","&#236;",!0,"i - grave"],["&iacute;","&#237;",!0,"i - acute"],["&icirc;","&#238;",!0,"i - circumflex"],["&iuml;","&#239;",!0,"i - diaeresis"],["&eth;","&#240;",!0,"eth"],["&ntilde;","&#241;",!0,"n - tilde"],["&ograve;","&#242;",!0,"o - grave"],["&oacute;","&#243;",!0,"o - acute"],["&ocirc;","&#244;",!0,"o - circumflex"],["&otilde;","&#245;",!0,"o - tilde"],["&ouml;","&#246;",!0,"o - diaeresis"],["&oslash;","&#248;",!0,"o slash"],["&oelig;","&#339;",!0,"ligature oe"],["&scaron;","&#353;",!0,"s - caron"],["&ugrave;","&#249;",!0,"u - grave"],["&uacute;","&#250;",!0,"u - acute"],["&ucirc;","&#251;",!0,"u - circumflex"],["&uuml;","&#252;",!0,"u - diaeresis"],["&yacute;","&#253;",!0,"y - acute"],["&thorn;","&#254;",!0,"thorn"],["&yuml;","&#255;",!0,"y - diaeresis"],["&Alpha;","&#913;",!0,"Alpha"],["&Beta;","&#914;",!0,"Beta"],["&Gamma;","&#915;",!0,"Gamma"],["&Delta;","&#916;",!0,"Delta"],["&Epsilon;","&#917;",!0,"Epsilon"],["&Zeta;","&#918;",!0,"Zeta"],["&Eta;","&#919;",!0,"Eta"],["&Theta;","&#920;",!0,"Theta"],["&Iota;","&#921;",!0,"Iota"],["&Kappa;","&#922;",!0,"Kappa"],["&Lambda;","&#923;",!0,"Lambda"],["&Mu;","&#924;",!0,"Mu"],["&Nu;","&#925;",!0,"Nu"],["&Xi;","&#926;",!0,"Xi"],["&Omicron;","&#927;",!0,"Omicron"],["&Pi;","&#928;",!0,"Pi"],["&Rho;","&#929;",!0,"Rho"],["&Sigma;","&#931;",!0,"Sigma"],["&Tau;","&#932;",!0,"Tau"],["&Upsilon;","&#933;",!0,"Upsilon"],["&Phi;","&#934;",!0,"Phi"],["&Chi;","&#935;",!0,"Chi"],["&Psi;","&#936;",!0,"Psi"],["&Omega;","&#937;",!0,"Omega"],["&alpha;","&#945;",!0,"alpha"],["&beta;","&#946;",!0,"beta"],["&gamma;","&#947;",!0,"gamma"],["&delta;","&#948;",!0,"delta"],["&epsilon;","&#949;",!0,"epsilon"],["&zeta;","&#950;",!0,"zeta"],["&eta;","&#951;",!0,"eta"],["&theta;","&#952;",!0,"theta"],["&iota;","&#953;",!0,"iota"],["&kappa;","&#954;",!0,"kappa"],["&lambda;","&#955;",!0,"lambda"],["&mu;","&#956;",!0,"mu"],["&nu;","&#957;",!0,"nu"],["&xi;","&#958;",!0,"xi"],["&omicron;","&#959;",!0,"omicron"],["&pi;","&#960;",!0,"pi"],["&rho;","&#961;",!0,"rho"],["&sigmaf;","&#962;",!0,"final sigma"],["&sigma;","&#963;",!0,"sigma"],["&tau;","&#964;",!0,"tau"],["&upsilon;","&#965;",!0,"upsilon"],["&phi;","&#966;",!0,"phi"],["&chi;","&#967;",!0,"chi"],["&psi;","&#968;",!0,"psi"],["&omega;","&#969;",!0,"omega"],["&alefsym;","&#8501;",!1,"alef symbol"],["&piv;","&#982;",!1,"pi symbol"],["&real;","&#8476;",!1,"real part symbol"],["&thetasym;","&#977;",!1,"theta symbol"],["&upsih;","&#978;",!1,"upsilon - hook symbol"],["&weierp;","&#8472;",!1,"Weierstrass p"],["&image;","&#8465;",!1,"imaginary part"],["&larr;","&#8592;",!0,"leftwards arrow"],["&uarr;","&#8593;",!0,"upwards arrow"],["&rarr;","&#8594;",!0,"rightwards arrow"],["&darr;","&#8595;",!0,"downwards arrow"],["&harr;","&#8596;",!0,"left right arrow"],["&crarr;","&#8629;",!1,"carriage return"],["&lArr;","&#8656;",!1,"leftwards double arrow"],["&uArr;","&#8657;",!1,"upwards double arrow"],["&rArr;","&#8658;",!1,"rightwards double arrow"],["&dArr;","&#8659;",!1,"downwards double arrow"],["&hArr;","&#8660;",!1,"left right double arrow"],["&there4;","&#8756;",!1,"therefore"],["&sub;","&#8834;",!1,"subset of"],["&sup;","&#8835;",!1,"superset of"],["&nsub;","&#8836;",!1,"not a subset of"],["&sube;","&#8838;",!1,"subset of or equal to"],["&supe;","&#8839;",!1,"superset of or equal to"],["&oplus;","&#8853;",!1,"circled plus"],["&otimes;","&#8855;",!1,"circled times"],["&perp;","&#8869;",!1,"perpendicular"],["&sdot;","&#8901;",!1,"dot operator"],["&lceil;","&#8968;",!1,"left ceiling"],["&rceil;","&#8969;",!1,"right ceiling"],["&lfloor;","&#8970;",!1,"left floor"],["&rfloor;","&#8971;",!1,"right floor"],["&lang;","&#9001;",!1,"left-pointing angle bracket"],["&rang;","&#9002;",!1,"right-pointing angle bracket"],["&loz;","&#9674;",!0,"lozenge"],["&spades;","&#9824;",!0,"black spade suit"],["&clubs;","&#9827;",!0,"black club suit"],["&hearts;","&#9829;",!0,"black heart suit"],["&diams;","&#9830;",!0,"black diamond suit"],["&ensp;","&#8194;",!1,"en space"],["&emsp;","&#8195;",!1,"em space"],["&thinsp;","&#8201;",!1,"thin space"],["&zwnj;","&#8204;",!1,"zero width non-joiner"],["&zwj;","&#8205;",!1,"zero width joiner"],["&lrm;","&#8206;",!1,"left-to-right mark"],["&rlm;","&#8207;",!1,"right-to-left mark"],["&shy;","&#173;",!1,"soft hyphen"]];tinyMCEPopup.onInit.add(function(){tinyMCEPopup.dom.show("jce"),tinyMCEPopup.dom.setHTML("charmapView",renderCharMapHTML())});