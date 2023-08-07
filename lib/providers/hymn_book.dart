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
          "Oro, at' işe mi oni",
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
          "Kiyes' irin' re l'aiye yi:",
          "K'o si mura d' ojo nla ni.",
        ],
        [
          "Gba ninu imolę orun,",
          "Si tanmolę na f' elomi:",
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
          "Lati se ise ojo mi.",
          "Iwo nikan l'emi o mo.",
          "L'oro l'ero; ati n' işe.",
        ],
        [
          "Ise t'O yan mi, l' anu Re",
          "Jęki nle şe tayotayo:",
          "Ki nr' oju Re ni iSe mi,",
          "K' emi si le f' ife Re han.",
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
          "Je ki nreru Re t'o fuye",
          "Ki nmaa sora nigba gbogbo,",
          "Ki nma f' oju si nkan t' orun,",
          "Ki nsi mura d' ojo ogo:",
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
          "Nwon a si s' osan mid' oru.",
        ],
        [
          "Wa s' odo mi, Oluwa mi,",
          "Nigbati ale ba nle lo",
          "Bi okan mi ba nşako lo",
          "Muu pada, f' oju 're wo mi.",
        ],
        [
          "Wa s' odo mi, Oluwa mi.",
          "Li oru, nigbati orun",
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
          "Itura ojiji Rę dun",
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
          "Má fi mi silę lai",
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
          "A tun tę ekun ba.",
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
          "Tobę t' imolę otito",
          "Le tan loju aiye.",
        ],
        [
          "Má je k'a pada lodo Re",
          "Olugbala owon:",
          "Titi a o f' oju wa ri",
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
          "'Molę oro, sun-mo mi",
          "'Rawo oro, w' aiya mi",
        ],
        [
          "Okukun l' owuro je",
          "B' Iwo ko pelu rę wa :",
          "Ailayo l' ojo yi je.",
          "B'anu ko tan 'molę mi",
          "Fun mi n' imolę Jesu.",
          "M' okan mi gbogbo gbona:",
        ],
        [
          "Wa bę okan mi yi wo,",
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
          "Gege bi iri ti nse",
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
          "Sin wa la a jo wa ja",
          "S'ile wa.",
        ],
        [
          "Pa wa mo n'nu ifę Rę",
          "L'ojo aiye wa gbogbo,",
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
          "K' emi le wa l' alafia",
          "Pelu Iwo ati aiye.",
        ],
        [
          "Jek' okan mi le sun le O.",
          "K' orun didun p' oju mi de",
          "Orun ti y'o m'ara mi le",
          "Ki nle sin O li owuro.",
        ],
        [
          "Bi mo ba dubulę laisun,",
          "F' ero orun kun okan mi,",
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
            "N' ijo iyonu aiye pin,",
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
            "Ojo aiye mi nsare lo s' opin,",
            "Ayo aiye nku, ogo re nwomi,",
            "Ayida at' iba je ni mo nri,",
            "'Wo ti ki yipada wa ba mi gbe.",
          ],
          [
            "Má wa l' eru b' Oba awon oba",
            "Sugbon ki o mã bo b' oninure,",
            "Ki o si ma kanu fun egbe mi",
            "Wa Ore elese, wa ba mi gbe.",
          ],
          [
            "Mo nfe O ri, ni wakati gbogbo :",
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
            "Lai l' aiya Olugbala mi.",
          ],
          [
            "Ba mi gbe l' oro tit' ale",
            "Laisi Re emi ko le wa,",
            "Ba mi gbe gbat' ile ba nşu,",
            "Laisi Re emi ko le sun.",
          ],
          [
            "B otoşi omo Re kan",
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
            "K'a to m' ohun aiye yi şe",
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
            "Beni nwon ko f' aiye sile,",
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
            "To 'şisę mi: ohun ehin ola",
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
            "Nigba iye at' iku wa,",
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
            "Nigba ye at' iku wa,",
            "Jesu jare, se 'molę wa.",
          ],
          [
            "Lala dun, tori 'Wo se ri;",
            "Aniyan ferę. O se ri.",
            "Ma je k'a gbo t' ara nikan",
            "K'a ma bo sinu idewo,",
            "Nigba iye at' iku wa,",
            "Jesu jare, se 'molę wa.",
          ],
          [
            "A mbę O f' awon alaini,",
            "Felese at' awon t' a fe.",
            "Je ki anu Re mu wa yo,",
            "'Wo Jesu, l' ohun gbogbo wa,",
            "Nigba iye at' iku wa,",
            "Jesu jare, se 'molę wa.",
          ],
          [
            "Jesu bukun wa ile şu,",
            "Tikalarę wa ba wa gbe,",
            "Angel' rere nşo ile wa,",
            "A tun f' ojo kan sunmo O.",
            "Nigba iye at' iku wa,",
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
            "B' ile tile ti şu dudu,",
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
            "Imolę aiyeraiye.",
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
            "B' aiye ti nyi lo s'imole",
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
            "Nigbakugba li enu si nso",
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
            "K'a ji, k'a f' iyin fun O.",
          ],
        ],
        isChorus: false,
        chorus: ['']),
    Hymn(
      id: '21',
      verses: [
        [
          "Ojo oni lo tan,",
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
            "Ki nto sun, fun oore t' oni",
            "T' Olorun",
            "Şe fun mi.",
            "Ngo yin Olugbala.",
          ],
          ["Oluwa, kini ngo fi yin", "Ooko Rę", "T'O kun fun", "Anu ati ore."],
          [
            "Iwo ti s'eto irin mi",
            "L'ona Rę,",
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
            "F’ola at’ ogo fun oruko Re",
            "B’ Olusaguntan Jesu y’o to omo Re",
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
            "Oba Ogo njoba titi lailai",
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
            "A we mi nin’ eje Olurapada.",
          ],
          [
            "Alafia wo l’o to yi, l’okan mi;",
            "A we mi nin’ eje Olurapada,",
            "Ayo mimo na, ko se f’enu so;",
            "A we mi niu’ eje Olurapada.",
          ],
          [
            "Emi o ma gb’ohun iyin soke;",
            "A we mi nin’ eje Olurapada,",
            "Okan mi y’o ma korin lojojo;",
            "A we mi nin’ eje Olurapada,",
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
        "E yin angel’ didan, lu duru wura,",
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
          "E gbe ohun ayo at'iyin ga,",
          "Alle/luya!",
          "Orin ogo Oba nla",
          "l'awon ti a rapada/",
          "y'o ma ko: Alle/luya!",
          "Alle/luya!",
        ],
        [
          "Awon egbe ako/",
          "rin orun",
          "Nwon o gberin na yi/",
          "ka orun:",
          "Alle/luya Alle/luya",
        ],
        [
          "Awon ti nrin gbefe",
          "kiri ni Pa/radise,",
          "Awon eni 'bukun ni,",
          "nwon o ma ko/ri wipe,",
          "Alle/luya Alle/luya",
        ],
        [
          "Awon 'rawo ti ntan/",
          "mole won,",
          "Ati gbogbo awon egbe irawo,",
          "da ohun won/lu wipe,",
          "Alle/luya Alle/luya",
        ],
        [
          "Enyin sanmo t'o nwo si",
          "lo at'enyin/efufu",
          "Eyin ara t'o nsan wa/",
          "enyin mana mana ti o/",
          "nko mana; E fi a/",
          "yo gberin Alle/luya!",
        ],
        [
          "Enyin omi, at'igbi okun,",
          "enyin ojo, a/t'otutu,",
          "Enyin ojo dida/ra gbogbo",
          "Enyin igboro at'igbo,",
          "e/gberin na",
          "Allen/luya!",
        ],
        [
          "Enyin oniruru eiye,",
          "e ko/rin iyin/Ele/",
          "da nyin pe,",
          "Alle/luya Alle/luya!",
        ],
        [
          "Enyin eranko igbe,",
          "e di/o/hun nyin lu",
          "E si korin iyin Ele/",
          "da wipe,",
          "Alle/luya Alle/luya",
        ],
        [
          "Je k'awon oke k'o/",
          "bu s'ayo,",
          "Alle/luya!",
          "K'awon petele si/",
          "gberin na",
          "Alle/luya!",
        ],
        [
          "Enyin ogbun omi okun,",
          "e / ko wipe,",
          "Alle/luya!",
          "Eyin ile gbigbe e da/ hun wipe",
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
          "B'oorun nran l'aranju",
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
            "Ye k'o je mimo.",
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
          "Niwaju itẹ Rẹ",
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
          "Ntan imọlẹ mimọ",
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
      chorus: [''],
    ),
    Hymn(
      id: '61',
      verses: [
        [
          "A bẹ, a fẹ ri Ọ",
          "Ọjọ ‘simi rere",
          "Gbogbo ọsẹ ama wipe",
          "Iwọ o ti pẹ to?",
        ],
        [
          "O kọ wa pe Kristi",
          "Jinde ninu oku;",
          "Gbogbo ọsẹ ama wipe,",
          "Iwọ o ti pẹ to!",
        ],
        [
          "O sọ t’ ajinde wa",
          "Gẹgẹ bi ti Jesu;",
          "Gbogbo ọsẹ ama wipe,",
          "Iwọ o ti pẹ to!",
        ],
        [
          "Iwọ sọ t’ isimi",
          "T’ ilu Alafia;",
          "T’ ibukun enia mimọ",
          "Iwọ o ti pẹ to.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '62',
      verses: [
        [
          "Oluwa ọjọ isimi,",
          "Gbọ ti wa, pẹlu wa loni;",
          "Awa pade fun adura,",
          "A fẹ gb’ ọrọ t’ o fi fun wa",
        ],
        [
          "Isimi t’aiye yi rọrun,",
          "Ṣugbọn isimi t’ọhun dun:",
          "Lala ọkan wa fẹ ‘jọ na,",
          "T’ a o simi lailẹṣẹ da.",
        ],
        [
          "Ko si ‘ja, ko si ‘dagiri,",
          "Ko s’ aniyan bi t ’aiye yi",
          "T’ y’o dapọ mọ ikọrin wa",
          "T’ o nt’ ete aiku jade wa",
        ],
        [
          "Bẹrẹ, ọjọ t’ a ti nreti,",
          "Afẹmọju rẹ l’a fẹ ri;",
          "A fẹ yọ lọna iṣẹ yi",
          "K' a si de ibi 'simi na",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '63',
      verses: [
        [
          "Jesu, a fe pade,",
          "L’ ojo re mimo yi;",
          "A si y’ ite Re ka,",
          "L’ ojo re mimo yi;",
          "‘Wo Ore wa orun,",
          "Adura wa mbo wa,",
          "Bojuwo emi wa,",
          "L’ojo Re mimo yi.",
        ],
        [
          "A ko gbodo lora,",
          "L’ ojo re mimo yi;",
          "Li  eru a kunle,",
          "L’ ojo re mimo yi;",
          "Ma taro ise wa,",
          "K’iwo k’o si ko wa,",
          "K’a sin O b’o ti ye,",
          "L’ojo re mimo yi;",
        ],
        [
          "A te ‘ti s’oro Re,",
          "L’ojo Re mimo yi;",
          "Bukun oro t’a gbo,",
          "L’ ojo re mimo yi;",
          "Ba wa lo ‘gba t’a lo,",
          "F’ore igbala Re,",
          "Si aiya wa gbogbo,",
          "L’ojo re mimo yi;",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '64',
      verses: [
        [
          "Eyi l’ojo t’Oluwa da,",
          "O pe’gba na n’Tire;",
          "K’orun k’o yo, k’aiye k’oyo,",
          "K’iyin yi’te na ka",
        ],
        [
          "Loni,O jinde’nu oku,",
          "Ijoba Satan tu;",
          "‘Won mimo tan segun Re ka",
          "Nwon nsoro’yanu Re.",
        ],
        [
          "Hosanna si Oba t’a yan,",
          "S’Omo mimo Dafid;",
          "Oluwa jo sokale wa;",
          "T’iwo t’igbala Re.",
        ],
        [
          "Hosanna li ohun goro,",
          "L’orin Ijo t’aiye,",
          "Orin t’oke orun l’ohun,",
          "Yi o dun ju be lo.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '65',
      verses: [
        [
          "Ayọ l’ ọjọ ‘simi fun mi,",
          "At’ agogo at’ iwasu:",
          "Gbat’ a ba mi n’nu ‘banujẹ",
          "Awọn l’o nmu inu mi dun."
        ],
        [
          "Ayọ si ni wakati na",
          "Ti mo lo n’nu agbala Rẹ;",
          "Lati mọ adun adura",
          "Lati gba manna ọrọ Rẹ.",
        ],
        [
          "Ayọ ni idahun “Amin”",
          "T’o gba gbogbo ile na kan,",
          "Lẹkọkan l’o ndun t’o nrọlẹ,",
          "O nkọja lọ sọdọ Baba.",
        ],
        [
          "B’ aiye fẹ f’ agbara de mi",
          "Mọ iṣẹ ijọ mẹfa rẹ;",
          "Oluwa, jọ, tu ide na,",
          "K’O sọ ọkan mi d’ominira.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '66',
      verses: [
        [
          "Olorun wa orun,",
          "To fi ojo mefa",
          "Da nkan gbogbo to mbę laiye,",
          "Simi n'ijo keje.",
        ],
        [
          "O paşe k' a bowo",
          "Fun ojo isimi,",
          "Ibinu Rę tobi pupo",
          "S'awon t'orufin yi",
        ],
        [
          "Awon Baba nla wa,",
          "Ti ku nin'okunkun,",
          "Nwon je ògbó aborişa",
          "Nwon kò mo ofin Re.",
        ],
        [
          "Awa de Oluwa",
          "Gege bi ase Re",
          "Lehin ise Ijo mefa",
          "Lati se ife Re.",
        ],
        [
          "Mimo l'ojo oni,",
          "O ye ki a simi,",
          "K'a pejo ninu ile Re",
          "K'a gbo 'ro Mimo Re",
        ],
        [
          "Isimi nla kan ku",
          "F'awon enia Re",
          "Om'Olorun Alabukun",
          "Mu wa de 'simi Rę.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '67',
      verses: [
        [
          "Didun n’iṣẹ na, Ọba mi,",
          "Lati ma yin orukọ Rẹ,",
          "Lati ṣe ‘fẹ Rẹ l’ owurọ,",
          "Lati sọ ọrọ Rẹ l’ alẹ.",
        ],
        [
          "Didun l’ ọjọ ‘simi mimọ,",
          "Lala ko si fun mi loni:",
          "Ọkan mi, ma kọrin iyin",
          "Bi harpu Dafidi didun.",
        ],
        [
          "Ọkan mi o yọ n’ Oluwa,",
          "Y’o yin iṣẹ at’ ọrọ Rẹ",
          "Iṣẹ ore Rẹ ti pọ to!",
          "Ijinlẹ si ni imọ Rẹ.",
        ],
        [
          "Emi o yan ipo ọla",
          "‘Gb’ ore-ọfẹ ba wẹ mi nu",
          "Ti ayọ pupọ si ba mi,",
          "Ayọ mimọ lat’ oke wa.",
        ],
        [
          "’Gbana, ngo ri, ngo gbọ, ngo mọ",
          "Ohun gbogbo ti mo ti nfẹ;",
          "Gbogbo ipa mi y’o dalu",
          "Lati ṣe ‘fẹ Rẹ titi lai.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '68',
      verses: [
        [
          "Pelu ayo l'a o s'ise f'Oluwa",
          "Pelu ife l'a o f'owo wa se;",
          "Isekise ti O ba yan fun wa;",
          "L'ododo l'a o s'se 'ranse wa.",
        ],
        [
          "Pelu adun l'a o so itan na,",
          "T'ife nla Re s'awa enia,",
          "Kristi, itansan ogo ti Baba",
          "L'ofe l'On o fi 'bukun fun wa,",
        ],
        [
          "Pelu 'rele l'ao sise f'Oluwa,",
          "A o fi otito rin l'ona Re,",
          "A o to asako sod'Olugbala,",
          "A o f'Odaguntan han elese",
        ],
      ],
      isChorus: true,
      chorus: [
        "S'ise fun Jesu",
        "L'ayo l'a o lo, l'ayo l'a o lo;",
        "S'ise fun Jesu",
        "Ninu ogba Re l'aiye",
      ],
    ),
    Hymn(
      id: '69',
      verses: [
        [
          "Gbo bi Oluwa to mbebe;",
          "Ise wa fun gbogbo wa",
          "Gbo bi Emi ti nwi pelu",
          "Je ipe na bayo pe",
        ],
        [
          "Ohun kan npe o nisiyi",
          "Fi eti si ohun na,",
          "O nso si o l'eti jeje",
          "Je ipe na bayi pe",
        ],
        [
          "Okan pupo nku n'nu ese:",
          "Yara lati se 'ranwo;",
          "'Tori akoko nkoja lo,",
          "So fun Jesu bayi pe",
        ],
      ],
      isChorus: true,
      chorus: [
        "Mo se tan lati s'ise fun O, Jesu",
        "Emi de, ran mi,",
        "Mo nfe lati se ife Re ni pipe,",
        "Ngo lo s'ibiti O ba ran mi",
        "Mo se tan lati s'ise fun O Jesu",
        "Emi de, ran mi,",
        "Bi ona tile s'ookun eru ko ba mi,",
        "Mo se tan fun ise, Jesu",
      ],
    ),
    Hymn(
      id: '70',
      verses: [
        [
          "Iranse Oluwa!",
          "E duro ni di 'se,",
          "E toju oro mimo Re,",
          "E ma s'ona Re sa.",
        ],
        [
          "Je k'imole nyin tan.",
          "E tun fitila se;",
          "E d'amure girigiri,",
          "Oruko Re l'eru.",
        ],
        [
          "Sora l'ase Jesu,",
          "B'a ti nso, k'o jina;",
          "B'O ba kuku ti ka 'lekun,",
          "Ki e si fun logan.",
        ],
        [
          "Iranse 're l'eni",
          "Ti a ba nipo yi;",
          "Ayo l'on o fi r'Oluwa,",
          "Y'o f'ola de l'ade.",
        ],
        [
          "Kristi tikalare",
          "Y'o te tabili fun,",
          "Y'o gb'ori iranse na ga",
          "Larin egbe Angel.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '71',
      verses: [
        [
          "Gba aiye mi, Oluwa,",
          "Mo ya si mimo fun O;",
          "Gba gbogbo akoko mi,",
          "Ki won kun fun iyin Re.",
        ],
        [
          "Gba owo mi, k'O si je",
          "Ki nma lo fun ife Re;",
          "Gba ese mi, k'O si je",
          "Ki nwon ma sare fun O.",
        ],
        [
          "Gba ohun mi, je ki nma",
          "K'orin f'Oba mi titi;",
          "Gba ete mi, je ki nwon,",
          "Ma j'ise fun O titi.",
        ],
        [
          "Gba wura, fadaka mi,",
          "Ookan nki o da duro;",
          "Gba ogbon mi, k'O si lo,",
          "Gege bi O ba ti fe.",
        ],
        [
          "Gba 'fe mi, fi se Tire",
          "Ki o tun je temi mo;",
          "Gb'okan mi, Tire n'ise.",
          "Ma gunwa nibe titi.",
        ],
        [
          "Gba 'feran mi Oluwa,",
          "Mo fi gbogbo re fun O;",
          "Gb'emi paapaa lat'oni",
          "Ki m'je Tire titi lai. ",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '72',
      verses: [
        [
          "Gbekele Olorun re,",
          "K'o ma nso! K'o ma nso!",
          "D'ileri Re mu sinsin,",
          "K'o ma nso!",
          "Mase se oruko Re,",
          "B'o tile mu egan was,",
          "Ma tan ihin Re kale;",
          "Si ma nso! ",
        ],
        [
          "O ti pe o s'ise Re?",
          "Sa ma nso! Sa ma nso!",
          "Oru mbo wa, mura sin!",
          "Sa ma nso!",
          "Sin n'ife at'igbagbo;",
          "Gbekele agbara Re,",
          "Fi ori ti de opin;",
          "Sa ma nso! ",
        ],
        [
          "O ti fun o ni 'rugbin?",
          "Sa ma nso! Sa ma nso!",
          "Ma gbin, 'wo o tun kore!",
          "Sa ma nso!",
          "Ma so'ra, si ma reti",
          "L'enu ona Oluwa;",
          "Y'o dahun adura re;",
          "Sa ma nso!",
        ],
        [
          "O ti wipe opin mbo?",
          "Sa ma nso! Sa ma nso!",
          "Nje fi eru mimo sin!",
          "Sa ma nso!",
          "Kristi l'atilehin re",
          "On na si ni onje re",
          "Y'o sin o de 'nu ogo",
          "Sa ma nso!",
        ],
        [
          "Ni akoko die yi:",
          "Sa ma nso! Sa ma nso!",
          "Jewo Re ni ona re:",
          "Sa ma nso!",
          "Ka ri okan Re n'nu re",
          "K'ife Re je ayo re,",
          "L'ojo aiye re gbogbo.",
          "Si ma nso!",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '73',
      verses: [
        [
          "Sise tori oru mbo! Sise li owuro!",
          "Sise nigba iri nse, sise n'nu 'tanna;",
          "Sise ki osan t'o pon, sise nigb'orun nran;",
          "Sise tori oru mbo! 'Gba se o pari.",
        ],
        [
          "Sise tori oru mbo! Sise l'osan gangan,",
          "F'akoko rere fun 'se, isimi daju,",
          "F'olukuluku igba, ni nkan lati pamo;",
          "Sise tori oru mbo! Gba 'se o pari ",
        ],
        [
          "Sise tori oru mbo! Orun fere wo na,",
          "Sise 'gbat' imole wa, ojo bulo tan,",
          "Sise titi de opin, sise tit d'ale,",
          "Sise gbat'ile ba nsu, gba 'se o pari.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '74',
      verses: [
        [
          "A o sise! A o sise! Om'Olorun ni wa,",
          "Je k'a tele ipa ti Oluwa wa to;",
          "K'a fi 'moran Re so agbara wa d'otun,",
          "K'a fi gbogbo okun wa sise t'a o se.",
        ],
        [
          "A o sise! A o sise! Bo awon t'ebi npa,",
          "K o awon alaare lo s’ orun iye!",
          "Ninu agbelebu l'awa o ma s'ogo,",
          "'Gbati a ba nkede pe, 'Ofe n'igbala",
        ],
        [
          "A o sise! A o sise! Gbogbo wa ni y'o se",
          "Ijoba okunkun at'iro yio fo,",
          "A o is gbe oruko Jehofa leke,",
          "N'nu orin, iyin wa pe, Ofe n'igbala.",
        ],
        [
          "A o sise! A o sise! L'agbara Oluwa,",
          "Agbada at'ade y'o si je ere wa;",
          "'Gbati ile awon olooto ba di tiwa,",
          "Gbogbo wa o jo ho pe, Ofe n'igbala.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Foriti! Foriti!",
        "Foriti! Foriti!",
        "Ma reti, ma sona,",
        "Titi Oluwa y'o fi de.",
      ],
    ),
    Hymn(
      id: '75',
      verses: [
        [
          "Ọkan arẹ, ile kan mbẹ,",
          "L’ọna jinjin s’ aiye iṣẹ;",
          "Ile t’ ayida ko le de,",
          "Tani ko fẹ simi nibẹ?",
        ],
        [
          "Bi wahala bo ọ mọlẹ,",
          "Ohunkohun t’o wu k’o de,",
          "W’ oke s’ ile ibukun na;",
          "Sa rọju duro, maṣe kun!",
        ],
        [
          "Bi ẹgun ba wa lọna rẹ,",
          "Ranti ori t’a f’ ẹgun de;",
          "B’ ibanujẹ bo ọkan rẹ,",
          "O ti ri bẹ f’ Olugbala.",
        ],
        [
          "Ma sisẹ lọ, maṣe ro pe,",
          "A ko gb’ adura ẹdun Rẹ;",
          "Ọjọ isimi mbọ kankan:",
          "Sa rọju duro, mase kun!",
        ],
      ],
      isChorus: true,
      chorus: [
        "Duro rọju duro, maṣe kun!",
        "Duro rọju duro, maṣe kun!",
        " Duro, duro, sa rọju, maṣe kun!",
      ],
    ),
    Hymn(
      id: '76',
      verses: [
        [
          "Wa, maa şişe,",
          "Tani gbodo s' olę ninu oko,",
          " 'Gbati gbogbo enia nkore jo?",
          "'Kaluku ni Baba paşe fun pe,",
          " \"Şişe loni.\"",
        ],
        [
          "Wa, maa şişe,",
          "Gba 'pè giga ti Angeli kò ni",
          "Mu 'hinrere to t' agba t' ewe lo: ",
          "Rá 'gbà pada: wàwà l'akoko nlo",
          "Ile su tan.",
        ],
        [
          "Wa maa şişe ",
          "Oko po, alagbaşe ko si to,",
          "A n'ibi titun gbà, a ni 'po ro:",
          "Ohun ona jinjin, at' itosi",
          "Nkigbe pe. Wa.",
        ],
        [
          "Wa, maa şişe,",
          "Le 'yemeji on aigbagbo jinna.",
          "Ko s' alailera ti kò le șe nkan:",
          "Ailera l' Olorun a maa lo ju",
          "Fun işe nla Re.",
        ],
        [
          "Wa, maa şişę,",
          "'Simi ko si, nigbat işe osan.",
          "Titi oorun yio fi wo l' alę,",
          "Ti awa o si gbo ohun ni pe,",
          "O seun omo",
        ],
        [
          "Wa, maa şişe",
          "Lala na dun, èrè rè si daju.",
          "'Bukun f'awon t' o f' ori-ti d' opin;",
          "Ayo won, 'simi won, y' o ti po to,",
          "Lod' Oluwa",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '77',
      verses: [
        [
          "Ko mi Oluwa, bi a ti",
          "Je gbohungbohun oro Rę.",
          "B'O ti wa mi, ję k' emi wa",
          "Awon omo Re t'o ti nu.",
        ],
        [
          "To mi Oluwa, ki nie to",
          "Awon așako si ona;",
          "Bo mi Oluwa, 'ki nle fi",
          "Manna Re b'awọn t' ebi npa.",
        ],
        [
          "Fun mi l' agbara; fi ese",
          "Mi mulę l'ori apata;",
          "Ki nlè na owo igbala",
          "S' awon t’ o nri sinu èsè",
        ],
        [
          "Ko mi Oluwa, ki nle fi",
          "Eko rere Rę k' elomi;",
          "F’ iye f' oro mi, kó le fò",
          "D é ikoko gbogbo okan.",
        ],
        [
          "F' isimi didun Re fun mi,",
          "Ki nle mo, b' o ti ye lati",
          "Fi pelepelę s' oro Re",
          "Fun awon ti aare ti mu.",
        ],
        [
          "Jesu, fi èkun Rę kun mi,",
          "Fi kun mi li opolopo:",
          "Ki èrò ati oro mi",
          "Kun fun ife at' iyin Re.",
        ],
        [
          "Lò mi, Oluwa, an' emi.",
          "Bi O ti fe, n’igbakugba",
          "Tit’ em' o fi r' oju Re.",
          "Ti ngo pin ninu ogo Re.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '78',
      verses: [
        [
          "E wa s' apakan, k'e simi dię,",
          "Mo mo aarę ati wahala nyin,",
          "E nu oogun oju yin nu kuro,",
          "K'e si gb'agbara n'nu agbara Mi.",
        ],
        [
          "E takete s' ohun adun aiye,",
          "E wa fun idapo t' aiye kò mò,",
          "E nikan wa lodo Mi on Baba,",
          "L'odo Mi on Baba egbe nyin kun.",
        ],
        [
          "E wa so gbogbo ohun t'e şe fun mi,",
          "So t' isegun ati t' işubu nyin,",
          "Mo mo b' işe emi ti şoro to.",
          "Ade t' o dara t' on t' omije ni",
        ],
        [
          "E wa simi; àjò na jin pupo.",
          "Aare o mu nyin, e o ku l'ona;",
          "Onje Iye wa nihin, ę wa je.",
          "Nihin l'omi Iye wa, e wa mu",
        ],
        [
          "Jade l' otun lat' odo Oluwa,",
          "Ę pada lo şişe titi su 'lę;",
          "E ko padanu wakati t'e lo",
          "Feko sii, at' isimi orun.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '79',
      verses: [
        [
          "Kil' awa y'o fun Olorun",
          "Fun gbogbo oore Rè si wa?",
          "Ao f'ayo ranti ooko Re",
          "Ao si fi tyin Rè han.",
        ],
        [
          "Iwo li Olu ife wa;",
          "L'odo Re l'a nr' ohun gbogbo;",
          "Si orisun lat'oke wa,",
          "Jek' o şan si okan gbogbo",
        ],
        [
          "Bel’ ao kede agbara Rę,",
          "At’ or ofe Re f'elese:",
          "Titi gbogb' eda y'o mo O.",
          "Ti nwon o si te 'wo si O.",
        ],
        [
          "Silekun sile fun 'se Re,",
          "Taiye at’eşu kio le see;",
          "Je k'oro Re maa gbe 'nu wa,",
          "Ki eso rè k'o wà titi.",
        ],
        [
          "Bukun eso afunrungbin!",
          "K'a le maa so eso titi,",
          "K'a tan hinrere Re k'aiye,"
              "Ati otito Re titi.",
        ],
        [
          "Ao mo titobi ipa Re.",
          "Gbat' a ba se wa pe n'ife:",
          "Bi owon n'ile Olorun.",
          "Ta o duro, t'a o ni jade mo.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '80',
      verses: [
        [
          "Ibukun mbę ninu işe Oluwa,",
          "Oso iyebiye li a nmu wa fun;",
          "Ologbon l'eni na ti ngba okàn la,",
          "Gba enikan la loni.",
        ],
        [
          "Ninu ile re, maa tan 'molę ife,",
          "Maa fi ewa Jesu han nigbakugba,",
          "A le t'ipa eyi gba enikan la,",
          "Gba enikan la loni.",
        ],
        [
          "Jade lo kede li opopo ona,",
          "Gbadura lati w'awọn aşako ri,",
          "Mu 'nu Oluwa dun ni fifa won wa;",
          "Gba enikan la loni",
        ],
        [
          "Funrugbin oro na si ibi gbogbo,",
          "Ni akoko t'o wo, wasu oro na,",
          "Mu elese wa sodo Olugbala,",
          "Gba enikan la loni.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Gba enikan la loni,",
        "L'oke ni ile ogo;",
        "Ade ogo li ere wa l'ojo na,",
        "Gba enikan la loni.",
      ],
    ),
    Hymn(
      id: '81',
      verses: [
        [
          "O ha J’ohun elo ibukun?",
          "Ife Olorun ha nşan si o ?",
          "O ha nso t'Olugbala f'elomi?",
          "O ha mura lati şişe?",
        ],
        [
          "O ha j'ohun-elo ibukun? ",
          "O ha nronu t'awon ti nşegbe?",
          "O ha nşipe fun awon ti nşako?",
          "Lati w'Olugbala t'o ku.",
        ],
        [
          "O ha Johun-elo ibukun?",
          "Aiye rę ha nso ti ifę Re?",
          "O ha ti soro igbala fun won?",
          "Awon ti nku ninu eşę.",
        ],
        [
          "A kò le je ohun-elo fun,",
          "Bi ese ba njoba ninu wa;",
          "Ohun ikose at'idigbolu,",
          "L'ao je f'awon t'o yi wa ka.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Se mi l'ohun-elo loni, Baba,",
        "Şe mi l'ohun-elo emi mbę O:",
        "Kun aiye mi, si bukun işe mi,",
        "Şe mi l'ohun-elo loni, Baba",
      ],
    ),
    Hymn(
      id: '82',
      verses: [
        [
          "Awon ti nkore s'inu aba da?",
          "Awon ti nşa alikama s'oto?",
          "Nwon mu daje otito l'owo won,",
          "Nwon kò simt titi d'ajo 'kore.",
        ],
        [
          "E lo si abuja-ona pelu,",
          "Alikama le wa larin èpo;",
          "Wa won li opopo ona pelu,",
          "E ko won jo di ojo ikore.",
        ],
        [
          "Oko na ti pon tan fun ikore,",
          "Aiye nduro de ojo ikore,",
          "Ise po, alagbaşe ko to nkan,",
          "Pupo ni y'o segbe bi a lora.",
        ],
        [
          "E dide, e mu doje nyin lowo,",
          "Bère ise ti Oluwa ran yin;",
          "Oluwa ikore fere de na,",
          "Şişe titie o kore de 'le.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Olukore da? Tani y'o wa ",
        "Lati le pin ninu ayo ikore?",
        "Tani y'o ba wa kojo s'aba",
        "Lati ko alikama s'aba",
      ],
    ),
    Hymn(
      id: '83',
      verses: [
        [
          "O ti dùn to lati rohin Re",
          "Lati so ti Jesu f'elomi;",
          "K'a ba le dari ji elese.",
          "K'a si fi Krist t'a kan mo",
          "'gi han won;",
          "Ayo okan wa ti po to,",
          "'Gbat' elese ronupiwada;",
          "Ti aşako pada bo wa 'le,",
          "Ti okunkun rè si di imolę.",
        ],
        [
          "O ti dun to lati rohin Re.",
          "Lati so ti Jesu f'elomi;",
          "Lati yo awon ti nşegbe lo,",
          "Lati mu won pada sodo Baba,",
          "Ti ayo larin angeli",
          "At'ayo 'gbala n'nu eleşę:",
          "Gbati asako pada wa 'le,",
          "Kò si ayo t'a le fi we' eyi",
        ],
        [
          "Nigbose orin irapada",
          "L'ao ma ko l'oke l'awosanma;",
          "Y'o de bi Oba lati pe wa;",
          "Kuro laiye nibit' O ku fun wa",
          "Gbogbo awon t'a rapada",
          "Y'o pejo l'ese Rè ni sanma",
          "Gbogbo won y'o ko Halleluya,",
          "Ao korin 'gba ba pade Oluwa.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Oruko didun ti Jesu,",
        "Oruko ti a nfe julo ni;",
        "Orin t'o dun julo ni l'eti,",
        "Orin mi ni l'osan ati l'oru.",
      ],
    ),
    Hymn(
      id: '84',
      verses: [
        [
          "Ji, 'wo Kristian, k'o ki ooro ayo",
          "Ti a bi Olugbala araiye;",
          "Dide, k'o korin ife Olorun,",
          "T' awon Angeli nko n' ijo kini,",
          "Lat' odo won n' ihin na ti bere:",
          "Ihin Om' Olorun t'a bi s' aiye.",
        ],
        [
          "'Gbana l' a ran akede Angeli,",
          "T'o so f' awon Oluşagutan, pe,",
          "Mo mu hinrere Olugbala wa,",
          "T'a bi fun nyin ati gbogbo aiye",
          "Olorun mu 'leri Rè se l'oni",
          "A bi Olugbala Krist' Oluwa.",
        ],
        [
          "Bi akede Angel' na ti so tan,",
          "Opolopo ogun orun si de;",
          "Nwon nkorin ayo t' eti ko gbo ri,",
          "Orun si ho fun 'yin Olorun pe,",
          "Ogo nif' Olorun l' oke orun,"
              "Alafia at' ife s' enia.",
        ],
        [
          "O ye kawa k' o ma rò l'okan wa,",
          "Ife nla t'Olorun ni s' araiye:",
          "K'a si ro t'omo na t' a bi loni,",
          "T’ o wa jiya oro agbelebu,",
          "Ki awa si tele ilana Re",
          "Titi a o fi de bugbe l' oke.",
        ],
        [
          "Nigbana 'gba ba de orun l'ohun.",
          "A o korin ayo t' irapada;",
          "Ogo Enit' a bi fun wa loni,",
          "Y'o ma ran yi wa ka titi lailai,",
          "A o ma korin ife Rè titi.",
          "Oba Angeli, Oba enia.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '85',
      verses: [
        [
          "Enyin Angel l' orun ogo,",
          "To yi gbogbo aiye ka;",
          "E ti korin dida aiye,",
          "E so t' ibi Messia;",
        ],
        [
          "Enyin Oluşo-agutan,",
          "Ti nso eran yin l'oru,",
          "Emmanueli wa ti de",
          "Irawo Omo na ntan;",
        ],
        [
          "Onigbagbo ti nteriba,",
          "Ni 'beru at' ireti",
          "L'ojiji l' Oluwa o de",
          "Ti yio mu nyin re 'le",
        ],
      ],
      isChorus: true,
      chorus: [
        "E wa josin ,E wa josin",
        "Fun Kristi Oba titun",
      ],
    ),
    Hymn(
      id: '86',
      verses: [
        [
          "Gbo eda orun nko 'rin",
          "Ogo fun Oba t'a bi",
          "Alafia l'aiye yi",
          "Olorun ba wa la ja,",
          "Gbogbo eda, nde l' ayo",
          "Dapo mo hiho orun;",
          "W’Alade alafia!",
          "Wo Oorun ododo de",
        ],
        [
          "O bo 'go Rè s'apakan,",
          "A bi k'enia ma ku,",
          "A bi k' o gb'enia ro,",
          "A bi k'o le tun wa bi",
          "Wa, ireti enia,",
          "şe ile Rę ninu wa;",
          "N' de, iru Qmobinrin,",
          "Bori eşu ninu wa.",
        ],
        [
          "Pa aworan Adam run,",
          "Faworan Re s' ipo re",
          "Jo, masai f' Emi Re kun",
          "Okan gbogb' onigbagbo,",
          "Ogo fun Oba t' a bi,",
          "Je ki gbogbo wa gberin.",
          "Alafia l'aiye yi,",
          "Olorun ba wa la ja.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Gbo ęda orun nko'rin,",
        "Ogo fun Oba t'a bi",
      ],
    ),
    Hymn(
      id: '87',
      verses: [
        [
          "Ayo b' aiye ! Oluwa de;",
          "K'aiye gba Oba rè:",
          "Ki gbogbo okan mura de, ",
          "K'aiye korin s'oke",
        ],
        [
          "Ayo b'aiye! Jesu Joba,",
          "E je k'a ho f' ayo;",
          "Gbogbo igbe, omi, oke,",
          "Nwon ngberin ayo na.",
        ],
        [
          "K' ese on 'yonu pin l'aiye,",
          "K' egun ye hu n' lle:",
          "O de lati mu bukun şan",
          "De 'bi t' egun gbe de.",
        ],
        [
          "O f'ooto at' ife joba,",
          "O je k' oril' ede,",
          "Mo ododo ijoba Re.",
          "At' ife 'yanu Re.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '88',
      verses: [
        [
          "Ayo kun okan wa l'oni",
          "A bi Omo Oba;",
          "Opo awon ogun orun,",
          "Nso ibi Rè loni;",
        ],
        [
          "A wolę n' ibuje eran,",
          "N' iyanu l' a josin:",
          "Ibukun kan ko ta 'yi yo.",
          "Ko s' ayo bi eyi.",
        ],
        [
          "Aiye ko n' adun fun wa mo.",
          "'Gbati a ba nwo o:",
          "L'owo Wundia iya Re,",
          "'Wo Omo Iyanu,",
        ],
        [
          "Imolę lat'inu 'Molę.",
          "Tan 'mole s' ōkun wa;",
          "K'a le mă fi isin mimo",
          "Şe 'ranti ojo re",
        ],
      ],
      isChorus: true,
      chorus: [
        "E yo Olorun d' enia,",
        "O wa joko l'aiye;",
        "Oruko wo l'o dun to yi",
        "Emmanuel.",
      ],
    ),
    Hymn(
      id: '89',
      verses: [
        [
          "Onigbagbo, e bu s'ayo!",
          "Ojo nla l' eyi fun wa;",
          "K' orun f' ayo korin kikan,",
          "K' igbo at' odan gberin.",
          "E ho! yo! E hole yo!",
          "Okun at odo gbogbo.",
        ],
        [
          "E Jumo yo, gbogbo eda,",
          "L'aiye yi ati l'orun:",
          "Ki gbogbo ohun alaye",
          "Nile, l'oke yin Jesu.",
          "E fogo fun, Ę f' ogo fun",
          "Oba nla t'a bi loni!",
        ],
        [
          "E damuso! E damuso;",
          "Ę ho ye; kę si ma yo!",
          "Itegun eşu fo wayi,",
          "\"Iru-omobirin\" de!",
          "Halleluya! Halleluya:",
          "Olurapada Oba.",
        ],
        [
          "Egb' ohun nyin ga, Serafu,",
          "Kerubu, l'ęba ite:",
          "Angeli at' enyin mimo,",
          "Pelu gbogb' ogun orun,",
          "Ę ba wa yo! E ba wa yo!",
          "Odun idasilę de.",
        ],
        [
          "Metalokan, Eni Mimo,",
          "Baba, Olodumare",
          "Emi Mimo, Olutunu,",
          "Jesu, Olurapada,",
          "Gba iyin wa, Gba iyin wa,",
          "Wo nikan l'ogo ye fun.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '90',
      verses: [
        [
          "Wa ẹnyin olotọ,",
          "L’ayọ at’ iṣẹgun,",
          "Wa kalọ, wa kalọ si Bẹtlehẹm",
          "Wa kalọ wo o!",
          "Ọba awọn Angẹl!",
        ],
        [
          "Olodumare ni,",
          "Imọlẹ Ododo,",
          "Ko si korira inu Wundia;",
          "Ọlọrun papa ni,",
          "Ti a bi, t’ a ko da:",
        ],
        [
          "Angẹli, ẹ kọrin,",
          "Kọrin itoye rẹ;",
          "Ki gbogbo ẹda ọrun si gberin:",
          "Ogo f’ Ọlọrun",
          "L’ oke ọrun lọhun:",
        ],
        [
          "Nitotọ, a wolẹ",
          "F’ Ọba t’a bi loni;",
          "Jesu Iwọ li awa nfi ogo fun:",
          "‘Wọ ọmọ Baba,",
          "T’o gbe ara wa wọ!",
        ],
      ],
      isChorus: true,
      chorus: [
        "Ẹ wa kalọ juba Rẹ,",
        "Ẹ wa kalọ juba Rẹ,",
        "Ẹ wa k’a lọ juba",
        "Kristi Oluwa.",
      ],
    ),
    Hymn(
      id: '91',
      verses: [
        [
          "Nigba kan ni Bethlehemu,",
          "Ile kekere kan wa;",
          "Nib' iya kan te 'mo re si.",
          "Lori ibuje eran:",
          "Maria n' iya Omo na,",
          "Jesu Krist' si l' Omo na.",
        ],
        [
          "O t'orun wa s' ode aiye,",
          "On l'Olorun Oluwa;",
          "O f' ile eran şe ile,",
          "'Buje eran fun 'busun,",
          "Lodo awon otoşi",
          "Ni Jesu gbe li aiye.",
        ],
        [
          "Ni gbogbo igbà ewe Re",
          "O ngboran, O si mb'ola,",
          "O nferan O si nteriba,",
          "Fun iya ti ntoju Re:",
          "Oye ki gbogb' omode",
          "K'o se olugboran be",
        ],
        [
          "Tori On je awose, wa,",
          "A må dagba bi awa,",
          "O kere, ko le da nkan şe,",
          "A mã sokun bi awa;",
          "O si le ba wa darò,",
          "O le ba wa yo pelu.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '92',
      verses: [
        [
          "Ni'dakeje, oru mimo,",
          "Ökün şu, 'molę de,",
          "Awon oluş' agutan nşona,",
          "Omo t'o wà l'oju ōrun,",
          "Simi n'nu alafia",
          "Simi n'nu alafia.",
        ],
        [
          "Ni 'dakę je, oru mimo,",
          "'Mole de ökún sá,",
          "Oluş' agutan gb' orin Angel,",
          "Kabiyesi alleluya Oba,",
          "Jesu Olugbala de",
          "Jesu Olugbala de.",
        ],
        [
          "Ni 'dakę je, oru mimo,",
          "'Rawo orun tàn 'mole",
          "Wo awon Amoye ila ōrun,",
          "Mu ore won wa fun Oba wa,",
          "Jesu Olugbala de",
          "Jesu Olugbala de.",
        ],
        [
          "Ni 'dakeje, oru mimo.",
          "Rawo orun tàn 'mole,",
          "K'a pelu awon Angel korin,",
          "Kabiyesi alleluya Oba",
          "Jesu Olugbala de",
          "Jesu olugbala de",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '93',
      verses: [
        [
          "Jesu Oluwa mi ni Betlehem",
          "N' ibuje eran lt a gbe bi si",
          "A! iyanu ni, yin Oruko Re",
          "Enit' O wa mi ri",
          "O wa mi ri, an'emi,",
          "(O wa mi ri, O wa mi ri) ",
          "O wa mi ri, an' emi",
          "Al iyanu ni, yin Oruko Re",
          "Enit' O wa mi ri.",
        ],
        [
          "Jesu Oluwa mi ni Kalfari",
          "San 'gbese ese mo d' ominira",
          "A! lyanu ni pe O ku fun mi",
          "Elese bi emi",
          "O ku fun mi, fun mi,",
          "(O ku fun mi, O ku fun mi)",
          "O ku fun mi, fun mi,",
          "A! iyanu ni pe O ku fun mi,",
          "Elese bi emi",
        ],
        [
          "Jesu Oluwa mi, bakanna ni,",
          "Enit' O wa mi gbà mo nşako lo",
          "Jeje l' O ba mi s'oro t'o pe mi,",
          "o pe mi s'odo Re.",
          "Onkepe mi, an' emi,",
          "(O nkepe mi, wa s' odo mi)",
          "Onkepe mi, an' emi,",
          "Je je l'Omba mi s' oro t' O pe n",
          "O pe mi s' odo Re.",
        ],
        [
          "Jesu Oluwa mi tun npada bò̟,",
          "Ileri didun l' eyi je fun mi;",
          "Oju mi y' ori b' O ti nsokalę,",
          "Bo lati wa mu mi",
          "(Onpada bo y'o wa mu mi)",
          "Onpada bo fun mi",
          "Onpada bo fun mi",
          "O ju mi y'o ri b'o ti nsokalę,",
          "Onpada bo fun mi.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '94',
      verses: [
        [
          "Ogo f'Olorun lok' orun,",
          "Ogo, ogo ni f'Olorun;",
          "Ogo f'Olorun lok' orun,",
          "Li orin wa loni.",
          "Orin ti owuro ayo,",
          "Ti a bi omo Dafidi;",
          "Ti ogun orun ko, awa",
          "Si fe dapo mo ogun na.",
        ],
        [
          "Ogo f' Olorun lok' orun,",
          "Ogo, ogo ni f' Olorun;",
          "Ogo f' Olorun lok' orun,",
          "Li orin wa loni.",
          "Anu ti a nri gba fihan.",
          "Bi ife Re ti tobi to;",
          "Jęki a gbohun wa s'oke,",
          "Korin lyin Olugbala.",
        ],
        [
          "Ogo f' Olorun lok'orun,",
          "Ogo, ogo ni f' Olorun;",
          "Ogo f' Olorun lok' orun,",
          "Li orin wa loni.",
          "Jęki awa le duro pę,",
          "Niwaju te Olugbala;",
          "K' a korin pel' awon Angel.",
          "At' awon eni 'rapada.",
        ],
      ],
      isChorus: true,
      chorus: [
        "Ogo f' Olorun lok' orun",
        "Ogo, f' Olorun lok' orun;",
        "Ogo, ogo, ogo, ogo!",
        "Ogo f' Olorun l'oke.",
      ],
    ),
    Hymn(
      id: '95',
      verses: [
        [
          "Lehin odun dię,",
          "Lehin igba die,",
          "A o ko wa jo pel‘ awon",
          "Ti o sun n'iboji",
        ],
        [
          "Lehin ojo dię",
          "L'aiye buburu yi",
          "A o de bi ōrun kò si mo;",
          "Ilę daradara."
        ],
        [
          "Lehin igbi dię",
          "L'ebute lile yi,",
          "A o de b' iji ko si mo.",
          "T'okun ki bù s'oke.",
        ],
        [
          "Lehin 'yonu die.",
          "Lehin 'pinya dię,",
          "Lehin ekun ati aro,",
          "A ki o sokun mo,",
        ],
        [
          "Ojo 'simi dię,",
          "L'a ni tun ri l'aiye,",
          "A o de ibi isimi,",
          "Ti ki o pin lailai",
        ],
      ],
      isChorus: true,
      chorus: [
        "Oluwa, mu mi ye",
        "Fun ojo nlanla na!",
        "Jo we mi ninu eje Re",
        "Si ko ese mi lo.",
      ],
    ),
    Hymn(
      id: '96',
      verses: [
        [
          "Igba mi mbę li owo Re.",
          "A fe k'o wà nibę",
          "A f'ara wa at' ore wa",
          "Si abe iso Re.",
        ],
        [
          "Igba mi mbę li owo Re",
          "Awa o se beru?",
          "Baba ki y'o je k' omo Rè,",
          "Sokun li ainidi.",
        ],
        [
          "Igba mi mbę li owo Re.",
          "Wo la o gbekele,",
          "Tit' a o f' aiye oşi le",
          "T’a o si r’ogo Re",
        ],
        [
          "Igba mi mbę li owo Re",
          "Jesu t'agbelebu;",
          "Owo na t'eşe mi dalu,",
          "Wa di alabo mi",
        ],
        [
          "Igba mi mbę li owo Re:",
          "Ngo mã simi le O",
          "Lehin iku, low' otun Re.",
          "L'em' o wa titi lai.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '97',
      verses: [
        [
          "Apata aiyeraye,",
          "Enit' O mbę lailai,",
          "Nigbakugba t'iji nja,",
          "Wo 'bugbe alafia:",
          "Ş'aju did' aiye wa yi,",
          "Iwo mbe, bakanna:",
          "Tit' aiye ainipekun,",
          "Aiyeraiye ni 'Wo.",
        ],
        [
          "Oj’ odun wa ri b'oji,",
          "To hàn l' ori oke;",
          "Bi koriko ipa 'dò,",
          "Toru ti o si ku:",
          "Bi àlá; tabi b' itàn,",
          "Tenikan nyara pa:",
          "Ogo ti kò ni si mo.",
          "Ohun t' o gbo tan ni",
        ],
        [
          "'Wo eniti ki togbe",
          "'Mole enit' itȧn;",
          "Ko wa bi a o ti ka",
          "Ojo wa k'o to tan;",
          "Je k ănu Re bi le wa,",
          "K' Ore Rę po fun wa;",
          "Si je K' Emi Mimo Re.",
          "Molę si okan wa.",
        ],
        [
          "Jesu, f' ewa at' oore,",
          "De 'gbagbo wa l'ade;",
          "Tit' ao fi ri o gbangba,",
          "Ninu 'molę lailai;",
          "Ayo t'enu ko le so,",
          "Orisun akunya,",
          "Alafia ailopin,",
          "Okun ailebute.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '98',
      verses: [
        [
          "Olorun, t’odun t’o Koja",
          "Iret’ eyi ti mbo;",
          "Ib’isadi wa ni iji,",
          "At’ile wa lailai,",
        ],
        [
          "Labe ojiji ite Re",
          "L’awon enia Re ngbe!",
          "Tito l’apa Re nikanso,",
          "Abo wa si daju.",
        ],
        [
          "K’awon oke k’o to duro,",
          "Tabi K’a to d’aiye,",
          "Lailai iwo ni Olorun",
          "Bakanna, l’ailopin!",
        ],
        [
          "Egberun odun l’oju Re,",
          "Bi ale kan l’o ri;",
          "B’iso kan l’afemojumo’",
          "Ki orun k’o to la.",
        ],
        [
          "Ojo wa, bi odo sisan,",
          "Opo l’o I ngbe lo;",
          "Nwon nlo, nwon di eni’Gbagbe",
          "Bi ala ti a nro.",
        ],
        [
          "Olorun t’odun t’o koja",
          "Ireti eyi ti mbo,",
          "Ma s’abo wa ‘gba ‘yonu de",
          "At’ile wa lailai.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '99',
      verses: [
        [
          "Ojo ati akoko nio.",
          "Nwon sun wa s' eti 'boji;",
          "Awa fere dubulę na,",
          "Ninu iho 'busun wa.",
        ],
        [
          "Jesu, 'Wo Olurapada",
          "Ji okan t'o ku s' ese:",
          "Ji gbogbo okan ti n togbe,",
          "Lati yan ipo iye.",
        ],
        [
          "Bi akoko ti nsunmole,",
          "Je k'a ro 'bi ti a nlo",
          "Bi lati r' ayo ailopin,",
          "Tabi egbe ailopin.",
        ],
        [
          "Aiye wa mkoja b' ojiji",
          "O si nfò lo bi küků;",
          "Fun gbogbo odun t'o koja",
          "Dariji wa, mu wa gbon.",
        ],
        [
          "Ko wa lati ka ojo wa,",
          "Lati ba ese wa ja;",
          "K'a mã sare, k' a ma tögbe",
          "Tit' a o fi ri 'simi",
        ],
        [
          "Gbogbo wa fere duro na",
          "Niwaju itę ogo",
          "Jesu 'Wo t'O segun iku",
          "Fi wa s' apa otun Re.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
    Hymn(
      id: '100',
      verses: [
        [
          "B' oorun l' aiduro ti nrin,",
          "La odun ti o lo ja",
          "Be l'opo ti d' opin won",
          "A ki o si ri won mo.",
        ],
        [
          "A so won lojo lailai,",
          "Tiwon pari li aiye,",
          "Awa duro dię na.",
          "Yo ti pę to, a kò mò̟.",
        ],
        [
          "Gb' ope f' anu t'o koja,",
          "Tun dar' ese ji wa;",
          "Ko wa b'a ti wà, ki a mã",
          "Şe 'ranti aiye ti mbo.",
        ],
        [
          "Bukun f' ewe at' agha,",
          "F’ ife Oluwa kun wa;",
          "'Gba ojo aiye wa pin,",
          "K'a gbe odo Re l' oke.",
        ],
      ],
      isChorus: false,
      chorus: [''],
    ),
  ];
}
