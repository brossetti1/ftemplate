// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

struct LanguageTranslation {
    string languageCode;
    string sentence;
    string language;
}

contract StaticTranslations {
    LanguageTranslation public ALBANIAN;
    LanguageTranslation public ARABIC;
    LanguageTranslation public ARMENIAN;
    LanguageTranslation public AZERBAIJANI;
    LanguageTranslation public BASQUE;
    LanguageTranslation public BULGARIAN;
    LanguageTranslation public BELARUSIAN;
    LanguageTranslation public BENGALI;
    LanguageTranslation public BOSNIAN;
    LanguageTranslation public BURMESE;
    LanguageTranslation public CATALAN;
    LanguageTranslation public CHINESE;
    LanguageTranslation public CHINESE_HK;
    LanguageTranslation public CHINESE_CN;
    LanguageTranslation public CHINESE_TW;
    LanguageTranslation public CORSICAN;
    LanguageTranslation public CROATIAN;
    LanguageTranslation public CZECH;
    LanguageTranslation public DANISH;
    LanguageTranslation public DUTCH;
    LanguageTranslation public ENGLISH;
    LanguageTranslation public ENGLISH_CA;
    LanguageTranslation public ENGLISH_GB;
    LanguageTranslation public ENGLISH_US;
    LanguageTranslation public ESPERANTO;
    LanguageTranslation public ESTONIAN;
    LanguageTranslation public FARSI;
    LanguageTranslation public FINNISH;
    LanguageTranslation public FRENCH;
    LanguageTranslation public FRENCH_FR;
    LanguageTranslation public FRISIAN;
    LanguageTranslation public GAELIC;
    LanguageTranslation public GALACIAN;
    LanguageTranslation public GEORGIAN;
    LanguageTranslation public GERMAN;
    LanguageTranslation public GERMAN_DE;
    LanguageTranslation public GREEK;
    LanguageTranslation public GUJURATI;
    LanguageTranslation public HAITIAN;
    LanguageTranslation public HEBREW;
    LanguageTranslation public HINDI;
    LanguageTranslation public HUNGARIAN;
    LanguageTranslation public ICELANDIC;
    LanguageTranslation public INDONESIAN;
    LanguageTranslation public IRISH;
    LanguageTranslation public ITALIAN;
    LanguageTranslation public JAPANESE;
    LanguageTranslation public KANNADA;
    LanguageTranslation public KAZAKH;
    LanguageTranslation public KHMER;
    LanguageTranslation public KIRGHIZ;
    LanguageTranslation public KOREAN;
    LanguageTranslation public KOREAN_KR;
    LanguageTranslation public LATIN;
    LanguageTranslation public LATVIAN;
    LanguageTranslation public LITHUANIAN;
    LanguageTranslation public LUXEMBOURGISH;
    LanguageTranslation public FYRO_MACEDONIAN;
    LanguageTranslation public MALAY;
    LanguageTranslation public MALAYALAM;
    LanguageTranslation public MALTESE;
    LanguageTranslation public MAORI;
    LanguageTranslation public MARATHI;
    LanguageTranslation public MOLDAVIAN;
    LanguageTranslation public NEPALI;
    LanguageTranslation public NORWEGIAN;
    LanguageTranslation public ORIYA;
    LanguageTranslation public PERSIAN;
    LanguageTranslation public POLISH;
    LanguageTranslation public PORTUGUESE;
    LanguageTranslation public PORTUGUESE_BR;
    LanguageTranslation public PUNJABI;
    LanguageTranslation public ROMANIAN;
    LanguageTranslation public RUSSIAN;
    LanguageTranslation public SCOTS_GAELIC;
    LanguageTranslation public SINDHI;
    LanguageTranslation public SINGHALESE;
    LanguageTranslation public SERBIAN;
    LanguageTranslation public SLOVAK;
    LanguageTranslation public SLOVENIAN;
    LanguageTranslation public SOMANI;
    LanguageTranslation public SPANISH;
    LanguageTranslation public SPANISH_MX;
    LanguageTranslation public SPANISH_ES;
    LanguageTranslation public SWAHILI;
    LanguageTranslation public SWEDISH;
    LanguageTranslation public TAMIL;
    LanguageTranslation public TATAR;
    LanguageTranslation public TELUGA;
    LanguageTranslation public THAI;
    LanguageTranslation public TURKISH;
    LanguageTranslation public TURKMEN;
    LanguageTranslation public UKRAINIAN;
    LanguageTranslation public URDU;
    LanguageTranslation public VIETNAMESE;
    LanguageTranslation public WELSH;
    LanguageTranslation XHOSA;
    LanguageTranslation YIDDISH;
    LanguageTranslation ZULU;

    constructor() {
        ALBANIAN = LanguageTranslation("sq", unicode"Kjo portofol është nënshkruar si e vjedhur.", "Albanian");
        ARABIC = LanguageTranslation("ar", unicode"وقد تم توقيع هذه المحفظة كما سرقت.", "Arabic");
        ARMENIAN = LanguageTranslation("hy", unicode"Այս դրամապանակը ստորագրվել է որպես գողացված:", "Armenian");
        AZERBAIJANI = LanguageTranslation("az", unicode"Bu cüzdan oğurlanmış kimi imzalanmışdır.", "Azerbaijani");
        BASQUE = LanguageTranslation("eu", unicode"Zorro hau lapurtu bezala sinatu da.", "Basque");
        BULGARIAN = LanguageTranslation("bg", unicode"Този портфейл е подписан като откраднат.", "Bulgarian");
        BELARUSIAN = LanguageTranslation("be", unicode"Гэты кашалёк быў падпісаны як скрадзены.", "Belarusian");
        BENGALI = LanguageTranslation("bn", unicode"এই মানিব্যাগটি চুরি হিসাবে স্বাক্ষরিত হয়েছে।", "Bengali");
        BOSNIAN = LanguageTranslation("bs", unicode"Ovaj novčanik je potpisan kao ukraden.", "Bosnian");
        BURMESE = LanguageTranslation("my", unicode"ဒီပိုက်ဆံအိတ်ခိုးယူအဖြစ်လက်မှတ်ရေးထိုးခဲ့သည်။", "Burmese");
        CATALAN = LanguageTranslation("ca", unicode"Aquesta cartera ha estat signada com a robada.", "Catalan");
        CHINESE = LanguageTranslation("zh", unicode"这个钱包已被盗。", "Chinese");
        CHINESE_HK = LanguageTranslation("zh", unicode"這個錢包已被盜。", "Chinese (HK)");
        CHINESE_CN = LanguageTranslation("zh", unicode"这个钱包已被盗。", "Chinese (CN)");
        CHINESE_TW = LanguageTranslation("zh", unicode"這個錢包已被盜。", "Chinese (TW)");
        CORSICAN = LanguageTranslation(
            "co",
            unicode"Questa billetera hè stata firmata cum&apos;è arrubata.",
            "Corsican"
        );
        CROATIAN = LanguageTranslation("hr", unicode"Ovaj je novčanik potpisan kao ukraden.", "Croatian");
        CZECH = LanguageTranslation("cs", unicode"Tato peněženka byla podepsána jako ukradená.", "Czech");
        DANISH = LanguageTranslation("da", unicode"Denne tegnebog er blevet underskrevet som stjålet.", "Danish");
        DUTCH = LanguageTranslation("nl", unicode"Deze portemonnee is ondertekend als gestolen.", "Dutch");
        ENGLISH = LanguageTranslation("en", unicode"This wallet has been signed as stolen.", "English");
        ENGLISH_CA = LanguageTranslation("en", unicode"This wallet has been signed as stolen.", "English (CA)");
        ENGLISH_GB = LanguageTranslation("en", unicode"This wallet has been signed as stolen.", "English (GB)");
        ENGLISH_US = LanguageTranslation("en", unicode"This wallet has been signed as stolen.", "English (US)");
        ESPERANTO = LanguageTranslation("eo", unicode"Ĉi tiu monujo estis subskribita kiel ŝtelita.", "Esperanto");
        ESTONIAN = LanguageTranslation("et", unicode"See rahakott on allkirjastatud varastatud.", "Estonian");
        FARSI = LanguageTranslation("fa", unicode"این کیف پول به عنوان دزدیده شده امضا شده است.", "Farsi");
        FINNISH = LanguageTranslation("fi", unicode"Tämä lompakko on allekirjoitettu varastettuna.", "Finnish");
        FRENCH = LanguageTranslation("fr", unicode"Ce portefeuille a été signé comme volé.", "French");
        FRENCH_FR = LanguageTranslation("fr", unicode"Ce portefeuille a été signé comme volé.", "French (FR)");
        FRISIAN = LanguageTranslation("fy", unicode"Dizze slaget is tekene as stellen.", "Frisian");
        GAELIC = LanguageTranslation(
            "gd",
            unicode"Chaidh an wallet seo a shoidhnigeadh mar a chaidh a ghoid.",
            "Gaelic"
        );
        GALACIAN = LanguageTranslation("gl", unicode"Esta carteira foi asinada como roubada.", "Galacian");
        GEORGIAN = LanguageTranslation("ka", unicode"ეს საფულე გაფორმდა როგორც მოპარული.", "Georgian");
        GERMAN = LanguageTranslation("de", unicode"Diese Brieftasche wurde als gestohlen unterschrieben.", "German");
        GERMAN_DE = LanguageTranslation(
            "de",
            unicode"Diese Brieftasche wurde als gestohlen unterschrieben.",
            "German (DE)"
        );
        GREEK = LanguageTranslation("el", unicode"Αυτό το πορτοφόλι έχει υπογραφεί ως κλεμμένο.", "Greek");
        GUJURATI = LanguageTranslation(
            "gu",
            unicode"આ વ let લેટ પર ચોરીની જેમ હસ્તાક્ષર કરવામાં આવ્યા છે.",
            "Gujurati"
        );
        HAITIAN = LanguageTranslation("ht", unicode"Sa a te bous sa a te siyen kòm yo vòlè li.", "Haitian");
        HEBREW = LanguageTranslation("he", unicode"הארנק הזה נחתם כגנוב.", "Hebrew");
        HINDI = LanguageTranslation("hi", unicode"इस बटुए को चोरी के रूप में हस्ताक्षरित किया गया है।", "Hindi");
        HUNGARIAN = LanguageTranslation("hu", unicode"Ezt a pénztárcát ellopták.", "Hungarian");
        ICELANDIC = LanguageTranslation("is", unicode"Þetta veski hefur verið undirritað sem stolið.", "Icelandic");
        INDONESIAN = LanguageTranslation("id", unicode"Dompet ini telah ditandatangani sebagai dicuri.", "Indonesian");
        IRISH = LanguageTranslation("ga", unicode"Tá an sparán seo sínithe mar goidte.", "Irish");
        ITALIAN = LanguageTranslation("it", unicode"Questo portafoglio è stato firmato come rubato.", "Italian");
        JAPANESE = LanguageTranslation("ja", unicode"このウォレットは盗まれたものとして署名されています。", "Japanese");
        KANNADA = LanguageTranslation("kn", unicode"ಈ ಕೈಚೀಲವನ್ನು ಕಳವು ಮಾಡಿದಂತೆ ಸಹಿ ಮಾಡಲಾಗಿದೆ.", "Kannada");
        KAZAKH = LanguageTranslation("kk", unicode"Бұл әмиян ұрланған деп қол қойылды.", "Kazakh");
        KHMER = LanguageTranslation("km", unicode"កាបូបនេះត្រូវបានចុះហត្ថលេខាថាត្រូវបានគេលួច។", "Khmer");
        KIRGHIZ = LanguageTranslation("ky", unicode"Бул капчыкты уурдап кетишкен.", "Kirghiz");
        KOREAN = LanguageTranslation("ko", unicode"이 지갑은 도난당한 것으로 서명되었습니다.", "Korean");
        KOREAN_KR = LanguageTranslation("ko", unicode"이 지갑은 도난당한 것으로 서명되었습니다.", "Korean (KR)");
        LATIN = LanguageTranslation("la", unicode"Hoc peram est signati ut furto.", "Latin");
        LATVIAN = LanguageTranslation("lv", unicode"Šis maciņš ir parakstīts kā nozagts.", "Latvian");
        LITHUANIAN = LanguageTranslation("lt", unicode"Ši piniginė buvo pasirašyta kaip pavogta.", "Lithuanian");
        LUXEMBOURGISH = LanguageTranslation(
            "lb",
            unicode"Dëse Portemonnaie gouf ënnerschriwwen wéi geklaut.",
            "Luxembourgish"
        );
        FYRO_MACEDONIAN = LanguageTranslation("mk", unicode"Овој паричник е потпишан како украден.", "Fyro Macedonian");
        MALAY = LanguageTranslation("ms", unicode"Dompet ini telah ditandatangani sebagai dicuri.", "Malay");
        MALAYALAM = LanguageTranslation("ml", unicode"ഈ വാലറ്റ് മോഷ്ടിച്ചതായി ഒപ്പിട്ടു.", "Malayalam");
        MALTESE = LanguageTranslation("mt", unicode"Din il-kartiera ġiet iffirmata bħala misruqa.", "Maltese");
        MAORI = LanguageTranslation("mi", unicode"Kua hainatia tenei putea ki te tahaetia.", "Maori");
        MARATHI = LanguageTranslation("mr", unicode"या पाकीटात चोरी म्हणून स्वाक्षरी केली गेली आहे.", "Marathi");
        MOLDAVIAN = LanguageTranslation("mo", unicode"Acest portofel a fost semnat ca fiind furat.", "Moldavian");
        NEPALI = LanguageTranslation("ne", unicode"यो वालेट चोरीको रूपमा हस्ताक्षर गरिएको छ।", "Nepali");
        NORWEGIAN = LanguageTranslation("no", unicode"Denne lommeboken er signert som stjålet.", "Norwegian");
        ORIYA = LanguageTranslation("or", unicode"ଏହି ୱାଲେଟ୍ ଚୋରି ହୋଇଥିବା ପରି ଦସ୍ତଖତ ହୋଇଛି |", "Oriya");
        PERSIAN = LanguageTranslation("fa", unicode"این کیف پول به عنوان دزدیده شده امضا شده است.", "Persian");
        POLISH = LanguageTranslation("pl", unicode"Ten portfel został podpisany jako skradziony.", "Polish");
        PORTUGUESE = LanguageTranslation("pt", unicode"Esta carteira foi assinada como roubada.", "Portuguese");
        PORTUGUESE_BR = LanguageTranslation("pt", unicode"Esta carteira foi assinada como roubada.", "Portuguese (BR)");
        PUNJABI = LanguageTranslation("pa", unicode"ਇਹ ਬਟੂਆ ਚੋਰੀ &apos;ਤੇ ਦਸਤਖਤ ਕੀਤੇ ਗਏ ਹਨ.", "Punjabi");
        ROMANIAN = LanguageTranslation("ro", unicode"Acest portofel a fost semnat ca fiind furat.", "Romanian");
        RUSSIAN = LanguageTranslation("ru", unicode"Этот кошелек был подписан как украденный.", "Russian");
        SCOTS_GAELIC = LanguageTranslation(
            "gd",
            unicode"Chaidh an wallet seo a shoidhnigeadh mar a chaidh a ghoid.",
            "Scots Gaelic"
        );
        SINDHI = LanguageTranslation("sd", unicode"هي والٽ چوري طور تي دستخط ڪيو ويو آهي.", "Sindhi");
        SINGHALESE = LanguageTranslation("si", unicode"මෙම මුදල් පසුම්බිය සොරකම් කළ පරිදි අත්සන් කර ඇත.", "Singhalese");
        SERBIAN = LanguageTranslation("sr", unicode"Овај новчаник је потписан као украден.", "Serbian");
        SLOVAK = LanguageTranslation("sk", unicode"Táto peňaženka bola podpísaná ako ukradnutá.", "Slovak");
        SLOVENIAN = LanguageTranslation("sl", unicode"Ta denarnica je podpisana kot ukradena.", "Slovenian");
        SOMANI = LanguageTranslation("so", unicode"Boorsadan waxaa loo saxeexay sidii la xaday.", "Somani");
        SPANISH = LanguageTranslation("es", unicode"Esta billetera ha sido firmada como robada.", "Spanish");
        SPANISH_MX = LanguageTranslation("es", unicode"Esta billetera ha sido firmada como robada.", "Spanish (MX)");
        SPANISH_ES = LanguageTranslation("es", unicode"Esta billetera ha sido firmada como robada.", "Spanish (ES)");
        SWAHILI = LanguageTranslation("sw", unicode"Mkoba huu umesainiwa kama ulioibiwa.", "Swahili");
        SWEDISH = LanguageTranslation("sv", unicode"Denna plånbok har undertecknats som stulen.", "Swedish");
        TAMIL = LanguageTranslation("ta", unicode"இந்த பணப்பையை திருடியதாக கையொப்பமிடப்பட்டுள்ளது.", "Tamil");
        TATAR = LanguageTranslation("tt", unicode"Бу капчык урланган кебек кул куелган.", "Tatar");
        TELUGA = LanguageTranslation("te", unicode"ఈ వాలెట్ దొంగిలించబడినట్లు సంతకం చేయబడింది.", "Teluga");
        THAI = LanguageTranslation("th", unicode"กระเป๋าเงินนี้ได้รับการลงนามว่าถูกขโมย", "Thai");
        TURKISH = LanguageTranslation("tr", unicode"Bu cüzdan çalındı.", "Turkish");
        TURKMEN = LanguageTranslation("tk", unicode"Bu gapjyk ogurlanan hökmünde gol çekildi.", "Turkmen");
        UKRAINIAN = LanguageTranslation("uk", unicode"Цей гаманець був підписаний як викрадений.", "Ukrainian");
        URDU = LanguageTranslation("ur", unicode"اس پرس کو چوری کے طور پر دستخط کیا گیا ہے۔", "Urdu");
        VIETNAMESE = LanguageTranslation("vi", unicode"Ví này đã được ký kết là bị đánh cắp.", "Vietnamese");
        WELSH = LanguageTranslation(
            "cy",
            unicode"Mae&apos;r waled hon wedi&apos;i llofnodi fel un wedi&apos;i dwyn.",
            "Welsh"
        );
        XHOSA = LanguageTranslation("xh", unicode"Le wallet ityikitywe njengebiwe.", "Xhosa");
        YIDDISH = LanguageTranslation("ji", unicode"די בייַטל איז געחתמעט ווי סטאָלען.", "Yiddish");
        ZULU = LanguageTranslation("zu", unicode"Lesi sikhwama sesisayiniwe njengebiwe.", "Zulu");
    }
}
