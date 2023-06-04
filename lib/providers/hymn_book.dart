import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './hymn.dart';

class HymnBook with ChangeNotifier {
  Hymn getHymn(String hymnNumber) {
    return _hymnBook.firstWhere((hymn) => hymn.id == hymnNumber);
  }

  List<Hymn> get hymnList {
    return [..._hymnBook];
  }

  final List<Hymn> _hymnBook = [
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
          "Imolę ooro didun yi",
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
            "Iwo Imolę okan mi,",
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
            "'Wo imolę larin ookun aiye,",
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
  ];
}
