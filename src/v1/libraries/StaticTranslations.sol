pragma solidity ^0.8.14;

struct LanguageTranslation {
    string languageCode;
    string sentence;
    string language;
}

library StaticTranslations {
    function english() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("en", "This wallet is a signed contract.", "English (US)");
    }

    function french() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("fr", unicode"Ce portefeuille a été signé comme volé.", "French");
    }

    function french_fr() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("fr", unicode"Ce portefeuille a été signé comme volé.", "French (FR)");
    }

    function chinese() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("zh", unicode"这个钱包已被盗。", "Chinese");
    }

    function chinese_hk() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("zh", unicode"這個錢包已被盜。", "Chinese (HK)");
    }

    function chinese_cn() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("zh", unicode"这个钱包已被盗。", "Chinese (CN)");
    }

    function chinese_tw() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("zh", unicode"這個錢包已被盜。", "Chinese (TW)");
    }

    function catalan() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ca", unicode"Aquesta cartera ha estat signada com a robada.", "Catalan");
    }

    function korean() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ko", unicode"이 지갑은 도난당한 것으로 서명되었습니다.", "Korean");
    }

    function czech() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("cs", unicode"Tato peněženka byla podepsána jako ukradená.", "Czech");
    }

    function danish() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("da", unicode"Denne tegnebog er blevet underskrevet som stjålet.", "Danish");
    }

    function dutch() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("nl", unicode"Deze portemonnee is ondertekend als gestolen.", "Dutch");
    }

    function english_ca() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("en", unicode"This wallet has been signed as stolen.", "English (CA)");
    }

    function english_gb() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("en", unicode"This wallet has been signed as stolen.", "English (GB)");
    }

    function english_us() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("en", unicode"This wallet has been signed as stolen.", "English (US)");
    }

    function finnish() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("fi", unicode"Tämä lompakko on allekirjoitettu varastettuna.", "Finnish");
    }

    function greek() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("el", unicode"Αυτό το πορτοφόλι έχει υπογραφεί ως κλεμμένο.", "Greek");
    }

    function hebrew() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("he", unicode"הארנק הזה נחתם כגנוב.", "Hebrew");
    }

    function hindi() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("hi", unicode"इस बटुए को चोरी के रूप में हस्ताक्षरित किया गया है।", "Hindi");
    }

    function icelandic() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("is", unicode"Þetta veski hefur verið undirritað sem stolið.", "Icelandic");
    }

    function italian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("it", unicode"Questo portafoglio è stato firmato come rubato.", "Italian");
    }

    function japanese() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ja", unicode"このウォレットは盗まれたものとして署名されています。", "Japanese");
    }

    function korean_kr() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ko", unicode"이 지갑은 도난당한 것으로 서명되었습니다.", "Korean (KR)");
    }

    function latin() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("la", unicode"Hoc peram est signati ut furto.", "Latin");
    }

    function latvian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("lv", unicode"Šis maciņš ir parakstīts kā nozagts.", "Latvian");
    }

    function lithuanian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("lt", unicode"Ši piniginė buvo pasirašyta kaip pavogta.", "Lithuanian");
    }

    function luxembourgish() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("lb", unicode"Dëse Portemonnaie gouf ënnerschriwwen wéi geklaut.", "Luxembourgish");
    }

    function norwegian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("no", unicode"Denne lommeboken er signert som stjålet.", "Norwegian");
    }

    function persian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("fa", unicode"این کیف پول به عنوان دزدیده شده امضا شده است.", "Persian");
    }

    function portuguese() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("pt", unicode"Esta carteira foi assinada como roubada.", "Portuguese");
    }

    function portuguese_br() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("pt", unicode"Esta carteira foi assinada como roubada.", "Portuguese (BR)");
    }

    function romanian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ro", unicode"Acest portofel a fost semnat ca fiind furat.", "Romanian");
    }

    function russian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ru", unicode"Этот кошелек был подписан как украденный.", "Russian");
    }

    function serbian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("sr", unicode"Овај новчаник је потписан као украден.", "Serbian");
    }

    function slovak() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("sk", unicode"Táto peňaženka bola podpísaná ako ukradnutá.", "Slovak");
    }

    function slovenian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("sl", unicode"Ta denarnica je podpisana kot ukradena.", "Slovenian");
    }

    function spanish() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("es", unicode"Esta billetera ha sido firmada como robada.", "Spanish");
    }

    function spanish_mx() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("es", unicode"Esta billetera ha sido firmada como robada.", "Spanish (MX)");
    }

    function spanish_es() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("es", unicode"Esta billetera ha sido firmada como robada.", "Spanish (ES)");
    }

    function swedish() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("sv", unicode"Denna plånbok har undertecknats som stulen.", "Swedish");
    }

    function thai() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("th", unicode"กระเป๋าเงินนี้ได้รับการลงนามว่าถูกขโมย", "Thai");
    }

    function ukrainian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("uk", unicode"Цей гаманець був підписаний як викрадений.", "Ukrainian");
    }

    function albanian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("sq", unicode"Kjo portofol është nënshkruar si e vjedhur.", "Albanian");
    }

    function arabic() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ar", unicode"وقد تم توقيع هذه المحفظة كما سرقت.", "Arabic");
    }

    function armenian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("hy", unicode"Այս դրամապանակը ստորագրվել է որպես գողացված:", "Armenian");
    }

    function azerbaijani() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("az", unicode"Bu cüzdan oğurlanmış kimi imzalanmışdır.", "Azerbaijani");
    }

    function basque() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("eu", unicode"Zorro hau lapurtu bezala sinatu da.", "Basque");
    }

    function bulgarian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("bg", unicode"Този портфейл е подписан като откраднат.", "Bulgarian");
    }

    function german() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("de", unicode"Diese Brieftasche wurde als gestohlen unterschrieben.", "German");
    }

    function german_de() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("de", unicode"Diese Brieftasche wurde als gestohlen unterschrieben.", "German (DE)");
    }

    function indonesian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("id", unicode"Dompet ini telah ditandatangani sebagai dicuri.", "Indonesian");
    }

    function belarusian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("be", unicode"Гэты кашалёк быў падпісаны як скрадзены.", "Belarusian");
    }

    function bengali() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("bn", unicode"এই মানিব্যাগটি চুরি হিসাবে স্বাক্ষরিত হয়েছে।", "Bengali");
    }

    function bosnian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("bs", unicode"Ovaj novčanik je potpisan kao ukraden.", "Bosnian");
    }

    function burmese() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("my", unicode"ဒီပိုက်ဆံအိတ်ခိုးယူအဖြစ်လက်မှတ်ရေးထိုးခဲ့သည်။", "Burmese");
    }

    function corsican() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("co", unicode"Questa billetera hè stata firmata cum&apos;è arrubata.", "Corsican");
    }

    function croatian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("hr", unicode"Ovaj je novčanik potpisan kao ukraden.", "Croatian");
    }

    function esperanto() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("eo", unicode"Ĉi tiu monujo estis subskribita kiel ŝtelita.", "Esperanto");
    }

    function estonian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("et", unicode"See rahakott on allkirjastatud varastatud.", "Estonian");
    }

    function farsi() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("fa", unicode"این کیف پول به عنوان دزدیده شده امضا شده است.", "Farsi");
    }

    function frisian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("fy", unicode"Dizze slaget is tekene as stellen.", "Frisian");
    }

    function gaelic() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("gd", unicode"Chaidh an wallet seo a shoidhnigeadh mar a chaidh a ghoid.", "Gaelic");
    }

    function galacian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("gl", unicode"Esta carteira foi asinada como roubada.", "Galacian");
    }

    function georgian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ka", unicode"ეს საფულე გაფორმდა როგორც მოპარული.", "Georgian");
    }

    function afrikaans() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("af", "Hierdie beursie is as gesteel onderteken.", "Afrikaans");
    }

    function gujurati() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("gu", unicode"આ વ let લેટ પર ચોરીની જેમ હસ્તાક્ષર કરવામાં આવ્યા છે.", "Gujurati");
    }

    function haitian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ht", unicode"Sa a te bous sa a te siyen kòm yo vòlè li.", "Haitian");
    }

    function hungarian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("hu", unicode"Ezt a pénztárcát ellopták.", "Hungarian");
    }

    function irish() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ga", unicode"Tá an sparán seo sínithe mar goidte.", "Irish");
    }

    function kannada() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("kn", unicode"ಈ ಕೈಚೀಲವನ್ನು ಕಳವು ಮಾಡಿದಂತೆ ಸಹಿ ಮಾಡಲಾಗಿದೆ.", "Kannada");
    }

    function kazakh() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("kk", unicode"Бұл әмиян ұрланған деп қол қойылды.", "Kazakh");
    }

    function khmer() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("km", unicode"កាបូបនេះត្រូវបានចុះហត្ថលេខាថាត្រូវបានគេលួច។", "Khmer");
    }

    function kirghiz() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ky", unicode"Бул капчыкты уурдап кетишкен.", "Kirghiz");
    }

    function fyro_macedonian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("mk", unicode"Овој паричник е потпишан како украден.", "Fyro Macedonian");
    }

    function malay() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ms", unicode"Dompet ini telah ditandatangani sebagai dicuri.", "Malay");
    }

    function malayalam() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ml", unicode"ഈ വാലറ്റ് മോഷ്ടിച്ചതായി ഒപ്പിട്ടു.", "Malayalam");
    }

    function maltese() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("mt", unicode"Din il-kartiera ġiet iffirmata bħala misruqa.", "Maltese");
    }

    function maori() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("mi", unicode"Kua hainatia tenei putea ki te tahaetia.", "Maori");
    }

    function marathi() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("mr", unicode"या पाकीटात चोरी म्हणून स्वाक्षरी केली गेली आहे.", "Marathi");
    }

    function moldavian() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("mo", unicode"Acest portofel a fost semnat ca fiind furat.", "Moldavian");
    }

    function nepali() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ne", unicode"यो वालेट चोरीको रूपमा हस्ताक्षर गरिएको छ।", "Nepali");
    }

    function oriya() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("or", unicode"ଏହି ୱାଲେଟ୍ ଚୋରି ହୋଇଥିବା ପରି ଦସ୍ତଖତ ହୋଇଛି |", "Oriya");
    }

    function polish() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("pl", unicode"Ten portfel został podpisany jako skradziony.", "Polish");
    }

    function punjabi() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("pa", unicode"ਇਹ ਬਟੂਆ ਚੋਰੀ &apos;ਤੇ ਦਸਤਖਤ ਕੀਤੇ ਗਏ ਹਨ.", "Punjabi");
    }

    function scots_gaelic() internal pure returns (LanguageTranslation memory) {
        return
            LanguageTranslation(
                "gd",
                unicode"Chaidh an wallet seo a shoidhnigeadh mar a chaidh a ghoid.",
                "Scots Gaelic"
            );
    }

    function sindhi() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("sd", unicode"هي والٽ چوري طور تي دستخط ڪيو ويو آهي.", "Sindhi");
    }

    function singhalese() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("si", unicode"මෙම මුදල් පසුම්බිය සොරකම් කළ පරිදි අත්සන් කර ඇත.", "Singhalese");
    }

    function somani() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("so", unicode"Boorsadan waxaa loo saxeexay sidii la xaday.", "Somani");
    }

    function swahili() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("sw", unicode"Mkoba huu umesainiwa kama ulioibiwa.", "Swahili");
    }

    function tamil() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ta", unicode"இந்த பணப்பையை திருடியதாக கையொப்பமிடப்பட்டுள்ளது.", "Tamil");
    }

    function tatar() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("tt", unicode"Бу капчык урланган кебек кул куелган.", "Tatar");
    }

    function teluga() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("te", unicode"ఈ వాలెట్ దొంగిలించబడినట్లు సంతకం చేయబడింది.", "Teluga");
    }

    function turkish() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("tr", unicode"Bu cüzdan çalındı.", "Turkish");
    }

    function turkmen() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("tk", unicode"Bu gapjyk ogurlanan hökmünde gol çekildi.", "Turkmen");
    }

    function urdu() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ur", unicode"اس پرس کو چوری کے طور پر دستخط کیا گیا ہے۔", "Urdu");
    }

    function vietnamese() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("vi", unicode"Ví này đã được ký kết là bị đánh cắp.", "Vietnamese");
    }

    function welsh() internal pure returns (LanguageTranslation memory) {
        return
            LanguageTranslation(
                "cy",
                unicode"Mae&apos;r waled hon wedi&apos;i llofnodi fel un wedi&apos;i dwyn.",
                "Welsh"
            );
    }

    function xhosa() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("xh", unicode"Le wallet ityikitywe njengebiwe.", "Xhosa");
    }

    function yiddish() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("ji", unicode"די בייַטל איז געחתמעט ווי סטאָלען.", "Yiddish");
    }

    function zulu() internal pure returns (LanguageTranslation memory) {
        return LanguageTranslation("zu", unicode"Lesi sikhwama sesisayiniwe njengebiwe.", "Zulu");
    }
}
