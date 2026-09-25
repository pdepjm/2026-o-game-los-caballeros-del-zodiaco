
object naveJugador{
    var property vida = 100
    var property position = game.at(5,1)
    var property danioBase = 10

    method estaViva() = vida > 0

    method recibirDanio(cantidad){
        vida = (vida - cantidad).max(0)
        if(!self.estaViva()){
            self.morir()
        }
    }

    method morir(){
        //?
    }

    method image() = "imagen.png"

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