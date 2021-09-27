import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/CronometroBotao.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro/store/pomodoro.store.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(
      builder: (_) {
        return Container(
          color: store.estaTrabalhando() ? Colors.red : Colors.green,
          child: Column(
            /* 
              com  mainAxisAlignment e crossAxisAlignment
              conseguimos centralizar tanto no eixo principal 
              como tbm no eixo cruzado
            */
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                store.estaTrabalhando()
                    ? 'Hora de Trabalhar'
                    : 'Hora de Descanço',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                /* padLeft para sempre adicionar um 0 qdo numero for <10 */
                '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 120,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!store.iniciado)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CronometroBotao(
                        texto: 'Iniciar',
                        icone: Icons.play_arrow,
                        click: store.iniciar,
                      ),
                    ),
                  if (store.iniciado)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CronometroBotao(
                        texto: 'Parar',
                        icone: Icons.stop,
                        click: store.parar,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CronometroBotao(
                      texto: 'Reinciar',
                      icone: Icons.refresh,
                      click: store.reiniciar,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
