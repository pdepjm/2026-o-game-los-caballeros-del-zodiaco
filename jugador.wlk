import armas.*
import partida.*
import mapa.*

object naveJugador{
    const posicionInicial = game.at(5,0)
    var property position = posicionInicial
    var imagen = "nave-recto.png"

    //#Movimiento
    method mover(movimiento){
        movimiento.mover(self)  
    }

    //#Imagen
    method image() = imagen

    method cambiarImagen(nuevaImagen){
        imagen = nuevaImagen
    }
    
    method enderezar(){
        self.cambiarImagen("nave-recto.png")
    }

    //#Disparo
    method disparar() {
        manejoDeDisparo.disparar(armaSeleccionada, self)
    }

    //Arma por defecto
    var property armaSeleccionada = laser

    method seleccionarArma(arma){
        armaSeleccionada = arma
    }

    //Reinicio jugador
    method reiniciar(){
        position = posicionInicial
        self.enderezar()

        //Reiniciamos todos los cooldowns
        armamento.forEach({arma => arma.reiniciarCooldown()})
    }

    const armamento = [bala, laser, cohete]

    method enfriarArmas(){
        armamento.forEach({arma => arma.enfriar()})
    }

}


object controlesJugador {

    var movimientoActual = null

    method configuracion() {

        //#Movimiento
        self.configurarMovimiento(keyboard.left(), movimientoIzquierda)
        self.configurarMovimiento(keyboard.right(), movimientoDerecha)

        const tick = game.tick(75, {
            if (movimientoActual != null) {
                naveJugador.mover(movimientoActual)
            }
        }, false)

        tick.start()

        //#Otros

        keyboard.space().onPressDo {
            if (partida.estaJugando()) {
                naveJugador.disparar()
            }
        }

        //#Seleccion de armas
        self.configurarSeleccionArma(keyboard.num1(), bala)
        self.configurarSeleccionArma(keyboard.num2(), laser)
        self.configurarSeleccionArma(keyboard.num3(), cohete)

        //#Reinicio
        keyboard.r().onPressDo {
            partida.reiniciar()
        }
    }

    //#Configuracion de controles

    method configurarMovimiento(tecla, movimiento) {
        tecla.onPressDo {
            movimientoActual = movimiento
        }

        tecla.onReleaseDo {
            self.detenerMovimiento()
        }
    }

    method configurarSeleccionArma(tecla, arma) {
        tecla.onPressDo {
            naveJugador.seleccionarArma(arma)
        }
    }

    method detenerMovimiento() {
        movimientoActual = null
        naveJugador.enderezar()
    }
}


class Movimiento {
    const direccion
    const imagen

    method mover(nave){
        const nuevaPosicion = direccion.nuevaPosicion(nave.position())

        if (mapa.posicionValidaJugador(nuevaPosicion)){
            nave.position(nuevaPosicion)
            nave.cambiarImagen(imagen)
        }
    }

}

object izquierda {
    method nuevaPosicion(posicion) {
        return posicion.left(1)
    }
}

object derecha {
    method nuevaPosicion(posicion) {
        return posicion.right(1)
    }
}

const movimientoIzquierda = new Movimiento(direccion = izquierda, imagen = "nave-izquierda.png")
const movimientoDerecha = new Movimiento(direccion = derecha, imagen = "nave-derecha.png")  
