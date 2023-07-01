import 'dart:io';

void main() {
  readFile();
}

void readFile() async {
  try {
    final file = File(
        r'C:\Users\marqu\Desktop\Marcus\PROJETO\theras_app\assets\txte.txt'); // Substitua 'caminho_do_arquivo.txt' pelo caminho real do arquivo TXT

    if (await file.exists()) {
      final contents = await file.readAsString();
      print(contents);
    } else {
      print('O arquivo não existe.');
    }
  } catch (e) {
    print('Erro ao ler o arquivo: $e');
  }
}
