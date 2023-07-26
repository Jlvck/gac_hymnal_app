import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './hymn.dart';

class HymnBook with ChangeNotifier {
  static const String prefKey = "favList";

  List<String> favStringList = [];

  //simple manipulation i did to ensure when
  //the fav button is clicked in favorite screen the effect is rapid
  bool tapFavBut = false;
  void changeFavBut() {
    tapFavBut = !tapFavBut;
    notifyListeners();
  }

  //adding an id to favorite list of id
  void addPrefFav(String id) {
    favStringList.add(id);
  }

  //removing an id to favorite list of id
  void removePrefFav(String id) {
    favStringList.remove(id);
  }

  //called upon when the favorite button is clicked
  //it runs the mechanism for adding or removing an id from favorites list
  void checkfav(String id) {
    if (favStringList.contains(id)) {
      removePrefFav(id);
    } else {
      addPrefFav(id);
    }
    addListtoSF(favStringList);
    print(favStringList);
  }

  //overwrite the saved shared preferences intance with another
  void addListtoSF(List<String> fav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefKey, favStringList);
  }

  //setting the saved list of favorites to the value
  //only called once when the app starts and used during the splash screen
  void setListtoSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favStringList = prefs.getStringList(prefKey) ?? [];
    notifyListeners();
  }

  // Screen Function for the Slash screen which works by setting saved
  //shared preferences intances of  list of ids of favorite hymn list
  void setFavHymnList() async {
    List<Hymn> pre = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> fav = prefs.getStringList(prefKey) ?? [];

    //filtering mechanism of list of hymns that are saved as favorites
    for (Hymn hymn in _hymnBook) {
      if (fav.contains(hymn.id)) {
        hymn.isFavorites = true;
        pre.add(hymn);
      } else {
        pre.add(hymn);
      }
    }

    _hymnBook = pre;
    notifyListeners();
  }

  //function required to fetch hymn from
  //the original hymn from search operations
  Hymn getHymn(String hymnNumber) {
    return _hymnBook.firstWhere((hymn) => hymn.id == hymnNumber);
  }

  //Returning List of Favavorite Hymn List to Favorite Screen
  List<Hymn> get favHymnList {
    List<Hymn> favList =
        _hymnBook.where((hymn) => hymn.isFavorites == true).toList();
    return favList;
  }

  //Returning a copy of original List
  List<Hymn> get hymnList {
    return [..._hymnBook];
  }

  //The Original List of Hymn
  List<Hymn> _hymnBook = [
    Hymn(
      id: '1',
      verses: [
        [
          "Ji okan mi, ba oorun ji ",
          "Mura si işe ojo re:",
          "Maşe ilora, ji kutu,",
          "K'o san gbese ebo oro.",
        ],
        [
          "Ogo fun Enit' o so mi.",
          "To tu mi l'ara loj' orun;",
          "Oluwa ijo mo ba sun",
          "Ji mi s'aiye ainipekun.",
        ],
        [
          "Oluwa mo tun eje je ",
          "Tu eşe ka b' iri oro",
          "So akoro nu mi oni",
          "Si f' Emi Re kun inu mi",
        ],
        [
          "Oro, at işe mi oni",
          "Ki nwon le ri bi oko Rę",
          "K' emi si f' ipa mi gbogbo",
          "Sise rere fun ogo Re",
        ],
        [
          "Ji, gbon 'ra nu, 'wo okan mi",
          "Yan ipo re l'arin Angel'",
          "Awon ti nwon nkorin lyin",
          "Ni gbogbo oru s' Oba wa.",
        ],
        [
          "Ro gbogb' ojo t'o fi sofo",
          "Bere si rere 'se loni:",
          "Kiyes' irin' re l'alye yi:",
          "K'o si mura d' ojo nla ni.",
        ],
        [
          "Gba ninu imolęorun,",
          "Si tanmolęnå f' elomi:",
          "Je ki ogo Olorun re",
          "Han n'nu iwa at' işe rę.",
        ],
        [
          "Yin Olorun ibu ore:",
          "E yin, enyin ęda aiye",
          "E yin, enyin eda orun",
          "Yin Baba, Omo on Emi.",
        ]
      ],
      isChorus: false,
      chorus: [""],
    ),
    Hymn(
      id: '2',
      verses: [
        [
          "Oluwa mi, mo njade lo.",
          "Lati se isc ojo mi.",
          "Iwo nikan l'emi o mo.",
          "L'oro l'ero; ati n' işe.",
        ],
        [
          "Ise t'O yan mi, l' anu Re",
          "Jęki nie şe tayotayo:",
          "Ki nr' oju Re ni iSe mi,",
          "Kemi si le f' ife Re han.",
        ],
        [
          "Dabobo mi lowo 'danwo,",
          "K'o pa okan mi mo kuro",
          "L'owo aniyan aiye yi,",
          "Ati gbogbo ifękufe.",
        ],
        [
          "Iwo t' oju Re r' okan mi,",
          "Maa wa low' otun mi titi,",
          "Ki nmaa şişe lo l'ase Re.",
          "Ki nf' işe mi gbogbo fun O.",
        ],
        [
          "Je kl nreru Re t'o fuye",
          "Ki nmaa sora nigba gbogbo,",
          "Ki nma f' oju si nkan t' orun,",
          "Ki nst mura d' ojo ogo:",
        ],
        [
          "Ohunkohun t'O fi fun mi",
          "Jeki nle lõ fun ogo",
          "Re Ki nf'ayo sure ije mi,",
          "Ki mba O rin titi d' orun.",
        ]
      ],
      isChorus: false,
      chorus: [""],
    ),
    Hymn(
      id: '3',
      verses: [
        [
          "Wa s'odo mi, Oluwa mi,",
          "Ni kutukutu owuro,",
          "Mu k' ero rere so jade,",
          "Lat' inu mi soke grun.",
        ],
        [
          "Wa s' odo mi,Oluwa mi,",
          "Ni wakati osan gangan,",
          "Ki 'yonu ma ba se mi mo",
          "Nwon a si s' qsan mid' oru.",
        ],
        [
          "Wa s' odo mi, Oluwa mi,",
          "Nigbati ale ba nle lo",
          "Bi okan mi ba nşako lo",
          "Muu pada, f' oju 're wo mi.",
        ],
        [
          "Wa s' odo mi, Oluwa mi.",
          "Li oru, nigbati orun p",
          "Ko woju mi: je k'okan mi",
          "Ri 'simi je li aiya Re.",
        ],
        [
          "Wa s'odo mi, Oluwa mi",
          "Ni gbogbo ojo atye mi:",
          "Nigbati emi mi ba lo.",
          "Ki nie n' tbugbe lodo Re.",
        ]
      ],
      isChorus: false,
      chorus: [""],
    ),
    Hymn(
      id: '4',
      verses: [
        [
          "Wa s'adura ooro,",
          "Kunle k'a gbadura,",
          "Adura ni opa Kristian,",
          "Lati b' Olorun rin.",
        ],
        [
          "Losan, wolę labe",
          "Apat' atyeraiye,",
          "Itura ofiji Rę dun",
          "Nigbat' orun ba mu.",
        ],
        [
          "Je ki gbogbo ile",
          "Wa gba 'dura l' ale,",
          "Ki ile wa di t' Olorun",
          "Ati 'bode run.",
        ],
        [
          "Nigbat' o d'oganjo",
          "Je k'a wi l'emi, pe",
          "Mo sun sugbon okan mi ji",
          "Lati ba O sona",
        ]
      ],
      isChorus: false,
      chorus: [""],
    ),
    Hymn(
      id: '5',
      verses: [
        [
          "Imole ooro didun yi",
          "Ji mi nin' orun mi",
          "Baba, ife Tire nikan",
          "L'o pa omo Rę mo.",
        ],
        [
          "Ni gbogbo oni, mo bę O.",
          "Maa şe Oluso mi.",
          "Dariji mi, Jesu mimo",
          "Ki 'm je Tire loni.",
        ],
        [
          "Wa şe 'bugbe Rę ninu mi,",
          "Emi ore-ofę!",
          "So mi di mimo laiye yi,",
          "K' emi le r' oju Re.",
        ],
      ],
      isChorus: false,
      chorus: [""],
    ),
    Hymn(
      id: '6',
      verses: [
        [
          "Baba mi, gbo t' emi",
          "Wo ni Alaabo mi",
          "Maa sunmo mi titi,",
          "Oninure julo.",
        ],
        [
          "Jesu, Oluwa mi,",
          "Iye at' ogo mi",
          "Ki 'gba na yara de,",
          "Ti ngo de odo Re.",
        ],
        [
          "Olutunu julo,",
          "'Wo ti ngbe inu mi,",
          "'Wo t'o mo aini mi,",
          "Fa mi, k' o si gba mi",
        ],
        [
          "Mimo, Mimo, Mimo",
          "Má fi mi silęlai",
          "Se mi n'ibugbe Re",
          "Tire nikan lailai.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '7',
      verses: [
        [
          "Ninu gbogbo ewu oru,",
          "Oluwa l'o so mi:",
          "A wa si tun ri 'mole yi",
          "A tun tęekun ba.",
        ],
        [
          "Oluwa, pa wa mo loni,",
          "Fi apa Re so wa:",
          "Kiki awon ti Wo pamo.",
          "L'o nyo ninu ewu.",
        ],
        [
          "K'oro wa ati iwa wa",
          "Wipe Tire l' awa:",
          "Tobęt' imolęotito",
          "Le tan loju aiye.",
        ],
        [
          "Má je k'a pada lodo",
          "Re Olugbala owon:",
          "Titi a of' oju wa ri",
          "Oju re li opin.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '8',
      verses: [
        [
          "Krist, Ologo, Olola,",
          "Iwo Imole aiye,",
          "Orun ododo, dide,",
          "K'o si bori okunkun;",
          "'Molęoro, sun-mo mi",
          "'Rawo oro, w' aiya mi",
        ],
        [
          "Okukun l' owuro je",
          "B' Iwo ko pelu ręwa :",
          "Ailayo l' ojo yi je.",
          "B'anu ko tan 'molęmi",
          "Fun mi n' imolęJesu.",
          "M' okan mi gbogbo gbona:",
        ],
        [
          "Wa bęokan mi yi wo,",
          "Le okunkun se lo:",
          "F' imole orun kun mi,",
          "Si tu aigbagbo mi ka.",
          "Mã f' ara Re han mi si,",
          "Si ma ràn b' osangangan.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '9',
      verses: [
        [
          "Jesu, Oorun ododo,",
          "Iwo imolę ife.",
          "Gbati 'mole owuro",
          "Ba nt' ila orun tan wa,",
          "Tan mole ododo Re",
          "Yi wa ka.",
        ],
        [
          "Gege bi tri ti nse",
          "Sori eweko gbogbo,",
          "K' Emi ore-ofe Re",
          "So okan wa di otun:",
          "Ro ojo ibukun Re",
          "Sori wa.",
        ],
        [
          "B' imole oorun ti nran,",
          "K' imolę ife Tire.",
          "Si må gbona l' okan wa,",
          "K'o si mu wa l' ara ya,",
          "K'a le ma f' ayo sin O",
          "Laiye wa.",
        ],
        [
          "Amona, ireti wa,",
          "Ma fi wa silę titi,",
          "Fi wa s' abe iso Re.",
          "Titi opin aiye wa",
          "Sin wa la ajo wa ja",
          "S'ile wa.",
        ],
        [
          "Pa wa mo n'nu ifę Rę",
          "L'ojo alye wa gbogbo,",
          "Si mu wa bori iku,",
          "Mu wa de 'le ayo na,",
          "K'a le ba 'won mimo gba",
          "Isimi",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '10',
      verses: [
        [
          "Ogo f'Olorun l'ale yi",
          "Fun gbogbo ōre imole",
          "So mi Oba awon oba",
          "L'abe ofiji iye Re.",
        ],
        [
          "Oluwa, f' eşe mi ji mi,",
          "Nitori Omo Re loni:",
          "K' emi le wa l' Alafia",
          "Pelu Iwo ati aiye.",
        ],
        [
          "Jek' okan mi le sun le O.",
          "K' orun didun p' oju mi de",
          "Orun tl y'o m'ara mi le",
          "Ki nle sin O li owuro.",
        ],
        [
          "Bi mo ba dubulę laisun,",
          "F'ero orun kun okan mi,",
          "Maję ki nlala buburu",
          "Maję  k' ipa okun bo mi.",
        ],
        [
          "Yin Oluwa, gbogbo eda,",
          "Ti mbę nisalę aiye yi :",
          "E yin loke, eda orun",
          "Yin Baba, Omo, on Emi.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
        id: '11',
        verses: [
          [
            "Ife Re da wa si l'oni",
            "L'are a si dubulę,",
            "Mã so wa ni'dakę oru,",
            "K'ota ma yo wa l'enu:",
            "Jesu, şe olutoju wa,",
            "Iwo l' o dun gbekele.",
          ],
          [
            "Ero at' alejo l' aiye,",
            "A ngb' arin awon ota",
            "Yo wa, at' ile wa l' ewu,",
            "L'apa Re ni k' a sun si;",
            "N' ijo iyonu alye pin,",
            "K' a le simi l'odo Re.",
          ]
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '12',
        verses: [
          [
            "Wa ba mi gbe ale fere le tan:",
            "Okunkun nşu; Oluwa, ba mi gbe;",
            "Bi oluranlowo miran ba ye",
            "Iranwo alaini, wa ba mi gbe.",
          ],
          [
            "Ojo alye mi nsare lo s' opin,",
            "Ayo alye nku, ogo re nwomi,",
            "Ayida at' iba je ni mo nri,",
            "'Wo ti ki yipada wa ba mi gbe.",
          ],
          [
            "Má wa l' eru b' Oba awon oba",
            "Sugbon ki o mã bo b' oninure,",
            "Ki o si ma kanu fun egbe mi Wȧ,",
            "Ore elese, wa ba mi gbe.",
          ],
          [
            "Mo nfe Q ri, ni wakati gbogbo :",
            "Ki lo le segun eşu b' ore Re?",
            "Tal' o le șe amona mi bi Rę?",
            "N'nu 'banuje at' ayo ba mi gbe.",
          ],
          [
            "Pelu 'bukun Re, eru ko ba mi,",
            "Ibi ko wuwo, ękun ko koro,",
            "Oro iku da? 'Şegun isa da?",
            "Ngo segun sibę bi 'Wo ba mi gbe.",
          ],
          [
            "Wa ba mi gbe ni wakati sisun",
            "Şe' molę mi, si toka si orun",
            "B' aiye ti nkoja, k' ilę orun mo",
            "Ni yiye, ni sisun, wa ba mi gbe."
          ],
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: "13",
        verses: [
          [
            "Iwo Imole okan mi,",
            "Li odo Rę oru ko si,",
            "Ki kuku aiye ma bo O,",
            "Kuro l'oju iranşe Rę.",
          ],
          [
            "Nigbat' oorun alę didun",
            "Ba npa ipenpeju mi de,",
            "K' ero mi je lati simi",
            "Lai l' alya Olugbala mi.",
          ],
          [
            "Ba mi gbe l' oro tit' ale",
            "Laisi Re emi ko le wa,",
            "Ba mi gbe gbat' ile ba nşu,",
            "Laisi Re emi ko le sun.",
          ],
          [
            "Botoşi omo Re kan",
            "Bu tapa s' oro Re loni,",
            "Oluwa şişe ore Re.",
            "Ma je k'o sun ninu eşę.",
          ],
          [
            "Bukun fun awon alaisan,",
            "Pese fun awon talaka,",
            "K' orun alawè l' ale yi,",
            "Dabi orun omo titun.",
          ],
          [
            "Sure fun wa nigbat' a ji",
            "K'a to m' ohun alye yi şe",
            "Titi awa o de b' ifę",
            "T'a o st de ijoba Rę.",
          ]
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '14',
        verses: [
          [
            "L'oju ale 'gbat' orun wo,",
            "Nwon gbe abirun w' odo Rę,",
            "Oniruru ni aisan won",
            "Sugbon nwon f' ayo lo 'le won.",
          ],
          [
            "Jesu a de loj ale yi",
            "A sunmo O. t' awa t' arun wa,",
            "Bi a ko tilę le ri O",
            "Sugbon a mo p'O sunmo wa.",
          ],
          [
            "Olugbala, wo oşi wa,",
            "Omi ko san, mi 'banuje.",
            "Omi ko ni ife si O.",
            "Ife elomi si tutu.",
          ],
          [
            "Omi mo pe asan l' aiye",
            "Beni nwon ko f' alye sile,",
            "Omi l' orę ti ko se 're,",
            "Beni nwon ko fi O ş' ore.",
          ],
          [
            "Ko s' okan ninu wa to pe",
            "Gbogbo wa si ni eleşe,",
            "Awon t'o si nsin O toto",
            "Mo ara won ni alaipe.",
          ],
          [
            "Sugbon Jesu Olugbala,",
            "Eni bi awa ni 'Wo şe,",
            "'Wo ti ri 'danwo bi awa,",
            "'Wo si ti mo ailera wa.",
          ],
          [
            "Agbar' owo Re wa sibę,",
            "Ore Re si ni agbara,",
            "Gbo adura alę wa yi",
            "Ni anu, wo gbogbo wa san."
          ]
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '15',
        verses: [
          [
            "'Wo imole larin ookun aiye,",
            "Må sin mi lo.",
            "Okunkun şu, mo si jina sile",
            "Má sin mi lo.",
            "To 'şisę mi: ohun chin ola",
            "'Mi ko bere: şişe kan to fun mi.",
          ],
          [
            "Nigbakan ri, emi ko bę O pe",
            "Mã sin mi lo:",
            "Bę ni nko fę O: sugbon nigbayi",
            "Mã sin mi lo:",
            "Afę aiye ni mo ti nto le-hin",
            "Sugbon Jesu, má ranti igbani."
          ],
          [
            "Ipa Re l'o ti ndi mi mu, y' o si",
            "Mã sin mi lọ:",
            "Ninu erę ati yangi aiye,",
            "Mã sin mi lo",
            "Titi em' o fi ri awon wonni",
            "Ti mo fe, ti nwon ti f' aiye silę.",
          ]
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '16',
        verses: [
          [
            "Jesu, bukun wa k'a to lo:",
            "Gbin oro Re si aiya wa,",
            "K'o si mu k' ife gbigbona",
            "Kun okan ilowowo wa",
            "Nigba lye at' iku wa,",
            "Jesu jare, se 'molę wa.",
          ],
          [
            "llę ti şu orun ti wo",
            "Wo si ti şiro iwa wa",
            "Die n' isegun wa loni",
            "Işubu wa l' o papoju:",
            "Nigba lye at' iku wa,",
            "Jesu jare, se 'molę wa.",
          ],
          [
            "Jesu, dariji wa; fun wa",
            "L'ayo ati eru mimo,",
            "At' okan ti ko l' abawon",
            "K'a ba le jo O l'ajotan:",
            "Nigba lye at' iku wa,",
            "Jesu jare, se 'molę wa.",
          ],
          [
            "Lala dun, tori 'Wo se ri;",
            "Aniyan ferę. O se ri.",
            "Ma je k'a gbo t' ara nikan",
            "K'a ma bo sinu idewo,",
            "Nigba lye at' iku wa,",
            "Jesu jare, se 'molę wa.",
          ],
          [
            "A mbę O f' awon alaini,",
            "Felese at' awon t' a fe.",
            "Je ki anu Re mu wa yo,",
            "'Wo Jesu, l' ohun gbogbo wa,",
            "Nigba lye at' iku wa,",
            "Jesu jare, se 'molę wa.",
          ],
          [
            "Jesu bukun wa ile şu,",
            "Tikalarę wa ba wa gbe,",
            "Angel' rere nşo ile wa,",
            "A tun f' ojo kan sunmo O.",
            "Nigba lye at' iku wa,",
            "Jesu jare, se 'molę wa.",
          ],
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '17',
        verses: [
          [
            "K'a to sun Olugbala wa,",
            "Fun wa n' ibukun alę :",
            "A jewo ese wa fun O,",
            "Iwo lo le gba wa la.",
          ],
          [
            "B' lle tile ti şu dudu,",
            "Ökün ko le se wa mo:",
            "Iwo eniti ki şarę",
            "Nso awon enia Re.",
          ],
          [
            "B'okunkun tile yi wa ka",
            "Ti ofa nfo wa koja,",
            "Awon Angeli yi wa ka,",
            "Awa o wa l' ailewu,",
          ],
          [
            "Nirelę awa f'ara wa",
            "S'abę abo Re, Baba,",
            "Jesu, Wo t' o sun bi awa,',",
            "Şe orun wa bi Tirę.",
          ],
          [
            "Emi Mimo rado bo wa,",
            "Tan 'molę s' okunkun wa",
            "Tit' awa o fi ri ojo",
            "Imolę.aiyeraiye.",
          ],
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '18',
        verses: [
          [
            "Oluwa ojo yi ti d'opin",
            "Okunkun si de l' aşe Re",
            "'Wo l' a korin owuro wa si,",
            "Iyin Re y'o m' ale wa dun.",
          ],
          [
            "A dupę ti ijo Rę ko nsun,",
            "B' alye ti nyi lo s'imple",
            "O si nşona ni gbogbo aiye,",
            "Ko si simi tosan-toru.",
          ],
          [
            "B' ile si ti nmo lo jojumo",
            "Ni orile at' ekuşu,",
            "Ohun adura ko dakę ri,",
            "Bę l' orin iyin ko dekun.",
          ],
          [
            "Oorùn t'o wo fun wa, si ti la",
            "S' awon eda iwo-oorùn,",
            "Nigbakugba li çnu si nso",
            "Işe 'yanu Re di mimo.",
          ],
          [
            "Be, Oluwa, lai n' ijoba Re:",
            "Ko dabi ijoba aiye;",
            "O duro, O si nşe akoso",
            "Tit' eda Rę o juba Rę.'",
          ],
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '19',
        verses: [
          [
            "Baba, a tun pade l'ooko Jesu,",
            "A si wa teriba lab' ese Re",
            "A tun fe gb' ohun wa soke, si O.",
            "Lati wa anu, lati korin 'yin.",
          ],
          [
            "A yin O fun itoju 'gbagbogbo",
            "Ojojumo l'a o ma rohin 'se Rę",
            "Wiwa laye wa, anu Re ha ko?",
            "Apa Re, ki O fi ngba ni mo'ra?",
          ],
          [
            "O şel a ko ye fun ie nla Rę",
            "A şako kuro lodo Rę poju,",
            "Sugbon kikankikan ni O si npe,",
            "Nje, a de, a pada wa 'le Baba.",
          ],
          [
            "Nipa ooko t'o bor' ohun gbogbo",
            "Nipa ife t'o ta fe gbogbo yo.",
            "Nipa eje ti a ta fun ese.",
            "Şilekun anu, si gbani si 'le.",
          ]
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '20',
        verses: [
          [
            "A gboju s' oke si O.",
            "At' owo, ati okan",
            "Tewogba adura wa,",
            "B'o tile se ailera",
          ],
          [
            "Oluwa je k'a mo O.",
            "Je k'a mo oruko Rę",
            "Je k' awa şe ife Re'",
            "Bi wọn ti nşe li orun.",
          ],
          [
            "Nigbati a sun loru,",
            "So wa, k'o duro ti wa;",
            "Nigbati ile si mo,',",
            "K'aj, k'a f' iyin fun O.",
          ],
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
      id: '21',
      verses: [
        [
          "Ojo oni lo tan,"
              "Oru sunmole:",
          "Okunkun ti de na,",
          "Ilę si ti şu."
        ],
        [
          "Okunkun bo ilę.",
          "Awon 'rawo yo:",
          "Eranko at' eiye.",
          "Lo si 'busun won.",
        ],
        [
          "Jesu f' orun didun",
          "F’ eni alare:",
          "Je ki ibukun Re",
          "Pa oju mi de.",
        ],
        [
          "Je k' omo kekere",
          "La ala rere;",
          "Ş' oloko t' ewu nwu",
          "Ni oju omi.",
        ],
        [
          "Mã toju alaisan",
          "Ti ko r' orun sun;",
          "Awon ti nro ibi,",
          "Jo da won l' ekun.",
        ],
        [
          "Ninu gbogbo oru,",
          "Je k' angeli Rę",
          "Mã şe oluşo mi,",
          "L'ori 'busun mi",
        ],
        [
          "'Gbat' ile ba si mo",
          "Je k' emi dide; ",
          "B' omo ti ko l' ese",
          "Ni iwaju Rę.",
        ],
        [
          "Ogo ni fun Baba,",
          "Ati fun Omo,",
          "Ati f' Emi Mimo,",
          "Lai ati lailai.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
        id: '22',
        verses: [
          [
            "Ojo oni koja lo;",
            "A dupę, Oluwa;",
            "Jo gba wa lowo ese",
            "Ni wakati oru:",
            "Jesu jo f' iso Re so wa, ",
            "Si mu wa la oru yi ja.",
          ],
          [
            "Ayo oni koja lo:",
            "A gb' okan wa soke",
            "Jo, má je k'a n' ikose",
            "Ni wakati oru:",
            "Jesu, jo fun wa ni 'molę. ",
            "Sa mu wa la oru yi ja.",
          ],
          [
            "Lälä oni koja lo:",
            "A fi orin yin O,",
            "Jo, má je k' a ri ewu,",
            "Jesu jo f' iso Re so wa,",
            "Si mu wa la oru yi ja.",
          ],
          [
            "S' Olupamo wa Baba, ",
            "N' tori Iwo l'o mo",
            "Gege b' ewu ti po to",
            "Ti a o ba pade,",
            "Jesu Olufe, gbo ti wa.",
            "Si mu wa la gbogbo won ja.",
          ],
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '23',
        verses: [
          [
            "Ooro didan ti rekoja",
            "Wawa l' akoko na fo lo; ",
            "Bi osan si ti nkoja lo",
            "N' ilę nşu bo.",
          ],
          [
            "Kukuru l' ojo aiye wa,",
            "Were l'osan re nde opin,",
            "Krist', 'Wo ti se ona iye,",
            "Sin wa de 'le.",
          ],
          [
            "Jo fi ore-ofę Rę nla ",
            "Gba okan wa b' ilu t'orun",
            "Je k'a mã wo le didan ni",
            "Ti mbę loke",
          ],
          [
            "Nibi 'molę, iye, ayo,",
            "At' alafia gbe njoba,",
            "T'awon angel ko dekun ko",
            "Orin iyin:",
          ],
          [
            "T'awon mimo wo 'so àlà,",
            "Ti okunkun alę k’ şu ",
            "Ti 'Wo Mole aiyeraiye",
            "Je Oluwa.",
          ]
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '24',
        verses: [
          [
            "Kinto sun, fun oore t' oni",
            "T' Olorun",
            "Şe fun mi.",
            "Ngo yin Olugbala.",
          ],
          ["Oluwa, kini ngo fi yin", "Ooko Rę", "T'O kun fun", "Anu ati ore."],
          [
            "Iwo ti s'eto irin mi",
            "L'ona Rę, di",
            "'Wo gb' ebę,",
            "'Wo si gba işe mi.",
          ],
          [
            "Mã ko mi, mã fę mi, titi:",
            "F'alafia,",
            "Rę fun mi",
            "Titi 'Wo y'o pe mi.",
          ],
          [
            "'Wo apata at' odi mi",
            "F' ipa Rę",
            "Pa mi mo",
            "'Gba m' ba dubulę sun.",
          ],
          [
            "Nigbakugba ti mo ba sun",
            "Ję k' emi",
            "Ji dide",
            "Pelu awon mimo.",
          ],
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
      id: '25',
      verses: [
        [
          "Oluwa t’ O mu Israel la okun ja,",
          "Ti O si gba won kuro li oko eru,",
          "Ti O rojo onje sile lati orun,",
          "On ni mo ngbadura si.",
        ],
        [
          "Olorun t’ O gba Danieli lowo Kiniun,",
          "T’ O si yo awon meta n’nu ina l’ eru,",
          "Eniti awon irawo ngba Tire gbo,",
          "On ni mo ngbadura si.",
        ],
        [
          "Olorun t’ O f’ oro Re d’ afefe duro,",
          "T’ o si nso ‘banuje oni d’ ayo l’ola,",
          "Eniti O yi okuta ‘boji kuro,",
          "On ni mo ngbadura si.",
        ],
        [
          "Olorun t’ O wo itanna igbe l’ aso",
          "Eniti O si mu omi san l’ aginju,",
          "Ti O we elese mo ninu eri re,",
          "On ni mo ngbadura si.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Okanna loni, okanna loni,",
        "B’ akoko t’ O sin Israeli la okun:",
        "Omo Re ni mo je, ‘tori oro Re so,",
        "Pe okanna ni Olorun Iyanu loni.",
      ],
    ),
    Hymn(
        id: '26',
        verses: [
          [
            "Ko su wa lati maa ko orin ti igbani,",
            "Ogo f’ Olorun Halleluya!",
            "A le fi igbagbo korin na soke kikan;",
            "Ogo f’ Olorun Halleluya.",
          ],
          [
            "Awa mbe n’nu ibu ife t’o ra wa pada;",
            "Ogo f’ Olorun Halleluya!",
            "Awa y’o iye goke lo s’oke orun",
            "Ogo f’ Olorun Halleluya!",
          ],
          [
            "Awa nlo si Afin kan ti a fi wura ko:",
            "Ogo f’ Olorun Halleluya!",
            "Nibiti ao ri Oba Ogo n’nu ewa Re",
            "Ogo f’Olorun Halleluya!'",
          ],
          [
            "Nibe ao korin titun t’anu t’o da wa nde,",
            "Ogo f’ Olorun Halleluya!",
            "Nibe awa ayanfe y’ o korin ‘yin ti Krist’:",
            "Ogo f’ Olorun Halleluya!",
          ],
        ],
        isChorus: true,
        chorus: [
          "Omo Olorun ni eto lati ma bu sayo;",
          "Pe ona yi nye wa si, ",
          "Okan wa nsa feri re",
          "Nigbose a o de Afin Oba wa Ologo;",
          "Ogo f’ Olorun halleluya",
        ]),
    Hymn(
        id: '27',
        verses: [
          [
            "Fi iyin fun! Jesu Olurapada wa",
            "Ki aiye k’okiki ife Re nla",
            "Fi iyin fun! Enyin Angeli ologo,",
            "F’ola at’ogo fun oruko Re",
            "B’Olusaguntan Jesu y’o to omo Re",
            "Apa Re lo ngbe won le lojojo;",
            "Enyin enia mimo ti ngb’oke Sion",
            "Fi iyin fun pelu orin ayo",
          ],
          [
            "Fi iyin fun Jesu Olurapada wa,",
            "Fun wa O t’eje re si le O ku",
            "On ni apata ati reti,gbala wa,",
            "Yin Jesu ti a kan m’agbelebu",
            "Olugbala to f’ara da irora nla",
            "Ti a fi ade egun de lori",
            "Eniti a pa nitori awa eda,",
            "Oba Ogo n joba titi lailai",
          ],
          [
            "Fi iyin fun Jesu Olurapada wa,",
            "Ki ariwo Iyin gba Orun kan,",
            "Jesu Oluwa njoba lai ati lailai,",
            "Se l’oba gbogb’ enyin alagbara,",
            "A segun iku: fi ayo rohin na ka,",
            "Isegun re ha da? Isa oku?",
            "Jesu ye! Ko tu n si wahala fun wa mo:",
            "Tori O l’agbara lati gbala.",
          ],
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '28',
        verses: [
          [
            "Em’ o yin Oluwa fun ife Re,",
            "A we mi nin’ eje Olurapada;",
            "Eje na to nsan nib’ agbelebu,",
            "A we mi nin’ eje Olurapada.",
          ],
          [
            "Ore ofe mu mi sunm’odo Re;",
            "A we mi nin’ eje Olurapada,",
            "Em’o korin soke, aiye y’o gbo;",
            "A we mi nin’eje Olurapada.",
          ],
          [
            "Alafia wo l’o to yi, l’okan mi;",
            "A we mi nin’eje Olurapada,",
            "Ayo mimo na, ko se f’enu so;",
            "A we mi niu’eje Olurapada.",
          ],
          [
            "Emi o ma gb’ohun iyin soke;",
            "A we mi nin’eje Olurapada,",
            "Okan mi y’o ma korin lojojo;",
            "A we mi nin’eje Olurapada,",
          ],
        ],
        isChorus: true,
        chorus: [
          "Ogo, Ogo, fun Odagutan,",
          "O gba mi lowo ese, mo si di mimo;",
          "Ogo, Ogo, Ogo, f’ Odagutan,",
          "A we mi nin’ eje Olurapada.",
        ]),
    Hymn(
      id: '29',
      verses: [
        [
          "E yin oba ogo, on ni olorun;",
          "Yin fun ‘se yanu ti o ti fihan,",
          "Owa pel’awon ero mimo l’ona;",
          "O si je imole won l’osan, l’oru;",
        ],
        [
          "E yin fun rapada ti gbogbo okan",
          "E yin fun orisun imularada:",
          "Fun inu rere ati itoju Re",
          "Fun ‘daniloju pe O ngbo adura:",
        ],
        [
          "E yin fun idanwo bi okun ife,",
          "T’o nso wa po mo awon ohun orun",
          "Fun gbagbo ti nsegun, reti ti ki sa",
          "Fun ile Ogo tO ti pese fun wa",
        ],
      ],
      isChorus: true,
      chorus: [
        "E yin angel’didan , lu duru wura,",
        "Ki gbogbo yin juba, t’e nwo o ju Re",
        "Ni gbogbo ‘joba Re, b’aiye ti nyi lo",
        "Ise Re yo ma yin",
        "Ise Re yo ma yin",
        "Fi ibukun fun oluwa okan mi",
      ],
    ),
    Hymn(
      id: '30',
      verses: [
        [
          "B’ orukọ Jesu ti dun to",
          "Ogo ni fun oruko Re",
          "O tan banujẹ at’ọgbẹ,",
          "ogo ni fun oruko Re",
        ],
        [
          "O wo ọkan t’o gbọgbẹ san,",
          "Ogo ni fun oruko Re,",
          "Onje ni f’ ọkan t’ ebi npa,",
          "Ogo ni fun oruko Re.",
        ],
        [
          "O tan aniyan elese,",
          "Ogo ni fun oruko Re,",
          "O fun alare ni ‘simi",
          "Ogo ni fun oruko Re,",
        ],
        [
          "N je ngo rohin na f’ elese",
          "Ogo ni fun oruko Re,",
          "Pe mo ti ri Olugbala,",
          "Ogo ni fun oruko Re,",
        ],
      ],
      isChorus: true,
      chorus: [
        "Ogo f’oko Re, Ogo f’oko Re,",
        "Ogo f’oruko Oluwa,",
        "Ogo f’oko Re, Ogo f’oko Re,",
        "Ogo f’oruko Oluwa.",
      ],
    ),
    Hymn(
      id: '31',
      verses: [
        [
          "Kristi ni ipin mi titi,",
          "On l' O ngba mi nin' ese. ",
          "O je ona igbala mi, ",
          "Eri yi wa l' okan mi,",
        ],
        [
          "On ni odi agbara mi,",
          "Amona at' Oba mi,",
          "On si ni Olupamo mi,",
          "Nje mo le f' ayo korin;",
        ],
        [
          "Iyin fun Enit' O ra mi.",
          "Iyin f' Eniti a pa,",
          "Nje emi ko, Halleluya!",
          "Iyin fun Oro 'yanu.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Eri yi wa l' okan mi,",
        "Jesu gba mi low' eşe:",
        "Mo l'ayo laiya Re,",
        "Or' ofe Re gba mi; ",
        "Eri yi si wa l' okan mi",
      ],
    ),
    Hymn(
      id: '32',
      verses: [
        [
          "Yin Olorun Abra'am",
          "Ti O njoba l'oke",
          "Enit' O ti wa titi lai, ",
          "Olorun 'fe.",
          "'Jehofa nla l' Emi'",
          "Gbogbo eda jewo:",
          "Mo fi 'bukun f' oruko Re",
          "Titi lailai.",
        ],
        [
          "Yin Olorun Abra'am, ",
          "Nip' ase Eniti",
          "Mo dide, mo si wa 'tunu",
          "Lowo 'tun Re",
          "Mo ko aiye silę;",
          "Ogbon at' ola rę",
          "On nikan si ni ipin mi",
          "At' asa mi.",
        ],
        [
          "On na ti se 'leri",
          "Mo gbekele eyi,",
          "Ngo fi iye idi goke",
          "Lo si orun.",
          "Ngo ma wo oju Re:",
          "Ngo si yin ipa Re:",
          "Ngo korin 'yanu t' or' ofe",
          "Titi lailai."
        ],
        [
          "Oba Oke orun",
          "Olor’ Angeli nke,",
          "Wipe 'Mimo, Mimo, Mimo'",
          "Oba titi.",
          "Eniti Ki pada",
          "Ti y’o so wa lailai",
          "Jehofa, Baba, “Emi ni,”"
              "Awa yin o.",
        ],
        [
          "Gbogb’ egbe asegun,",
          "Nyin Olorun loke,",
          "Baba, Omo, at’ Emi, ni",
          "Nwon nke titi:",
          "Yin Olorun Abra’am,",
          "Ngo ba won korin na;",
          "Tire l’ agbara at’ ola.",
          "Pelu iyin",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '33',
      verses: [
        [
          "Ẹ jẹ k’a f’ inu didun",
          "Yin Oluwa Olore;",
          "Anu Rẹ, O wa titi,",
          "Lododo dajudaju.",
        ],
        [
          "On, nipa agbara Rẹ,",
          "F’ imọlẹ s’aiye titun;",
          "Anu Rẹ, O wa titi,",
          "Lododo dajudaju",
        ],
        [
          "O mbọ gbogb’ ẹda ‘laye,",
          "O npese fun aini wọn;",
          "Anu Rẹ, o wa titi,",
          "Lododo dajujdaju.",
        ],
        [
          "O bukun ayanfẹ Rẹ,",
          "Li aginju aye yi;",
          "Anu Rẹ, o wa titi,",
          "Lododo dajudaju.",
        ],
        [
          "Ẹ jẹ k’a f’ inu didun,",
          "Yin Oluwa Olore;",
          "Anu Rẹ, o wa titi,",
          "Lododo dajudaju",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '34',
      verses: [
        [
          "Niwaju itę Jehofa,",
          "E f'ayo sin, oril' ede; ",
          "Mo p' Oluwa, On kanşo ni, ",
          "O le da, O si le parun."
        ],
        [
          "Ipa Re, laisi ' ranwo wa, ",
          "F. amo da wa ni enia;",
          "Nigba t'a şako b'agutan,",
          "O tun wa mu si agbo Rę.",
        ],
        [
          "A of' orin sunmo 'le Rę, ",
          "L'ohun giga l'a o korin; ",
          "Ile, l' egbarun ahon re. ",
          "Y'o f' lyin kun agbala Rę.",
        ],
        [
          "Ase Re gboro k'agbaiye,",
          "Ife Re po b' aiyeraiye; ",
          "Oto Re y'o duro lailai,",
          "'Gbat' odun o dekun 'yipo.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '35',
      verses: [
        [
          "N’nu gbogbo ayida aiye,",
          "Ayọ on wahala;",
          "Iyin Ọlọrun ni y’o ma",
          "Wa l’ẹnu mi titi",
        ],
        [
          "Gbe Oluwa ga pẹlu mi,",
          "Ba mi gb’Okọ Rẹ ga;",
          "N’nu wahala, ‘gba mo kepe,",
          "O si yọ mi kuro.",
        ],
        [
          "Ogun Ọlọrun wa yika",
          "Ibugbe olotọ;",
          "Ẹniti o ba gbẹkẹle,",
          "Yio si ri ‘gbala.",
        ],
        [
          "Sa dan ifẹ Rẹ wo lẹkan,",
          "Gbana ‘wọ o mọ pe,",
          "Awọn t’ o di otọ Rẹ mu",
          "Nikan l’ ẹni ‘bukun.",
        ],
        [
          "Ẹ bẹru Rẹ, ẹnyin mimọ,",
          "Ẹru miran ko si;",
          "Sa jẹ ki ‘sin Rẹ j’ayọ nyin,",
          "On y’o ma tọju nyin.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '36',
      verses: [
        [
          "Fun anu t’o po bi iyanrin,",
          "Ti mo ngba l’ojojumo;",
          "Lat’odo Jesu Oluwa,",
          "Ki l’emi o fi fun",
        ],
        [
          "Kini ngo fi fun Oluwa, ",
          "Lat’inu okan mi ",
          "Ese ti ba gbogbo re je ",
          "Ko tile jamo nkan.",
        ],
        [
          "Eyi l’ohun t’emi o se, ",
          "F’ohun t’O se fun mi; ",
          "Em’o mu ago igbala, ",
          "Ngo kepe Olorun.",
        ],
        [
          "Eyi l’ope ti mo le da, ",
          "Emi osi are; ",
          "Em’ o ma soro ebun Re, ",
          "Ngo si ma bere si.",
        ],
        [
          "Emi ko le sin b’oti to,",
          "Nko n’ise kan to pe ",
          "Sugbon em’o sogo yi pe,",
          "Gbese ope mi po.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '37',
      verses: [
        [
          "Emi ‘ba n’ ẹgbẹrun ahọn,",
          "Fun ‘yin Olugbala,",
          "Ogo Ọlọrun Ọba mi,",
          "Iṣẹgun ore Rẹ.",
        ],
        [
          "Jesu t’O s’ẹru wa d’ayọ,",
          "T’O mu banujẹ tan;",
          "Orin ni l’ eti ẹlẹṣẹ,",
          "Iye at’ ilera",
        ],
        [
          "O ṣẹgun agbara ẹṣẹ,",
          "O da onde silẹ;",
          "Ẹjẹ Rẹ le w’ eleri mọ,",
          "Ẹjẹ Rẹ ṣeun fun mi"
        ],
        [
          "O sọrọ, oku gb’ohun Rẹ;",
          "O gba ẹmi titun;",
          "Onirobinujẹ y’ayọ,",
          "Otoṣi si gba gbọ"
        ],
        [
          "Odi, ẹ kọrin iyin Rẹ;",
          "Aditi, gbohun Rẹ;",
          "Afọju, Olugbala de,",
          "Ayarọ, fo f’ayọ",
        ],
        [
          "Baba mi at’ Ọlọrun mi,",
          "Fun mi n’iranwọ Rẹ;",
          "Ki nle ro ka gbogbo aiye,",
          "Ọla Orukọ Rẹ",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '38',
      verses: [
        [
          "Ẹ wolẹ f’Ọba, Ologo julọ,",
          "Ẹ kọrin ipa ati ifẹ Rẹ;",
          "Alabo wa ni, at’ Ẹni Igbani,",
          "O ngbe ‘nu ogo, Ẹlẹru ni iyin.",
        ],
        [
          "Ẹ sọ t’ipa Rẹ, ẹ sọ t’ore Rẹ;",
          "‘Mọlẹ l’ aṣọ Rẹ, gọbi Rẹ, ọrun,",
          "Ara ti nṣan ni kẹkẹ ‘binu Rẹ jẹ;",
          "Ipa ọna Rẹ ni a ko si le mọ.",
        ],
        [
          "Aiye yi pẹlu ẹkun ‘yanu rẹ,",
          "Ọlọrun, agbara Rẹ l’o da wọn;",
          "O fi idi rẹ mulẹ, ko si le yi,",
          "O si f’ okun ṣe aṣọ igunwa Rẹ.",
        ],
        [
          "Ẹnu ha le sọ ti itọju Rẹ?",
          "Ninu afẹfẹ, ninu imọlẹ;",
          "Itọju Rẹ wa nin’ odo t’o nṣan,",
          "O si wa ninu iri ati ojo.",
        ],
        [
          "Awa erupẹ, aw’ alailera,",
          "‘Wọ l’a gbẹkẹle, O ki o da ni;",
          "Anu Rẹ rọrun, o si le de opin,",
          "Ẹlẹda, Alabo, Olugbala wa.",
        ],
        [
          "‘Wọ Alagbara, Onifẹ Julọ,",
          "B’awọn angẹli ti nyin Ọ l’oke,",
          "Be l’awa ẹda Rẹ, niwọn t’a le ṣe,",
          "A o ma juba Rẹ, a o ma yin Ọ.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '39',
      verses: [
        [
          "Gbogbo aiye, gbe Jesu ga,  ",
          "Angel' e wolę fun.",
          "E mu ade Oba Re wa.",
          "Se l' Oba awon oba.",
        ],
        [
          "E se l’ oba, enyin Martyr,",
          "Ti npe ni pepe Re:",
          "Gbe gbongbo-igi Jesse ga, ",
          "Se l'Oba awon oba",
        ],
        [
          "Enyin iru-omo Israel. ",
          "Tia ti rapada:",
          "E ki Enit' O gba nyin la,",
          "Se l'Oba awon oba.",
        ],
        [
          "Gbogbo enia elese.",
          "Ranti 'banuję nyin:",
          "E te ‘kogun nyin s' ese Re.",
          "Se l' Oba awon oba.",
        ],
        [
          "Ki gbogbo orile-ede, ",
          "Ni gbogbo agbaye",
          "Ki won ki, \"Kabiyesilę,\"",
          " Se l'Oba awon oba.",
        ],
        [
          "A ba le pel' awon t' orun, ",
          "Lati ma juba Re:",
          "K'a ba le jo jumo korin,",
          "Se l'Oba awon oba",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '40',
      verses: [
        [
          "Alleluya! orin t’o dun,",
          "Ohun ayọ ti ki ku:",
          "Alleluya! orin didun,",
          "T’ awọn t’o wa lọrun fẹ;",
          "N’ile ti Ọlọrun mi ngbe,",
          "Ni nwọn nkọ tọsantoru.",
        ],
        [
          "Alleluya! Ijọ ọrun,",
          "Ẹ le kọrin ayọ na.",
          "Alleluya! orin ‘ṣẹgun",
          "Yẹ awọn t’a rapada.",
          "Awa ero at’ alejo,",
          "Iyin wa ko nilari.",
        ],
        [
          "Alleluya! orin ayọ",
          "Ko yẹ wa nigbagbogbo.",
          "Alleluya! ohùn arò",
          "Da mọ orin ayọ wa;",
          "Gbat’ a wa laiye oṣi yi,",
          "A ni gbawẹ f’ ẹṣẹ wa.",
        ],
        [
          "Iyin dapọ m’ adua wa;",
          "Gbọ tiwa, Mẹtalọkan!",
          "Mu wa de ‘waju Rẹ layọ,",
          "K’a r’ Ọdagutan t’a pa:",
          "K’a le ma kọ Allelu",
          "Nibẹ lai ati lailai. ",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '41',
      verses: [
        [
          "Ogo ni fun f’oluwa t’o se ohun nla",
          "Ife lo mu k’o fun wa ni omo re,",
          "Enit’ o f’ emi re lele f’ese wa",
          "T’o si s’ilekun iye sile fun wa",
        ],
        [
          "Irapada kikun ti Eje re ra",
          "F’enikeni t’o gba ileri Re gbo",
          "Enit’o buruju b’o ba le Gbagbo",
          "Lojukanna y’o ri idariji gba",
        ],
        [
          "O s’ohun nla fun wa o da wa l’ola",
          "Ayo wa di kikun ninu omo Re",
          "Ogo ati ewa Irapada yi",
          "Y’o ya wa l’enu gbat’a ba ri Jesu",
        ],
      ],
      isChorus: true,
      chorus: [
        "Yin oluwa,yin oluwa",
        "fiyin fun oluwa",
        "Yin oluwa,yin oluwa ",
        "E yo n’iwaju Re",
        "K’a to baba wa lo l’oruko Jesu",
        "Jek’a jo f’ogo fun, onise ‘yanu",
      ],
    ),
    Hymn(
      id: '42',
      verses: [
        [
          "Ogo ni fun f’oluwa t’o se ohun nla",
          "Ife lo mu k’o fun wa ni omo re",
          "Enit’ o f’ emi re lele f’ese wa",
          "T’o si s’ilekun iye sile fun wa",
        ],
        [
          "Irapada kikun ti Eje re ra",
          "F’enikeni t’o gba ileri Re gbo",
          "Enit’o buruju b’o ba le Gbagbo",
          "Lojukanna y’o ri idariji gba",
        ],
        [
          "O s’ohun nla fun wa o da wa l’ola",
          "Ayo wa di kikun ninu omo Re",
          "Ogo ati ewa Irapada yi",
          "Y’o ya wa l’enu gbat’a ba ri Jesu",
        ],
      ],
      isChorus: true,
      chorus: [
        "Yin oluwa,yin oluwa",
        "fiyin fun oluwa",
        "Yin oluwa,yin oluwa",
        "E yo n’iwaju Re",
        "K’a to baba wa lo l’oruko Jesu",
        "Jek’a jo f’ogo fun, onise ‘yanu",
      ],
    ),
    Hymn(
      id: '43',
      verses: [
        [
          "Oluwa ọrun on aiye,",
          "‘Wọ n’ iyin at’ ọpẹ yẹ fun;",
          "Bawo l’ a ba ti fẹ Ọ to,",
          "Onibu ọrẹ?",
        ],
        [
          "Orun ti nran, at’ afẹfẹ,",
          "Gbogbo eweko nsọ ‘fẹ Rẹ;",
          "‘Wọ l’ O nmu irugbin dara,",
          "Onibu ọrẹ?",
        ],
        [
          "Fun ara lile wa gbogbo,",
          "Fun gbogbo ibukun aiye,",
          "Awa yin Ọ, a si dupẹ,",
          "Onibu ọrẹ?",
        ],
        [
          "O ko du wa li Ọmọ Rẹ,",
          "O fi fun aiye ẹṣẹ wa,",
          "O si f’ẹbun gbogbo pẹlu",
          "Onibu ọrẹ?",
        ],
        [
          "O fun wa l’ Ẹmi Mimọ Rẹ,",
          "Ẹmi iye at’ agbara,",
          "O rọjo ẹkun bukun Rẹ",
          "Le wa lori.",
        ],
        [
          "Fun idariji ẹṣẹ wa,",
          "Ati fun ireti ọrun,",
          "Kil’ ohun t’ a ba fi fun Ọ?",
          "Onibu ọrẹ.",
        ],
        [
          "Owo ti a nna, ofo ni,",
          "Ṣugbọn eyi t’ a fi fun Ọ,",
          "O jẹ iṣura tit’ aiye,",
          "Onibu ọrẹ.",
        ],
        [
          "Ohun t’ a bun Ọ, Oluwa,",
          "‘Wọ o san le pada fun wa;",
          "Layọ l’ a o ta Ọ lọrẹ,",
          "Onibu ọrẹ.",
        ],
        [
          "Ni ọdọ Rẹ lati ṣan wa,",
          "Ọlọrun Olodumare;",
          "Je k’ a le ba Ọ gbe titi,",
          "Onibu ọrẹ.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '44',
      verses: [
        [
          "Ji, okan mi, dide layo,",
          "Korin iyin Olugbala",
          "Ola Re bere orin mi",
          "'Seun ife Re ti po to ",
        ],
        [
          "O ri mo segbe n'isubu",
          "Sibe, O fe mi l'a fetan:",
          "O yo mi ninu osi mi",
          "'Seun 'fe Re ti tobi to!",
        ],
        [
          "Ogun ota dide si mi",
          "Aiye at' esu ndena mi",
          "On nmu mi la gbogbo re ja;",
          "'Seun 'fe Re ti n 'ipa to!",
        ],
        [
          "'Gbagbogbo l'okan see mi ",
          "Nfe ya lehin Oluwa mi;",
          "Sugbon bi mo ti ngbagbe Re,",
          "Iseun ife Re ki ye. ",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '45',
      verses: [
        [
          "Gbogbo enyin ti ngbe aiye, ",
          "E f’ ayo korin s' Oluwa:",
          "F’ iberu sin, e yin l' ogo, ",
          "E wa s' odo Re, k'e si yo.",
        ],
        [
          "Oluwa, On ni Olorun, ",
          "Laisi, 'ranwo wa O da wa;",
          "Agbo Re ni wa, O mbo wa; ",
          "O si fi wa ş' aguntan Re.",
        ],
        [
          "Nje, f' iyin wo ile Re, wa ",
          "Fayo sunmo agbala Re:",
          "Yin, k' e bukun oruko Rè,",
          "Tori o ye be lati şe.",
        ],
        [
          "Eeşe! Rere l' Olorun wa,",
          "Anu Rè, o wa titi lai: ",
          "Ooto Re ko figbakan ye. ",
          "O duro lat' iran-de-ran.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '46',
      verses: [
        [
          "A fope f’olorun,",
          "L’okan ati l’ohun wa,",
          "Eni s’ohun ‘yanu,",
          "N’nu Enit’araiye nyo;",
          "Gbat’a wa l’om’owo",
          "On na l’ ntoju wa",
          "O si nf’ebun ife",
          "Se ‘toju wa sibe",
        ],
        [
          "Oba Onib’ore,",
          "Ma fi wa sile lailai",
          "Ayo ti ko l’opin",
          "On ‘bukun yo je tiwa;",
          "Pa wa mo n’nu ore,",
          "To wa gba ba damu,",
          "Yo wa ninu ibi",
          "L’aiye ati L’orun",
        ],
        [
          "K’a f’iyin on ope",
          "F’olorun Baba, Omo",
          "Ati Emi mimo;",
          "Ti o ga julo l’orun,",
          "Olorun kan lailai,",
          "T’aiye at’orun mbo,",
          "Be l’o wa d’isiyi,",
          "Beni y’ o wa lailai",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '47',
      verses: [
        [
          "Yin Ọlọrun Ọba wa;",
          "Ẹ gbe ohun iyin ga;",
          "Anu Rẹ o wa titi",
          "Lododo dajudaju.",
        ],
        [
          "Yin Ẹnit’o da orun",
          "Ti o nran lojojumọ;",
          "Anu Rẹ o wa titi",
          "Lododo dajudaju.",
        ],
        [
          "Ati oṣupa loru",
          "Ti o ntanmọlẹ jẹjẹ;",
          "Anu Rẹ o wa titi",
          "Lododo dajudaju.",
        ],
        [
          "Yin Ẹnit’ o nm’ojo rọ",
          "T’ o nmu irugbin dagba;",
          "Anu Rẹ o wa titi",
          "Lododo dajudaju.",
        ],
        [
          "Ẹnit’ o paṣẹ fun ‘lẹ",
          "Lati mu eso pọ si;",
          "Anu Rẹ o wa titi",
          "Lododo dajudaju.",
        ],
        [
          "Yin fun ikore oko,",
          "O mu ki aka wa kun;",
          "Anu Rẹ o wa titi",
          "Lododo dajudaju.",
        ],
        [
          "Yin f’onjẹ t’ o ju yi lo,",
          "Ẹri ‘bukun ailopin;",
          "Anu Rẹ o wa titi",
          "Lododo dajudaju.",
        ],
        [
          "Ogo f’ Ọba olore:",
          "Ki gbogbo ẹda gberin:",
          "Ogo fun Baba, Ọmọ,",
          "At’ Emi: Mẹtalọkan.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '48',
      verses: [
        [
          "Iyin f'Eni Mimo julo",
          "L'oke ati n'ile",
          "Oro Re gbogbo 'je 'yanu",
          "Gbogb' ona Re daju",
        ],
        [
          "Ogbon Olorun ti po to",
          "Gbat' enia subu",
          "Adam keji wa soju 'ja",
          "Ati lati gbala",
        ],
        [
          "Ogbon ife p'eran ara",
          "T'o gbe Adam subu",
          "Tun b'ota ja ija otun",
          "K'o ja, k'o is segun",
        ],
        [
          "Ati p'ebun t'o j'or'ofe",
          "So ara di otun,",
          "Olorun papa tikare",
          "J'Olorun ninu wa",
        ],
        [
          "Ife 'yanu ti Eniti",
          "O pa ota enia;",
          "Ninu awo awa enia",
          "Je irora f'enia.",
        ],
        [
          "Nikoko ninu ogba ni",
          "Ati lori igi",
          "T'o si ko wa lati jiya",
          "T'o ko wa lati ku ",
        ],
        [
          "Iyin f'Eni mimo julo",
          "L'oke ati n'ile",
          "Oro Re gbogbo je 'yanu",
          "Gbogb' ona Re daju",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '49',
      verses: [
        [
          "Wa enyin olope wa",
          "Gbe orin ikore ga'",
          "Ire gbogbo ti wole,",
          "K'otutu oye to de:",
          "Olorun Eleda wa,",
          "Lo ti pese f'aini wa;",
          "Wa k'a rele Olorun",
          "Gbe orin ikore ga",
        ],
        [
          "Oko Olorun l'aiye,",
          "Latin seso iyin Re;",
          "Alikama at'epo",
          "Ndagba f'aro tab'ayo:",
          "Ehu na, ipe tele",
          "Siri oka nikehin;",
          "Oluwa k'ore, mu wa",
          "Je eso rere fun O",
        ],
        [
          "N'tori Olorun wa mbo",
          "Y'o si 'kore Re sile:",
          "On o gbon gbogbo panti",
          "Kuro l'oko Re njona:",
          "Y'o f'ase f'awon Angel,",
          "Lati gba epo s'ina,",
          "Si aba Re titi lai",
        ],
        [
          "Beni ma wa, Oluwa,",
          "Si kore ikehin,",
          "Ko awon enia Re jo;",
          "Kuro l'ese at'aro:",
          "So won di mimo lailai",
          "Ki nwon le ma ba O gbe;",
          "Wa t'Iwo t'Angeli Re,",
          "Gbe orin ikore ga.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
        id: '50',
        verses: [
          [
            "Je k'a jumo korin-ife l'Olorun,",
            "Ki gbogbo wa gberin,Ife - l'Olorun;",
            "Ji okan t'o nsun nin'ęsę,",
            "K'Olukuluku korin na ",
            "Tori Jesu korin, ife - l'Olorun.",
          ],
          [
            "So kakiri yi aiye ka - ife ni",
            "Irapada mbe ninu Krist'- ife ni",
            "Eje Re nwe ese wa nu",
            "Emi Re nso ekun dayo",
            "O si nmu wa korin ife - Olorun."
          ],
          [
            "Ayo wa nihin ti po to - ife ni",
            "Ileri Re nmu 'nu wa dun - ife ni",
            "Oorun at'asa ni fun wa,",
            "Iranwo at'ireti wa,",
            "Ko ni fi wa sile, ife Olorun.",
          ],
          [
            "B'iku ba pa oju mi de  -ife ni",
            "Ngo segun iku nipa Kristi - ife ni",
            "Nko ni beru odo Jordan",
            "Toru Jesu y'o pelu mi",
            "Ngo gunle s'ebute, ife - l'Olorun.",
          ],
        ],
        isChorus: true,
        chorus: [
          "Ife ni Olorun",
          "Je k'a jumo k'orin ife",
          "L'Olorun",
        ]),
    Hymn(
      id: '51',
      verses: [
        [
          "Ngo korin itan 'yanu na;",
          "Ti Jesu t'o ku fun mi;",
          "B'o ti fi 'le ogo silę,",
          "Fun iku agbelebui.",
        ],
        [
          "Mo sonu, Jesu wa mi ri,",
          "Agutan t'o ti şako;",
          "O n'apa 'fe Rè yi ni ka,",
          "O fà mi pada s'agbo.",
        ],
        [
          "Mo gbogbę Jesu wo mi san,",
          "Mo şubu O gbe mi n'de;",
          "Iberu so mi d'afoju,",
          "Jesu so mi d'ominira.",
        ],
        [
          "Y'o pa mi mo titi d'opin,",
          "Titi d'ipadabo Re",
          "Y'o gbe mi soke l'apa Re",
          "Ngo lo b'awon to ti lo.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Ngo maa korin 'tan 'yanu na,",
        "Ti Jesu t'o ku fun mi;",
        "Ngo b'awon mimo korin na,",
        "'Gbat'a ba pade loke.",
      ],
    ),
    Hymn(
      id: '52',
      verses: [
        [
          "E gbe ohun ayo at'iyin ga, Alle/luya!",
          "Orin ogo Oba nla l'awon ti a rapada/",
          "y'o ma ko: Alle/luya! Alle/luya!",
        ],
        [
          "Awon egbe ako/rin orun",
          "Nwon o gberin na yi/ka orun:",
          "Alle/luya Alle/luya",
        ],
        [
          "Awon ti nrin gbefe kiri ni Pa/radise,",
          "Awon eni 'bukun ni, nwon o ma ko/ri wipe,",
          "Alle/luya Alle/luya",
        ],
        [
          "Awon 'rawo ti ntan/mole won,",
          "Ati gbogbo awon egbe irawo, da",
          "ohun won/lu wipe, Alle/luya Alle/luya",
        ],
        [
          "Enyin sanmo t'o nwo si lo at'enyin/efufu",
          "Eyin ara t'o nsan wa/",
          "enyin mana mana ti o / nko mana;",
          "E fi a/yo gberin Alle/luya!",
        ],
        [
          "Enyin omi, at'igbi okun, enyin ojo, a/t'otutu,",
          "Enyin ojo dida/ra gbogbo",
          "Enyin igboro at'igbo, e/gberin na",
          "Allen/luya!",
        ],
        [
          "Enyin oniruru eiye, e ko/rin iyin/Ele/",
          "da nyin pe, Alle/luya Alle/luya!",
        ],
        [
          "Enyin eranko igbe, e di/o/hun nyin lu",
          "E si korin iyin Ele/da wipe,",
          "Alle/luya Alle/luya",
        ],
        [
          "Je k'awon oke k'o / bu s'ayo,",
          "Alle/luya!",
          "K'awon petele si / gberin na",
          "Alle/luya!",
        ],
        [
          "Enyin ogbun omi okun, e / ko wipe,",
          "Alle/luya!",
          "Eyin ile gbigbe e da / hun wipe",
          "Alle/luya!",
        ],
        [
          "Olorun t'O / da aiye, ni k'a / f'orin yin",
          "Alle/luya! Alle/luya!",
        ],
        [
          "Eyi l'orin ti O/lorun fe, Alle/luya!",
          "Eyi l'orin ti Krist' tika/lare, Fe,",
          "Alle/luya",
        ],
        [
          "Nitorina, tokantokan l'ao/ fi korin",
          "Alle/luya!",
          "Awon omode wewewe y'o gba orin na/ ",
          "ko wipe, Alle/luya!",
        ],
        [
          "Ki gbogbo enia / ki o ko",
          "Alle/luya si /Olorun;",
          "Alleluya ti /ti aiye,",
          "Fun Omo on E/ mi Mimo.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '53',
      verses: [
        [
          "Ile-eko ojo 'simi",
          ", mo ti fe O to;",
          "Inu mi dun mo daraya,",
          "Lati yo ayo Re",
        ],
        [
          "Ile-eko ojo 'simi",
          "Ore re p' apoju;",
          "T'agba t'ewe wa nkorin re,",
          "A nse aferi re.",
        ],
        [
          "Ile-eko ojo 'simi,",
          "Jesu l'O ti ko o;",
          "Emi Mimo Olukoni,",
          "L'O si nse 'toju",
        ],
        [
          "Ile-eko ojo 'simi,",
          "Awa ri eri gba,",
          "P'Olorun Olodumare",
          "F'ibukun s'ori re.",
        ],
        [
          "Ile-eko ojo 'simi,",
          "B'oorun nran l'aranju,"
              "Bi ojo su dudu l'orun,",
          "Ninu re l'em'o wa",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
        id: '54',
        verses: [
          [
            "Mase huwa ese,",
            "Ma soro 'binu,",
            "Omo Jesu l'e se",
            "Omo Oluwa.",
          ],
          [
            "Krist' je oninure,",
            "At'eni mimo,",
            "Be l'awon omo Re",
            "Ye k'o je mimo."
          ],
          [
            "Emi ibi kan wa,",
            "T'o nso irin re;",
            "O si nfe dan o wo",
            "Lati se ibi",
          ],
          [
            "E ma se gbo tire,",
            "B'o tile soro",
            "Lati ba esu ja",
            "Lati se rere",
          ],
          [
            "Eyin ti se 'leri",
            "Ni omo-omo;",
            "Lati k'esu sile,",
            "Ati ona re",
          ],
          [
            "Om'ogun Krist' ni nyin,",
            "E ko lati ba",
            "Ese inu nyin ja;",
            "E ma se rere.",
          ],
          [
            "Jesu l'Oluwa nyin,",
            "O se Eni 're",
            "Ki enyin omo Re",
            "Si ma se rere.",
          ]
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
        id: '55',
        verses: [
          [
            "Hosanna! E ko'rin soke",
            "S'Omo nla Dafidi;",
            "Pelu Kerub ati Seraf;",
            "K'a yin Om'Olorun.",
          ],
          [
            "Hosanna! Eyi na nikan,",
            "L'ahon wa le maa ko;",
            "Iwo ki o kegan ewe,",
            "Ti nko'rin iyin Re.",
          ],
          [
            "Hosanna! Eyi na nikan,",
            "L'ahon wa le maa ko;",
            "Iwo ki o kegan ewe,",
            "Ti nko'rin iyin Re.",
          ],
          [
            "Hosanna! Baba, awa mu",
            "Ore wa wa fun O.",
            "Ki se wura on ojia,",
            "Bikose okan wa",
          ],
          [
            "Hosanna! Jesu, l'eekan si",
            "O yin awon ewe;",
            "S'aanu fun wa, so f'eti so",
            "Orin awa ewe.",
          ],
          [
            "Jesu, b'O ba ra pada,",
            "T'a si wo 'joba Re;",
            "A o fi harpu wura ko",
            "Hosanna titi lai. ",
          ]
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
      id: '56',
      verses: [
        [
          "Enikan mbę t' O feran wa,",
          "A ! O fę wa !",
          "Ife Rè ju ti yekan,",
          "A ! O fę wa!",
          "Ore aiye nko wa silę,",
          "B' oni dun ola le koro, ",
          "Sugbon Ore yi kò ntanni",
          "A ! O fę wa !"
        ],
        [
          "Iye ni fun wa ba bá mộ",
          "A ! O fę wa ! ",
          "Ro b' a ti je ni gbese to,",
          "A ! O fe wa !",
          "Eję Rè l'O si fi ra wa, ",
          "Nin' aginju l'O wa wa ri,",
          "O si mu wa wa s' agbo Re ",
          "A ! O fęwa !",
        ],
        [
          "Orę ododo ni Jesu,",
          "A ! O fę wa ! ",
          "O fę lati mã bukun wa,",
          "A ! O fę wa !",
          "Okan wa fe gbo ohun Rè,",
          "Okan wa fę lati sunmo,",
          "On na kò si ni tan wa ję",
          "A ! O fę wa !",
        ],
        [
          "L'ooko Rè l' a nri 'dariji,",
          "A ! O fę wa ! ",
          "On O le ota wa s'ehin,",
          "A ! O fę wa !",
          "On O pese 'bukun fun wa",
          "Ire l'a o ma ri titi",
          "On o fi mu wa lo s'ogo.",
          "A ! O fę wa ! ",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '57',
      verses: [
        [
          "Iwo t' O nmu okan molę,",
          "Nipa 'mole at' orun wa,",
          "T'O si nsę iri ibukun",
          "Sor' awon ti ns' aferi Rę.",
        ],
        [
          "Jo maşai fi ibukun Rę",
          "Fun oluko at' akęko:",
          "Ki ijo Re le ję mimo,",
          "K'atupa rę maa jó gere.",
        ],
        [
          "F' okan mimo fun oluko,",
          "Igbagbo, 'reti, at' ife;",
          "Ki nwon j' eni t' Iwo ti ko,",
          "Ki nwon le j' oluko rere.",
        ],
        [
          "F'eti igboran f' akéko ",
          "Okan relę at' ailetan;",
          "Talaka to kun f' ebun yi;",
          "San ju oba aiye yi lo"
        ],
        [
          "Buk' oluşo; buk' agutan,",
          "Ki won j’okan labe 'so Rę",
          "Ki nwon maa f' okan kan so'na",
          "Tit aiye oşi yi yo' pin.",
        ],
        [
          "Baba, b'a wà n'nu ore Rę,",
          "L'aiye yi l'a o ti logo;",
          "K' a to koja s' oke orun",
          "La o mo ohun ti aiku je.",
        ]
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '58',
      verses: [
        [
          "Ọjọ ‘simi at’ ayọ,",
          "Ọjọ inu didun,",
          "Itunu fun ‘banujẹ",
          "Ọjọ dida julọ;",
          "Ti awọn ẹnia giga",
          "Niwaju itẹ Rẹ"
              "Nkọ mimọ, mimọ, mimọ,",
          "S’ ẹni Mẹtalọkan",
        ],
        [
          "L’ ọjọ yi ni ‘mọlẹ la,",
          "Nigba dida aiye:",
          "Ati fun igbala wa",
          "Kristi jinde loni;",
          "L’ ọjọ oni l’ Oluwa,",
          "Ran Ẹmi t’ ọrun wa;",
          "Ọjọ ologo julọ",
          "T’ o ni ‘mọlẹ pipe",
        ],
        [
          "Orisun ‘tura ni Ọ,",
          "L’aiye aginju yi:",
          "L’ ori Rẹ, bi ni Pisga",
          "L’ a nwo ‘lẹ ileri.",
          "Ọjọ ironu didun",
          "Ọjọ ifẹ mimọ,",
          "Ọjọ ajinde, lati",
          "Aiye, si nkan ọrun",
        ],
        [
          "L’ oni s’ ilu t’ arẹ mu",
          "Ni Manna t’ ọrun bọ;",
          "Si ipejọpọ mimọ",
          "N’ ipe fadaka ndun.",
          "Nibiti Ihin-rere",
          "Ntan imọlẹ mimọ,"
              "Omi iye nṣan jẹjẹ",
          "Ti ntu ọkan lara",
        ],
        [
          "K’ a r’ ore-ọfẹ titun",
          "L’ ọjọ ‘simi wa yi,",
          "K’ a si de ‘simi t’ o ku",
          "F’ awọn alabukun.",
          "Nibẹ K’ a gbohun soke",
          "Si Baba at’ Ọmọ",
          "Ati si Ẹmi Mimọ,",
          "N’ iyin Mẹtalọkan",
        ]
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '59',
      verses: [
        [
          "Ose, ose rere",
          "Iwo ojo 'simi",
          "O ye k'a fi ojo kan,",
          "Fun Olorun rere;",
          "B'ojo mi ba m'ekun wa,",
          "Iwo n'oju wa nu,",
          "Iwo ti s'ojo ayo,",
          "Emi fe dide Re.",
        ],
        [
          "Ose, ose rere,",
          "A ki o sise loni;",
          "A o f'ise wa gbogbo",
          "Fun aisimi ola,",
          "Didan l'oju Re maa dan",
          "'Wo arewa ojo;",
          "Ojo mi nso ti laala",
          "Iwo nso ti 'simi.",
        ],
        [
          "Ose,ose rere,",
          "Ago tile nwipe,",
          "F'Eleda re l'ojo kan,",
          "T'o fun o ni 'jo mefa'",
          "A o fi 'se wa sile,",
          "Lati lo sin nibe,",
          "Awa ati ore wa,",
          "Ao lo sile adua.",
        ],
        [
          "Ose, ose rere,",
          "Wakati re wu mi;",
          "Ojo orun n'iwo se,",
          "'Wo apere orun,",
          "Oluwa, je ki njogun,",
          "'Simi lehin iku",
          "Ki nle maa sin O titi,",
          "Pelu enia Re.",
        ]
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
        id: '60',
        verses: [
          [
            "Olori ijọ t’ ọrun,",
            "L’ ayọ l’ a wolẹ fun Ọ;",
            "K’ O to de, ijọ t’ aiye,",
            "Y’o ma kọrin bi t’ ọrun.",
            "A gbe ọkan wa s’ oke,",
            "Ni ‘reti t’ o ni ‘bukun;",
            "Awa kigbe, awa f’ iyin",
            "F’ Ọlọrun igbala wa.",
          ],
          [
            "‘Gbat’ a wa ninu pọnju,",
            "T’ a nkọja ninu ina,",
            "Orin ifẹ l’ awa o kọ,",
            "Ti o nmu wa sunmọ Ọ;",
            "Awa ṣapẹ, a si yọ,",
            "Ninu \"ojurere Rẹ;",
            "Ifẹ t’ o sọ wa di Tirẹ,",
            "Y’ o ṣe wa ni Tirẹ lai.",
          ],
          [
            "Iwọ mu awọn enia Rẹ",
            "Kọja iṣan idanwo:",
            "A ki o bẹru wahala,",
            "T’ori O wa nitosi:",
            "Aiye, ẹṣẹ, at’ Eṣu,",
            "Kọjuja si wa lasan,",
            "L’ agbara Rẹ, a o ṣẹgun,",
            "Ao si kọ orin Mose.",
          ],
          [
            "Awa f’ igbagbọ r’ ogo,",
            "T’o tun nfẹ fi wa si;",
            "A kẹgan aiye tori",
            "Ere nla iwaju wa.",
            "Bi O ba si ka wa yẹ,",
            "Awa pẹlu Stefen t’ o sun,",
            "Y’o ri Ọ bi O ti duro,",
            "Lati pe wa lọ s’ ọrun.",
          ]
        ],
        isChorus: false,
        chorus: [''])
  ];
}
