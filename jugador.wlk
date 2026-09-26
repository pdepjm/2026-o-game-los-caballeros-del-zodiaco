
object naveJugador{
    var property vida = 100
    var property position = game.at(5,0)
    var property danioBase = 10

    method image() = "nave2.png"

    method estaViva() = vida > 0

    method recibirDanio(cantidad){
        vida = (vida - cantidad).max(0)
        if(!self.estaViva()){
            self.morir()
        }
    }

    method morir(){
        //
    }

    //Movimiento izquierda/derecha
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

    method configurarControles() {
        keyboard.left().onPressDo({ self.moverIzquierda() })
        keyboard.right().onPressDo({ self.moverDerecha() })
    }
}