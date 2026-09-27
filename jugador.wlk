import armas.*
import partida.*

object naveJugador{
    var property vida = 100
    var property position = game.at(5,0)
    var property danioBase = 10

    var moviendoIzquierda = false
    var moviendoDerecha = false

    //Imagen
    var imagen = "nave-recto.png"
    method image() = imagen

    method estaViva() = vida > 0

    method morir(){
        // 
    }
    //Reinicio jugador
    method reiniciar(){
        position = game.at(5,0)
        vida = 100
        imagen = "nave-recto.png"
    }

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

    //Movimiento
    method mover(){
        if(moviendoIzquierda){
            self.moverIzquierda()
        }

        if(moviendoDerecha){
            self.moverDerecha()
        }
    }

    method moverIzquierda() {
        if (position.x() > 0) {
            position = position.left(1)
            imagen = "nave-derecha.png"
        }
    }

    method moverDerecha() {
        if (position.x() < 7 ) {
            position = position.right(1)
            imagen = "nave-izquierda.png"
        }
    }

    method enderezar(){
        imagen = "nave-recto.png"
    }

    //Controles
    method configurarControles() {

        //Cuando presiono las teclas -> , <-
        keyboard.left().onPressDo {
            moviendoIzquierda = true
            imagen = "nave-izquierda.png"
        }

        keyboard.right().onPressDo {
            moviendoDerecha = true
            imagen = "nave-derecha.png"
        }

        //Cuando suelto las teclas -> 
        keyboard.left().onReleaseDo {
            moviendoIzquierda = false
            self.enderezar()
        }

        keyboard.right().onReleaseDo {
            moviendoDerecha = false
            self.enderezar()
        }

        //Retardo
        const tickMovimiento = game.tick(75,{self.mover()}, false)
        tickMovimiento.start()


        //Teclas de ataque
        keyboard.num1().onPressDo({ armaSeleccionada = bala})
        keyboard.num2().onPressDo({ armaSeleccionada = laser})
        keyboard.num3().onPressDo({ armaSeleccionada = cohete})
        keyboard.space().onPressDo({ self.disparar(partida.enemigos()) })
    }
}