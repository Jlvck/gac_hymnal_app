import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './hymn.dart';

class HymnBook with ChangeNotifier {
  Hymn getHymn(String hymnNumber) {
    return _hymnBook.firstWhere((hymn) => hymn.id == hymnNumber);
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
          "Ji mi s'aiye ainipekun."
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
          "Kemi si le f' ife Re han."
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
          "Ki nmaa sora nigba gbogbo,"
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
          "Imolę oorg didun yi",
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
    )
  ];
}
