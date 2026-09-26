import armas.*

object naveJugador{
    var property vida = 100
    var property position = game.at(5,0)
    var property danioBase = 10

    method image() = "nave.png"

    method estaViva() = vida > 0

    method morir(){
        // 
    }

    //#Ataque

    //Verificacion de columna
    method estaEnMismaColumna(enemigo) = enemigo.position().x() == position.x()


    //Arma por defecto
    var armaSeleccionada = laser

    //Disparo
    method disparar(enemigos){
        const enLineaDeTiro = enemigos.filter({e => self.estaEnMismaColumna(e)})

        if (!enLineaDeTiro.isEmpty()){
            const objetivo = enLineaDeTiro.min({e => e.position().y()})
            armaSeleccionada.impactar(objetivo)
        }
    }

    //#Movimiento

    method moverIzquierda() {
        if (position.x() > 0) {
            position = position.left(1)
        }
    }

    method moverDerecha() {
        if (position.x() < 10 ) {
            position = position.right(1)
        }
    }

    //#Controles
    method configurarControles() {

        //Teclas de movimiento
        keyboard.left().onPressDo({ self.moverIzquierda() })
        keyboard.right().onPressDo({ self.moverDerecha() })

        //Teclas de ataque
        keyboard.num1().onPressDo({ armaSeleccionada = bala})
        keyboard.num2().onPressDo({ armaSeleccionada = laser})
        keyboard.num3().onPressDo({ armaSeleccionada = cohete})
    }
}