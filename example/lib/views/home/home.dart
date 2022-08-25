// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:proteins_example/providers/auth_provider.dart';
import 'package:proteins_example/views/auth/login_view.dart';
import 'package:proteins_example/views/sceneKit/scene_kit_page.dart';
import 'package:provider/provider.dart';

import '../../utils/config_theme.dart';
import '../../utils/palette.dart';

class HomeViewController extends StatefulWidget {
  const HomeViewController({Key? key}) : super(key: key);

  static const String routename = '/home';

  @override
  State<HomeViewController> createState() => _HomeViewControllerState();
}

class _HomeViewControllerState extends State<HomeViewController>
    with WidgetsBindingObserver {
  final List<Map<String, dynamic>> _allProteins = [
    {"id": "proteinquimarchepas"},
    {"id": "001"},
    {"id": "011"},
    {"id": "031"},
    {"id": "041"},
    {"id": "04G"},
    {"id": "083"},
    {"id": "0AF"},
    {"id": "0DS"},
    {"id": "0DX"},
    {"id": "0E5"},
    {"id": "0EA"},
    {"id": "0J0"},
    {"id": "0JV"},
    {"id": "0L8"},
    {"id": "0MC"},
    {"id": "0MD"},
    {"id": "0RU"},
    {"id": "0RY"},
    {"id": "0RZ"},
    {"id": "0S0"},
    {"id": "0T6"},
    {"id": "0T7"},
    {"id": "0Z9"},
    {"id": "10R"},
    {"id": "10S"},
    {"id": "10U"},
    {"id": "11O"},
    {"id": "11U"},
    {"id": "12I"},
    {"id": "12P"},
    {"id": "12U"},
    {"id": "13M"},
    {"id": "13R"},
    {"id": "13S"},
    {"id": "13U"},
    {"id": "140"},
    {"id": "147"},
    {"id": "15F"},
    {"id": "15P"},
    {"id": "16A"},
    {"id": "16G"},
    {"id": "18M"},
    {"id": "18Q"},
    {"id": "196"},
    {"id": "1B0"},
    {"id": "1C5"},
    {"id": "1CO"},
    {"id": "1CY"},
    {"id": "1E2"},
    {"id": "1H2"},
    {"id": "1H3"},
    {"id": "1HP"},
    {"id": "1KT"},
    {"id": "1KU"},
    {"id": "1KY"},
    {"id": "1KZ"},
    {"id": "1MA"},
    {"id": "1MV"},
    {"id": "1PE"},
    {"id": "1PG"},
    {"id": "1QV"},
    {"id": "1SZ"},
    {"id": "1UD"},
    {"id": "1WJ"},
    {"id": "1WK"},
    {"id": "1YO"},
    {"id": "200"},
    {"id": "210"},
    {"id": "22J"},
    {"id": "22M"},
    {"id": "233"},
    {"id": "234"},
    {"id": "23I"},
    {"id": "244"},
    {"id": "272"},
    {"id": "27E"},
    {"id": "27G"},
    {"id": "27H"},
    {"id": "27J"},
    {"id": "27K"},
    {"id": "27L"},
    {"id": "27M"},
    {"id": "27N"},
    {"id": "29N"},
    {"id": "29O"},
    {"id": "2AN"},
    {"id": "2F8"},
    {"id": "2HP"},
    {"id": "2MG"},
    {"id": "2MO"},
    {"id": "2PE"},
    {"id": "2RY"},
    {"id": "2TL"},
    {"id": "2V4"},
    {"id": "2WL"},
    {"id": "2WQ"},
    {"id": "2WR"},
    {"id": "2XE"},
    {"id": "2XG"},
    {"id": "2XH"},
    {"id": "2XO"},
    {"id": "2XR"},
    {"id": "2YZ"},
    {"id": "30L"},
    {"id": "30U"},
    {"id": "32H"},
    {"id": "32J"},
    {"id": "338"},
    {"id": "369"},
    {"id": "36Y"},
    {"id": "372"},
    {"id": "37V"},
    {"id": "38D"},
    {"id": "397"},
    {"id": "398"},
    {"id": "3A8"},
    {"id": "3AW"},
    {"id": "3BR"},
    {"id": "3DG"},
    {"id": "3DR"},
    {"id": "3E4"},
    {"id": "3EL"},
    {"id": "3FG"},
    {"id": "3GY"},
    {"id": "3GZ"},
    {"id": "3H0"},
    {"id": "3H2"},
    {"id": "3HA"},
    {"id": "3HM"},
    {"id": "3HU"},
    {"id": "3JP"},
    {"id": "3JQ"},
    {"id": "3JR"},
    {"id": "3MY"},
    {"id": "3NM"},
    {"id": "3OM"},
    {"id": "3PG"},
    {"id": "3QZ"},
    {"id": "3SN"},
    {"id": "3SX"},
    {"id": "3TI"},
    {"id": "3TR"},
    {"id": "3TS"},
    {"id": "3UH"},
    {"id": "3XU"},
    {"id": "40F"},
    {"id": "40K"},
    {"id": "418"},
    {"id": "429"},
    {"id": "42H"},
    {"id": "42M"},
    {"id": "43F"},
    {"id": "442"},
    {"id": "444"},
    {"id": "44B"},
    {"id": "458"},
    {"id": "459"},
    {"id": "45U"},
    {"id": "46U"},
    {"id": "480"},
    {"id": "482"},
    {"id": "49U"},
    {"id": "4AA"},
    {"id": "4AW"},
    {"id": "4D8"},
    {"id": "4DB"},
    {"id": "4FC"},
    {"id": "4FW"},
    {"id": "4HM"},
    {"id": "4IN"},
    {"id": "4KV"},
    {"id": "4MQ"},
    {"id": "4NA"},
    {"id": "4NL"},
    {"id": "4TC"},
    {"id": "4TX"},
    {"id": "4UX"},
    {"id": "4UY"},
    {"id": "4UZ"},
    {"id": "4V2"},
    {"id": "4V3"},
    {"id": "4V5"},
    {"id": "4VO"},
    {"id": "4XE"},
    {"id": "4XF"},
    {"id": "50U"},
    {"id": "523"},
    {"id": "52P"},
    {"id": "555"},
    {"id": "5AL"},
    {"id": "5B5"},
    {"id": "5B7"},
    {"id": "5B8"},
    {"id": "5BR"},
    {"id": "5CD"},
    {"id": "5FB"},
    {"id": "5FW"},
    {"id": "5GP"},
    {"id": "5KH"},
    {"id": "5MB"},
    {"id": "5MC"},
    {"id": "5MU"},
    {"id": "5NU"},
    {"id": "5OB"},
    {"id": "5PG"},
    {"id": "5UC"},
    {"id": "5UD"},
    {"id": "5YI"},
    {"id": "62D"},
    {"id": "689"},
    {"id": "697"},
    {"id": "6AP"},
    {"id": "6NA"},
    {"id": "6RG"},
    {"id": "6UA"},
    {"id": "6W2"},
    {"id": "789"},
    {"id": "795"},
    {"id": "797"},
    {"id": "7AP"},
    {"id": "7DG"},
    {"id": "7HP"},
    {"id": "7MG"},
    {"id": "7YG"},
    {"id": "833"},
    {"id": "834"},
    {"id": "870"},
    {"id": "880"},
    {"id": "889"},
    {"id": "893"},
    {"id": "8HG"},
    {"id": "8K6"},
    {"id": "8LR"},
    {"id": "8OG"},
    {"id": "941"},
    {"id": "965"},
    {"id": "9DG"},
    {"id": "9LI"},
    {"id": "9OH"},
    {"id": "9PR"},
    {"id": "A1E"},
    {"id": "A23"},
    {"id": "A2E"},
    {"id": "A2G"},
    {"id": "A2M"},
    {"id": "A37"},
    {"id": "A3P"},
    {"id": "A48"},
    {"id": "A74"},
    {"id": "A8B"},
    {"id": "A8M"},
    {"id": "A8N"},
    {"id": "AAC"},
    {"id": "AAM"},
    {"id": "AB1"},
    {"id": "ABA"},
    {"id": "ABN"},
    {"id": "ABU"},
    {"id": "AC6"},
    {"id": "AC9"},
    {"id": "ACA"},
    {"id": "ACE"},
    {"id": "ACH"},
    {"id": "ACP"},
    {"id": "ACT"},
    {"id": "ACY"},
    {"id": "AD4"},
    {"id": "ADE"},
    {"id": "ADN"},
    {"id": "ADP"},
    {"id": "ADV"},
    {"id": "ADX"},
    {"id": "AEJ"},
    {"id": "AEK"},
    {"id": "AGA"},
    {"id": "AGP"},
    {"id": "AGS"},
    {"id": "AH0"},
    {"id": "AHB"},
    {"id": "AHU"},
    {"id": "AIH"},
    {"id": "AIJ"},
    {"id": "AIT"},
    {"id": "AIU"},
    {"id": "AJM"},
    {"id": "AKG"},
    {"id": "ALC"},
    {"id": "ALE"},
    {"id": "ALF"},
    {"id": "ALO"},
    {"id": "ALS"},
    {"id": "ALY"},
    {"id": "AMH"},
    {"id": "AMP"},
    {"id": "ANC"},
    {"id": "ANN"},
    {"id": "ANP"},
    {"id": "AOM"},
    {"id": "AON"},
    {"id": "APC"},
    {"id": "APG"},
    {"id": "APR"},
    {"id": "ARA"},
    {"id": "ARG"},
    {"id": "ARL"},
    {"id": "ASC"},
    {"id": "ASD"},
    {"id": "AT1"},
    {"id": "ATP"},
    {"id": "AU"},
    {"id": "AUK"},
    {"id": "AV2"},
    {"id": "AVX"},
    {"id": "AYX"},
    {"id": "AZG"},
    {"id": "AZI"},
    {"id": "AZS"},
    {"id": "AZZ"},
    {"id": "B12"},
    {"id": "B3A"},
    {"id": "B3D"},
    {"id": "B3E"},
    {"id": "B3Q"},
    {"id": "B49"},
    {"id": "BA"},
    {"id": "BAL"},
    {"id": "BAM"},
    {"id": "BBU"},
    {"id": "BBX"},
    {"id": "BBY"},
    {"id": "BCL"},
    {"id": "BCP"},
    {"id": "BCR"},
    {"id": "BCT"},
    {"id": "BE2"},
    {"id": "BEF"},
    {"id": "BEN"},
    {"id": "BER"},
    {"id": "BG6"},
    {"id": "BG8"},
    {"id": "BGC"},
    {"id": "BGL"},
    {"id": "BGU"},
    {"id": "BHG"},
    {"id": "BHL"},
    {"id": "BHM"},
    {"id": "BM6"},
    {"id": "BMA"},
    {"id": "BMC"},
    {"id": "BME"},
    {"id": "BMM"},
    {"id": "BMT"},
    {"id": "BNS"},
    {"id": "BNZ"},
    {"id": "BO3"},
    {"id": "BOA"},
    {"id": "BOG"},
    {"id": "BPH"},
    {"id": "BR"},
    {"id": "BS1"},
    {"id": "BS2"},
    {"id": "BTD"},
    {"id": "BTN"},
    {"id": "BU3"},
    {"id": "BUA"},
    {"id": "BV1"},
    {"id": "BV2"},
    {"id": "BV3"},
    {"id": "BV4"},
    {"id": "BVD"},
    {"id": "BXY"},
    {"id": "BZI"},
    {"id": "BZX"},
    {"id": "C03"},
    {"id": "C09"},
    {"id": "C1O"},
    {"id": "C1Q"},
    {"id": "C2O"},
    {"id": "C3F"},
    {"id": "C6Q"},
    {"id": "C7J"},
    {"id": "C7L"},
    {"id": "C7U"},
    {"id": "C7W"},
    {"id": "C8E"},
    {"id": "C8F"},
    {"id": "C8M"},
    {"id": "C8P"},
    {"id": "CA"},
    {"id": "CAA"},
    {"id": "CAC"},
    {"id": "CAF"},
    {"id": "CAP"},
    {"id": "CAT"},
    {"id": "CB3"},
    {"id": "CBE"},
    {"id": "CBJ"},
    {"id": "CCN"},
    {"id": "CCS"},
    {"id": "CD"},
    {"id": "CDK"},
    {"id": "CDL"},
    {"id": "CF2"},
    {"id": "CF4"},
    {"id": "CFP"},
    {"id": "CH6"},
    {"id": "CHO"},
    {"id": "CHP"},
    {"id": "CI2"},
    {"id": "CIS"},
    {"id": "CIT"},
    {"id": "CJZ"},
    {"id": "CL"},
    {"id": "CLA"},
    {"id": "CLR"},
    {"id": "CM3"},
    {"id": "CM4"},
    {"id": "CME"},
    {"id": "CMO"},
    {"id": "CMP"},
    {"id": "CN2"},
    {"id": "CO"},
    {"id": "CO2"},
    {"id": "CO3"},
    {"id": "COA"},
    {"id": "COI"},
    {"id": "CP6"},
    {"id": "CPC"},
    {"id": "CPJ"},
    {"id": "CPK"},
    {"id": "CPS"},
    {"id": "CPT"},
    {"id": "CS"},
    {"id": "CSD"},
    {"id": "CSO"},
    {"id": "CSS"},
    {"id": "CSX"},
    {"id": "CTN"},
    {"id": "CTO"},
    {"id": "CTP"},
    {"id": "CU"},
    {"id": "CU1"},
    {"id": "CUA"},
    {"id": "CUR"},
    {"id": "CXM"},
    {"id": "CXS"},
    {"id": "CYN"},
    {"id": "CYS"},
    {"id": "CZA"},
    {"id": "D12"},
    {"id": "D4P"},
    {"id": "D75"},
    {"id": "DAB"},
    {"id": "DAH"},
    {"id": "DAL"},
    {"id": "DAO"},
    {"id": "DBB"},
    {"id": "DCQ"},
    {"id": "DCS"},
    {"id": "DDE"},
    {"id": "DDT"},
    {"id": "DG2"},
    {"id": "DGD"},
    {"id": "DGL"},
    {"id": "DHF"},
    {"id": "DHI"},
    {"id": "DIB"},
    {"id": "DIP"},
    {"id": "DIX"},
    {"id": "DIY"},
    {"id": "DLS"},
    {"id": "DMB"},
    {"id": "DMS"},
    {"id": "DMU"},
    {"id": "DP8"},
    {"id": "DPN"},
    {"id": "DPP"},
    {"id": "DPR"},
    {"id": "DR9"},
    {"id": "DRH"},
    {"id": "DRJ"},
    {"id": "DSE"},
    {"id": "DSN"},
    {"id": "DST"},
    {"id": "DTB"},
    {"id": "DTT"},
    {"id": "DTU"},
    {"id": "DTV"},
    {"id": "DTY"},
    {"id": "DUZ"},
    {"id": "DVC"},
    {"id": "DW2"},
    {"id": "DXC"},
    {"id": "DXL"},
    {"id": "DXO"},
    {"id": "E10"},
    {"id": "E12"},
    {"id": "E20"},
    {"id": "E4D"},
    {"id": "EAA"},
    {"id": "EDO"},
    {"id": "EED"},
    {"id": "EES"},
    {"id": "EI1"},
    {"id": "EMB"},
    {"id": "EN5"},
    {"id": "ENF"},
    {"id": "ENO"},
    {"id": "ENX"},
    {"id": "EOH"},
    {"id": "EPE"},
    {"id": "EPH"},
    {"id": "EPU"},
    {"id": "ERE"},
    {"id": "ESA"},
    {"id": "EST"},
    {"id": "ETC"},
    {"id": "ETM"},
    {"id": "EU"},
    {"id": "EU3"},
    {"id": "F"},
    {"id": "F19"},
    {"id": "F3S"},
    {"id": "F6F"},
    {"id": "F9F"},
    {"id": "FA7"},
    {"id": "FAD"},
    {"id": "FAE"},
    {"id": "FBP"},
    {"id": "FBR"},
    {"id": "FCO"},
    {"id": "FDA"},
    {"id": "FE"},
    {"id": "FE2"},
    {"id": "FEL"},
    {"id": "FEO"},
    {"id": "FER"},
    {"id": "FES"},
    {"id": "FFA"},
    {"id": "FFO"},
    {"id": "FGA"},
    {"id": "FHM"},
    {"id": "FHO"},
    {"id": "FK1"},
    {"id": "FLC"},
    {"id": "FLI"},
    {"id": "FLN"},
    {"id": "FLV"},
    {"id": "FMN"},
    {"id": "FMP"},
    {"id": "FMT"},
    {"id": "FO5"},
    {"id": "FON"},
    {"id": "FOO"},
    {"id": "FP1"},
    {"id": "FSM"},
    {"id": "FT1"},
    {"id": "FT2"},
    {"id": "FTY"},
    {"id": "FU2"},
    {"id": "FUC"},
    {"id": "FUL"},
    {"id": "FUM"},
    {"id": "G05"},
    {"id": "G1P"},
    {"id": "G2F"},
    {"id": "G3A"},
    {"id": "G3H"},
    {"id": "G3P"},
    {"id": "G52"},
    {"id": "G55"},
    {"id": "G61"},
    {"id": "G64"},
    {"id": "G79"},
    {"id": "G7G"},
    {"id": "G89"},
    {"id": "GA"},
    {"id": "GA2"},
    {"id": "GAL"},
    {"id": "GCP"},
    {"id": "GCQ"},
    {"id": "GCS"},
    {"id": "GDL"},
    {"id": "GDP"},
    {"id": "GDU"},
    {"id": "GEN"},
    {"id": "GGA"},
    {"id": "GGD"},
    {"id": "GHP"},
    {"id": "GKD"},
    {"id": "GKE"},
    {"id": "GL0"},
    {"id": "GL8"},
    {"id": "GLA"},
    {"id": "GLC"},
    {"id": "GLL"},
    {"id": "GLO"},
    {"id": "GLY"},
    {"id": "GM2"},
    {"id": "GMP"},
    {"id": "GND"},
    {"id": "GNH"},
    {"id": "GNP"},
    {"id": "GNT"},
    {"id": "GOL"},
    {"id": "GP1"},
    {"id": "GP4"},
    {"id": "GPI"},
    {"id": "GRN"},
    {"id": "GS1"},
    {"id": "GSH"},
    {"id": "GSP"},
    {"id": "GST"},
    {"id": "GTP"},
    {"id": "GTX"},
    {"id": "GUN"},
    {"id": "GXL"},
    {"id": "H2S"},
    {"id": "H2U"},
    {"id": "H4B"},
    {"id": "H64"},
    {"id": "HAB"},
    {"id": "HAR"},
    {"id": "HB1"},
    {"id": "HBA"},
    {"id": "HBI"},
    {"id": "HC2"},
    {"id": "HC3"},
    {"id": "HC7"},
    {"id": "HC9"},
    {"id": "HCL"},
    {"id": "HEA"},
    {"id": "HEC"},
    {"id": "HED"},
    {"id": "HEM"},
    {"id": "HEX"},
    {"id": "HFT"},
    {"id": "HG"},
    {"id": "HG7"},
    {"id": "HGM"},
    {"id": "HIS"},
    {"id": "HJ2"},
    {"id": "HJ3"},
    {"id": "HKA"},
    {"id": "HM6"},
    {"id": "HMG"},
    {"id": "HOA"},
    {"id": "HOM"},
    {"id": "HOS"},
    {"id": "HPE"},
    {"id": "HQQ"},
    {"id": "HQU"},
    {"id": "HR7"},
    {"id": "HRD"},
    {"id": "HSX"},
    {"id": "HT7"},
    {"id": "HTD"},
    {"id": "HTH"},
    {"id": "HTO"},
    {"id": "HTQ"},
    {"id": "HTY"},
    {"id": "HUP"},
    {"id": "HUX"},
    {"id": "HXA"},
    {"id": "HXY"},
    {"id": "HZ3"},
    {"id": "I13"},
    {"id": "I3A"},
    {"id": "I46"},
    {"id": "I63"},
    {"id": "ID2"},
    {"id": "IFP"},
    {"id": "IGP"},
    {"id": "IH5"},
    {"id": "IHD"},
    {"id": "ILB"},
    {"id": "ILC"},
    {"id": "ILE"},
    {"id": "ILF"},
    {"id": "ILH"},
    {"id": "IMD"},
    {"id": "IMI"},
    {"id": "IMN"},
    {"id": "IMP"},
    {"id": "IMT"},
    {"id": "IMX"},
    {"id": "IN8"},
    {"id": "IN9"},
    {"id": "INH"},
    {"id": "INI"},
    {"id": "IOD"},
    {"id": "IOG"},
    {"id": "IOK"},
    {"id": "IPA"},
    {"id": "IPE"},
    {"id": "IPH"},
    {"id": "IPL"},
    {"id": "IPR"},
    {"id": "IPX"},
    {"id": "IQX"},
    {"id": "IRG"},
    {"id": "ISL"},
    {"id": "ISP"},
    {"id": "ITE"},
    {"id": "ITL"},
    {"id": "ITT"},
    {"id": "IUM"},
    {"id": "IYR"},
    {"id": "J35"},
    {"id": "J43"},
    {"id": "J53"},
    {"id": "J5L"},
    {"id": "J77"},
    {"id": "J80"},
    {"id": "JB1"},
    {"id": "JC1"},
    {"id": "JFK"},
    {"id": "JZA"},
    {"id": "JZD"},
    {"id": "JZE"},
    {"id": "K"},
    {"id": "K7J"},
    {"id": "KCX"},
    {"id": "KDG"},
    {"id": "KDO"},
    {"id": "KH1"},
    {"id": "KIR"},
    {"id": "KN2"},
    {"id": "KPG"},
    {"id": "KWT"},
    {"id": "L04"},
    {"id": "L07"},
    {"id": "L09"},
    {"id": "L71"},
    {"id": "L7S"},
    {"id": "L9Q"},
    {"id": "L9R"},
    {"id": "LA"},
    {"id": "LAC"},
    {"id": "LAE"},
    {"id": "LDA"},
    {"id": "LDP"},
    {"id": "LEA"},
    {"id": "LFN"},
    {"id": "LG1"},
    {"id": "LH3"},
    {"id": "LH4"},
    {"id": "LHG"},
    {"id": "LI"},
    {"id": "LK1"},
    {"id": "LK2"},
    {"id": "LL3"},
    {"id": "LL4"},
    {"id": "LL5"},
    {"id": "LMG"},
    {"id": "LMR"},
    {"id": "LMT"},
    {"id": "LN1"},
    {"id": "LOC"},
    {"id": "LPH"},
    {"id": "LRG"},
    {"id": "LUM"},
    {"id": "LUV"},
    {"id": "LXB"},
    {"id": "LXZ"},
    {"id": "LY9"},
    {"id": "LYA"},
    {"id": "LYS"},
    {"id": "LZ0"},
    {"id": "M12"},
    {"id": "M2G"},
    {"id": "M3R"},
    {"id": "M49"},
    {"id": "M5Z"},
    {"id": "M8E"},
    {"id": "M8M"},
    {"id": "MA1"},
    {"id": "MA2"},
    {"id": "MA3"},
    {"id": "MA4"},
    {"id": "MAA"},
    {"id": "MAG"},
    {"id": "MAL"},
    {"id": "MAN"},
    {"id": "MAU"},
    {"id": "MBG"},
    {"id": "MBN"},
    {"id": "MBT"},
    {"id": "MDC"},
    {"id": "MDF"},
    {"id": "MDN"},
    {"id": "ME3"},
    {"id": "MEC"},
    {"id": "MER"},
    {"id": "MES"},
    {"id": "MF4"},
    {"id": "MF5"},
    {"id": "MFB"},
    {"id": "MFU"},
    {"id": "MG"},
    {"id": "MGF"},
    {"id": "MGR"},
    {"id": "MHB"},
    {"id": "MHI"},
    {"id": "MHO"},
    {"id": "MI2"},
    {"id": "MIB"},
    {"id": "MLA"},
    {"id": "MLC"},
    {"id": "MLE"},
    {"id": "MLI"},
    {"id": "MLR"},
    {"id": "MLT"},
    {"id": "MLU"},
    {"id": "MLY"},
    {"id": "MMA"},
    {"id": "MMC"},
    {"id": "MMV"},
    {"id": "MN"},
    {"id": "MN1"},
    {"id": "MN2"},
    {"id": "MN7"},
    {"id": "MN8"},
    {"id": "MO7"},
    {"id": "MOB"},
    {"id": "MP4"},
    {"id": "MPD"},
    {"id": "MPV"},
    {"id": "MRD"},
    {"id": "MSE"},
    {"id": "MSR"},
    {"id": "MT6"},
    {"id": "MTB"},
    {"id": "MU0"},
    {"id": "MU1"},
    {"id": "MUI"},
    {"id": "MUT"},
    {"id": "MVA"},
    {"id": "MVC"},
    {"id": "MYA"},
    {"id": "MYP"},
    {"id": "MYR"},
    {"id": "MYS"},
    {"id": "N09"},
    {"id": "N1L"},
    {"id": "N2C"},
    {"id": "N4B"},
    {"id": "N6M"},
    {"id": "NA"},
    {"id": "NAB"},
    {"id": "NAD"},
    {"id": "NAG"},
    {"id": "NAI"},
    {"id": "NAJ"},
    {"id": "NAP"},
    {"id": "NCO"},
    {"id": "NCS"},
    {"id": "NCY"},
    {"id": "NDG"},
    {"id": "NDP"},
    {"id": "NEP"},
    {"id": "NEQ"},
    {"id": "NFZ"},
    {"id": "NGA"},
    {"id": "NGZ"},
    {"id": "NH2"},
    {"id": "NH4"},
    {"id": "NI"},
    {"id": "NIO"},
    {"id": "NLC"},
    {"id": "NLE"},
    {"id": "NLG"},
    {"id": "NLX"},
    {"id": "NO"},
    {"id": "NO3"},
    {"id": "NOG"},
    {"id": "NPJ"},
    {"id": "NPM"},
    {"id": "NPO"},
    {"id": "NRQ"},
    {"id": "NSI"},
    {"id": "NVA"},
    {"id": "NX1"},
    {"id": "NX2"},
    {"id": "NX3"},
    {"id": "NX4"},
    {"id": "NX5"},
    {"id": "NXV"},
    {"id": "NXW"},
    {"id": "NXY"},
    {"id": "NYB"},
    {"id": "O"},
    {"id": "O11"},
    {"id": "O75"},
    {"id": "O8M"},
    {"id": "OBH"},
    {"id": "OCA"},
    {"id": "OCS"},
    {"id": "OCT"},
    {"id": "ODE"},
    {"id": "ODT"},
    {"id": "OEC"},
    {"id": "OEF"},
    {"id": "OH"},
    {"id": "OLA"},
    {"id": "OLC"},
    {"id": "OMC"},
    {"id": "OMG"},
    {"id": "OMO"},
    {"id": "OMX"},
    {"id": "OMY"},
    {"id": "OMZ"},
    {"id": "ONL"},
    {"id": "OPC"},
    {"id": "ORD"},
    {"id": "ORN"},
    {"id": "ORO"},
    {"id": "ORX"},
    {"id": "OXY"},
    {"id": "OZ2"},
    {"id": "P01"},
    {"id": "P0E"},
    {"id": "P16"},
    {"id": "P1T"},
    {"id": "P2P"},
    {"id": "P36"},
    {"id": "P42"},
    {"id": "P4O"},
    {"id": "P4P"},
    {"id": "P6G"},
    {"id": "P6L"},
    {"id": "P8H"},
    {"id": "P9B"},
    {"id": "PAF"},
    {"id": "PAJ"},
    {"id": "PAL"},
    {"id": "PAM"},
    {"id": "PAU"},
    {"id": "PAZ"},
    {"id": "PB"},
    {"id": "PB1"},
    {"id": "PBS"},
    {"id": "PBX"},
    {"id": "PC1"},
    {"id": "PCA"},
    {"id": "PCP"},
    {"id": "PCR"},
    {"id": "PCT"},
    {"id": "PD"},
    {"id": "PDC"},
    {"id": "PDX"},
    {"id": "PE2"},
    {"id": "PE3"},
    {"id": "PE5"},
    {"id": "PE6"},
    {"id": "PE8"},
    {"id": "PEE"},
    {"id": "PEF"},
    {"id": "PEG"},
    {"id": "PEO"},
    {"id": "PEP"},
    {"id": "PER"},
    {"id": "PEU"},
    {"id": "PFA"},
    {"id": "PFB"},
    {"id": "PFF"},
    {"id": "PFU"},
    {"id": "PG4"},
    {"id": "PGD"},
    {"id": "PGE"},
    {"id": "PGO"},
    {"id": "PHA"},
    {"id": "PHE"},
    {"id": "PHK"},
    {"id": "PHO"},
    {"id": "PIA"},
    {"id": "PII"},
    {"id": "PIK"},
    {"id": "PIQ"},
    {"id": "PIZ"},
    {"id": "PL9"},
    {"id": "PLC"},
    {"id": "PLG"},
    {"id": "PLM"},
    {"id": "PLP"},
    {"id": "PLS"},
    {"id": "PLT"},
    {"id": "PMJ"},
    {"id": "PMO"},
    {"id": "PMV"},
    {"id": "PNP"},
    {"id": "PO3"},
    {"id": "PO4"},
    {"id": "POP"},
    {"id": "POQ"},
    {"id": "PP9"},
    {"id": "PPV"},
    {"id": "PQN"},
    {"id": "PQQ"},
    {"id": "PRP"},
    {"id": "PRZ"},
    {"id": "PS9"},
    {"id": "PSU"},
    {"id": "PT"},
    {"id": "PTE"},
    {"id": "PTG"},
    {"id": "PTH"},
    {"id": "PTI"},
    {"id": "PTR"},
    {"id": "PTY"},
    {"id": "PUT"},
    {"id": "PVE"},
    {"id": "PXE"},
    {"id": "PXP"},
    {"id": "PXX"},
    {"id": "PYB"},
    {"id": "PYJ"},
    {"id": "PYR"},
    {"id": "Q21"},
    {"id": "QHA"},
    {"id": "QMR"},
    {"id": "QNO"},
    {"id": "QPS"},
    {"id": "QPT"},
    {"id": "QUI"},
    {"id": "R3S"},
    {"id": "R3X"},
    {"id": "R4G"},
    {"id": "R8G"},
    {"id": "RAM"},
    {"id": "RB"},
    {"id": "RBF"},
    {"id": "RCY"},
    {"id": "RDE"},
    {"id": "REA"},
    {"id": "REC"},
    {"id": "RER"},
    {"id": "REZ"},
    {"id": "RF1"},
    {"id": "RF2"},
    {"id": "RF3"},
    {"id": "RHQ"},
    {"id": "RI2"},
    {"id": "RIS"},
    {"id": "RJ1"},
    {"id": "RJ6"},
    {"id": "RMB"},
    {"id": "RMD"},
    {"id": "RMN"},
    {"id": "RNR"},
    {"id": "RPO"},
    {"id": "RRG"},
    {"id": "RS3"},
    {"id": "RS7"},
    {"id": "RST"},
    {"id": "RU"},
    {"id": "RU0"},
    {"id": "RV1"},
    {"id": "RX8"},
    {"id": "S10"},
    {"id": "S2C"},
    {"id": "S45"},
    {"id": "S60"},
    {"id": "SAH"},
    {"id": "SAL"},
    {"id": "SAM"},
    {"id": "SAR"},
    {"id": "SAS"},
    {"id": "SB1"},
    {"id": "SB3"},
    {"id": "SBB"},
    {"id": "SBG"},
    {"id": "SBR"},
    {"id": "SBS"},
    {"id": "SBX"},
    {"id": "SCH"},
    {"id": "SCN"},
    {"id": "SCY"},
    {"id": "SDS"},
    {"id": "SEC"},
    {"id": "SEP"},
    {"id": "SER"},
    {"id": "SF4"},
    {"id": "SGC"},
    {"id": "SIA"},
    {"id": "SIG"},
    {"id": "SIN"},
    {"id": "SMA"},
    {"id": "SMM"},
    {"id": "SMN"},
    {"id": "SNG"},
    {"id": "SNS"},
    {"id": "SO4"},
    {"id": "SP2"},
    {"id": "SPM"},
    {"id": "SPO"},
    {"id": "SQ"},
    {"id": "SQD"},
    {"id": "SR"},
    {"id": "SRO"},
    {"id": "ST9"},
    {"id": "STE"},
    {"id": "STF"},
    {"id": "STU"},
    {"id": "SU0"},
    {"id": "SUC"},
    {"id": "SW4"},
    {"id": "SY9"},
    {"id": "T08"},
    {"id": "T21"},
    {"id": "T3O"},
    {"id": "T55"},
    {"id": "T5E"},
    {"id": "TAR"},
    {"id": "TB"},
    {"id": "TBE"},
    {"id": "TC9"},
    {"id": "TCE"},
    {"id": "TDS"},
    {"id": "TEO"},
    {"id": "TEU"},
    {"id": "TF1"},
    {"id": "TF2"},
    {"id": "TF3"},
    {"id": "TF4"},
    {"id": "TG1"},
    {"id": "THA"},
    {"id": "THG"},
    {"id": "THM"},
    {"id": "THP"},
    {"id": "TIY"},
    {"id": "TJF"},
    {"id": "TL"},
    {"id": "TLA"},
    {"id": "TN1"},
    {"id": "TNR"},
    {"id": "TOP"},
    {"id": "TP8"},
    {"id": "TP9"},
    {"id": "TPO"},
    {"id": "TRC"},
    {"id": "TRD"},
    {"id": "TRE"},
    {"id": "TRP"},
    {"id": "TRS"},
    {"id": "TRT"},
    {"id": "TSL"},
    {"id": "TSY"},
    {"id": "TTB"},
    {"id": "TUL"},
    {"id": "TUX"},
    {"id": "TWT"},
    {"id": "TYD"},
    {"id": "TYM"},
    {"id": "TYR"},
    {"id": "TZT"},
    {"id": "U1"},
    {"id": "U10"},
    {"id": "U5P"},
    {"id": "UBI"},
    {"id": "UDP"},
    {"id": "UMA"},
    {"id": "UMK"},
    {"id": "UMP"},
    {"id": "UMQ"},
    {"id": "UNK"},
    {"id": "UNL"},
    {"id": "UNX"},
    {"id": "UO1"},
    {"id": "UPE"},
    {"id": "UPF"},
    {"id": "UPG"},
    {"id": "UQ"},
    {"id": "URA"},
    {"id": "URB"},
    {"id": "URF"},
    {"id": "UTP"},
    {"id": "V11"},
    {"id": "V37"},
    {"id": "V38"},
    {"id": "V63"},
    {"id": "VDX"},
    {"id": "VJP"},
    {"id": "VLB"},
    {"id": "VN4"},
    {"id": "VO1"},
    {"id": "VO2"},
    {"id": "VO4"},
    {"id": "VU2"},
    {"id": "VU3"},
    {"id": "VXL"},
    {"id": "W07"},
    {"id": "W12"},
    {"id": "W14"},
    {"id": "W23"},
    {"id": "WBU"},
    {"id": "WC1"},
    {"id": "WO4"},
    {"id": "WRA"},
    {"id": "WV7"},
    {"id": "WWV"},
    {"id": "WWZ"},
    {"id": "WXV"},
    {"id": "X0J"},
    {"id": "X1N"},
    {"id": "XAN"},
    {"id": "XCX"},
    {"id": "XDH"},
    {"id": "XE"},
    {"id": "XFW"},
    {"id": "XSN"},
    {"id": "XX6"},
    {"id": "XX7"},
    {"id": "XY1"},
    {"id": "XYP"},
    {"id": "Y8L"},
    {"id": "YB"},
    {"id": "YCM"},
    {"id": "YG"},
    {"id": "YI2"},
    {"id": "YI3"},
    {"id": "YI4"},
    {"id": "YL3"},
    {"id": "YR4"},
    {"id": "YS2"},
    {"id": "YS3"},
    {"id": "YS4"},
    {"id": "YS5"},
    {"id": "YSD"},
    {"id": "YSE"},
    {"id": "YSL"},
    {"id": "YX0"},
    {"id": "YYG"},
    {"id": "ZBR"},
    {"id": "ZCL"},
    {"id": "ZLP"},
    {"id": "ZN"},
    {"id": "ZTP"},
    {"id": "ZXG"},
    {"id": "ZYJ"},
    {"id": "ZYK"},
    {"id": "ZZR"},
    {"id": "ZZS"},
  ];
  List<Map<String, dynamic>> _foundProteins = [];

  @override
  void initState() {
    super.initState();
    _foundProteins = _allProteins;
    // updateLocalStorage();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        currentTheme.addListener(() {
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final LocalStorage storage = LocalStorage('client_info');
    super.didChangeAppLifecycleState(state);

    if (state.name == "paused") {
      Provider.of<AuthProvider>(context, listen: false).signout();
      Navigator.pushNamed(context, LoginViewController.routename);
    }
  }

  void filterProteins(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allProteins;
    } else {
      results = _allProteins
          .where((user) =>
              user["id"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundProteins = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = LocalStorage('client_info');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isthisDarkMode = box.get('currentTheme');

    // print(storage.getItem("client")["id"]);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: createMaterialColor(const Color(0xFF292D39)),
          automaticallyImplyLeading: true,
          title: const Text('Fluttery Gelatine'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.dark_mode_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                currentTheme.switchTheme();
              },
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: createMaterialColor(const Color(0xFF292D39)),
          child: ListView(
            reverse: true,
            children: [
              ListTile(
                title: const Text(
                  'Déconnexion',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  final LocalStorage storage = LocalStorage('client_info');
                  Provider.of<AuthProvider>(context, listen: false).signout();
                  Navigator.pushNamed(context, LoginViewController.routename);
                },
              )
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: screenWidth * 0.5,
                  child: Image.asset(
                    isthisDarkMode
                        ? 'assets/images/logodark.png'
                        : 'assets/images/logolight.png',
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Container(
              width: screenWidth * 0.7,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                onChanged: (value) => filterProteins(value),
                decoration: const InputDecoration(
                    hintText: 'Rechercher une protéine',
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Expanded(
              child: _foundProteins.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.only(top: 10.0),
                      itemCount: _foundProteins.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 4,
                        key: ValueKey(_foundProteins[index]["id"]),
                        color: createMaterialColor(const Color(0xFF292D39)),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          textColor: Colors.white,
                          leading: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: screenWidth * 0.01,
                              minHeight: screenHeight * 0.01,
                              maxWidth: screenWidth * 0.1,
                              maxHeight: screenHeight * 0.1,
                            ),
                            child: Image.asset('assets/icon/icon.png',
                                fit: BoxFit.cover),
                          ),
                          title: Text(_foundProteins[index]['id'],
                              style: const TextStyle(fontSize: 18)),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.white),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScenekitPage(
                                    name: _foundProteins[index]['id']),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const Text(
                      'Protéine non disponible',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
