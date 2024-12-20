import 'dart:io';

void main() async {
  // Iniciar el backend
  final backend = await Process.start(
    'dart',
    ['run', 'server/backend.dart'],
  );
  print('Backend iniciado...');
  backend.stdout.transform(SystemEncoding().decoder).listen(print);
  backend.stderr.transform(SystemEncoding().decoder).listen(print);

  // Iniciar el frontend en Chrome
  final frontend = await Process.start(
    'flutter',
    ['run', '-d', 'chrome'], // Cambiar "chrome" para Flutter Web
  );
  print('Frontend iniciado...');
  frontend.stdout.transform(SystemEncoding().decoder).listen(print);
  frontend.stderr.transform(SystemEncoding().decoder).listen(print);

  // Esperar a que ambos procesos terminen
  final backendExitCode = await backend.exitCode;
  print('Backend finalizado con código: $backendExitCode');

  final frontendExitCode = await frontend.exitCode;
  print('Frontend finalizado con código: $frontendExitCode');
}
