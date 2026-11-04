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
        keyboard.left().onPressDo {
            movimientoActual = movimientoIzquierda
        }

        keyboard.right().onPressDo {
            movimientoActual = movimientoDerecha
        }

        keyboard.left().onReleaseDo {
            self.detenerMovimiento()
        }

        keyboard.right().onReleaseDo {
            self.detenerMovimiento()
        }

        const tick = game.tick(75, {
            if (movimientoActual != null) {
                naveJugador.mover(movimientoActual)
            }
        }, false)

        tick.start()

        //#Otros
        keyboard.space().onPressDo {
            naveJugador.disparar()
        }

        keyboard.num1().onPressDo {
            naveJugador.seleccionarArma(bala)
        }

        keyboard.num2().onPressDo {
            naveJugador.seleccionarArma(laser)
        }

        keyboard.num3().onPressDo {
            naveJugador.seleccionarArma(cohete)
        }

        keyboard.r().onPressDo {
            partida.reiniciar()
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
