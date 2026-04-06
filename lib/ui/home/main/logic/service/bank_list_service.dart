/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import '../model/transfer_create_sbp_result.dart' show BankInfo;

class BankListService {
  final List<String> _topBankCodes = [
    'bank100000000111', // Sberbank
    'bank100000000004', // Tinkoff
    'bank100000000005', // VTB
    'bank100000000008', // Alfa Bank
    'bank100000000007', // Raiffeisen
    'bank100000000015', // Otkritie
    'bank100000000001', // Gazprombank
    'bank100000000010', // Promsvyazbank
    'bank100000000013', // Sovcombank
    'bank100000000012', // Rosbank
    'bank100000000020', // Rosselkhozbank
    'bank100000000025', // MKB
    'bank100000000030', // UniCredit Bank
    'bank100000000003', // Sinara
    'bank100000000043', // Gazenergobank
    'bank100000000028', // Avangard
    'bank100000000086', // Elplat
    'bank100000000011', // RNCB
    'bank100000000044', // Expobank
    'bank100000000049', // VBRR
    'bank100000000500', // Russian Standard Bank
    'bank100000000095', // AB Russia
    'bank100000000900', // Faktura
    'bank100000000056', // Khlynov
    'bank100000000053', // Vesta Bank
    'bank100000000121', // Solidarnost
    'bank100000000082', // Bank DOM.RF
    'bank100000000127', // HMB
    'bank100000000017', // MTS Bank
    'bank100000000071', // Bank Saint Petersburg
    'bank100000000019', // OTP Bank
    'bank100000000021', // Bank Zenit
    'bank100000000016', // Bank Uralsib
    'bank100000000006', // Bank Peresvet
    'bank100000000041', // Renaissance Credit
    'bank100000000037', // B&N Bank
    'bank100000000018', // Transcapitalbank
    'bank100000000022', // RN Bank
    'bank100000000024', // SKB Bank
    'bank100000000083', // Sovinvestbank
    'bank100000000129', // Modulbank
    'bank100000000101', // Tochka Bank
    'bank100000000131', // Delobank
    'bank100000000075', // Asia-Pacific Bank
    'bank100000000026', // Novikom Bank
    'bank100000000027', // Rosdorbank
    'bank100000000032', // Center-Invest Bank
    'bank100000000035', // Bank Levoberezhniy
    'bank100000000033', // BaltInvestBank
    'bank100000000040', // Bank Zarechye
  ];

  List<BankInfo> sortBanksTop30First(List<BankInfo> banks) {
    // Map code -> index for O(1) lookup
    final Map<String, int> topIndex = {
      for (int i = 0; i < _topBankCodes.length; i++) _topBankCodes[i]: i,
    };

    banks.sort((a, b) {
      final ia = topIndex[a.code];
      final ib = topIndex[b.code];

      final aIsTop = ia != null;
      final bIsTop = ib != null;

      // Case 1: both are in top 30 → compare by their order in topBankCodes
      if (aIsTop && bIsTop) {
        return ia.compareTo(ib);
      }

      // Case 2: only A is top → A comes first
      if (aIsTop && !bIsTop) return -1;

      // Case 3: only B is top → B comes first
      if (!aIsTop && bIsTop) return 1;

      // Case 4: neither in top → sort however you want (here: by name)
      return a.name?.compareTo(b.name ?? "") ?? 1;
      // or: return a.code.compareTo(b.code);
    });

    return banks;
  }

  int extractBankCode(String code) {
    return int.tryParse(code.replaceAll("bank", "")) ?? 0;
  }

  // Kirill -> Lotin oddiy transliteratsiya (Uz/Ru aralash)
  final Map<String, String> _cyrToLat = {
    'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd',
    'е': 'e', 'ё': 'yo', 'ж': 'j', 'з': 'z', 'и': 'i',
    'й': 'y', 'к': 'k', 'л': 'l', 'м': 'm', 'н': 'n',
    'о': 'o', 'п': 'p', 'р': 'r', 'с': 's', 'т': 't',
    'у': 'u', 'ф': 'f', 'х': 'x', 'ц': 'ts', 'ч': 'ch',
    'ш': 'sh', 'щ': 'sh', 'ъ': '', 'ы': 'i', 'ь': '',
    'э': 'e', 'ю': 'yu', 'я': 'ya',
    'қ': 'q', 'ғ': 'g‘', 'ў': 'o‘', 'ҳ': 'h',

    // katta harflar
    'А': 'a', 'Б': 'b', 'В': 'v', 'Г': 'g', 'Д': 'd',
    'Е': 'e', 'Ё': 'yo', 'Ж': 'j', 'З': 'z', 'И': 'i',
    'Й': 'y', 'К': 'k', 'Л': 'l', 'М': 'm', 'Н': 'n',
    'О': 'o', 'П': 'p', 'Р': 'r', 'С': 's', 'Т': 't',
    'У': 'u', 'Ф': 'f', 'Х': 'x', 'Ц': 'ts', 'Ч': 'ch',
    'Ш': 'sh', 'Щ': 'sh', 'Ъ': '', 'Ы': 'i', 'Ь': '',
    'Э': 'e', 'Ю': 'yu', 'Я': 'ya',
    'Қ': 'q', 'Ғ': 'g‘', 'Ў': 'o‘', 'Ҳ': 'h',
  };

  String normalizeText(String value) {
    final buffer = StringBuffer();

    for (final code in value.runes) {
      final ch = String.fromCharCode(code);
      buffer.write(_cyrToLat[ch] ?? ch.toLowerCase());
    }

    return buffer.toString().trim();
  }
}
