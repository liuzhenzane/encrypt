part of encrypt;

/// Wraps Algorithms in a unique Container.
class Encrypter {
  final Algorithm algo;

  Encrypter(this.algo);

  /// Calls [encrypt] on the wrapped Algorithm using a raw binary.
  Encrypted encryptBytes(List<int> input, {IV iv}) {
    return algo.encrypt(Uint8List.fromList(input), iv: iv);
  }

  /// Calls [encrypt] on the wrapped Algorithm.
  Encrypted encrypt(String input, {IV iv}) {
    return encryptBytes(convert.utf8.encode(input), iv: iv);
  }

  /// Calls [decrypt] on the wrapped Algorithm.
  String decrypt(Encrypted encrypted, {IV iv}) {
    return convert.utf8
        .decode(algo.decrypt(encrypted, iv: iv), allowMalformed: true);
  }

  /// Sugar for `decrypt(Encrypted.fromBase16(encoded))`.
  String decrypt16(String encoded, {IV iv}) {
    return decrypt(Encrypted.fromBase16(encoded), iv: iv);
  }

  /// Sugar for `decrypt(Encrypted.fromBase64(encoded))`.
  String decrypt64(String encoded, {IV iv}) {
    return decrypt(Encrypted.fromBase64(encoded), iv: iv);
  }
}
