import jugador.*
import enemigo.*
import pantallas.*
import game.*
import armas.*
import mapa.*
import nivel.*
import generadorEnemigos.*

class EstadoPartida {

    //Cada estado responde únicamente a los mensajes que tienen sentido en su contexto
    //Los métodos vacíos evitan ejecutar comportamientos que no corresponden al estado actual
    method estaJugando() = false
    method iniciar() {}
    method verificarNivelCompletado() {}
    method gameOver() {}
}

object estadoMenu inherits EstadoPartida {
    override method iniciar() {
        partida.prepararPartida()
    }
}

object estadoJugando inherits EstadoPartida {
    override method estaJugando() = true

    override method verificarNivelCompletado() {
        if (partida.enemigos().isEmpty()) {
            partida.avanzarNivel()
        }
    }

    override method gameOver() {
        partida.finalizarPartida()
    }
}

object estadoGameOver inherits EstadoPartida {
    override method iniciar() {
        partida.prepararPartida()
    }
}

object partida {
    //# Estado de la partida
    var nivelActual = new Nivel(nivel = 1)
    var estadoActual = estadoMenu
    var property enemigos = []
    method estaJugando() = estadoActual.estaJugando()

    //#Inicio y reinicio de la partida

    method iniciar() {
        estadoActual.iniciar()
    }

    method reiniciar() {
        self.prepararPartida()
    }

    method prepararPartida() {
        nivelActual = new Nivel(nivel = 1)
        self.limpiarTablero()
        self.prepararJugador()
        self.prepararEnemigos()
        self.ocultarPantallas()
        estadoActual = estadoJugando

        controlesJugador.iniciarTickMovimiento()
        proyectil.iniciarTickProyectil()
    }

    method verificarNivelCompletado() {
        estadoActual.verificarNivelCompletado()
    }

    method avanzarNivel(){
        nivelActual = new Nivel(nivel = nivelActual.nivel() + 1)
        self.prepararEnemigos()
    }

    //# Preparación de la partida
    method prepararJugador() {
        game.addVisual(naveJugador)
        naveJugador.reiniciar()
    }

    method prepararEnemigos() {
        enemigos = generadorEnemigos.generarEnemigos(nivelActual)
        self.agregarEnemigosAlTablero()
    }

    method agregarEnemigosAlTablero() {
        enemigos.forEach { enemigo => game.addVisual(enemigo)}
    }

    method ocultarPantallas() {
        menu.ocultar()
        pantallaGameover.ocultar()
    }

    method eliminarEnemigo(enemigo) {

    //Quita al enemigo del tablero si todavía está visible
    if (game.hasVisual(enemigo)) {
        game.removeVisual(enemigo)
    }

    //Se elimina de la partida
    enemigos.remove(enemigo)

    //Comprueba si corresponde avanzar de nivel
    self.verificarNivelCompletado()
    }

    //# Limpieza

    //Verifica que la nave este en pantalla antes de sacarla
    method limpiarTablero() {
        if (game.hasVisual(naveJugador)){
            game.removeVisual(naveJugador)
        }

    //Verifica y borra a cada enemigo que haya quedado vivo
        enemigos.forEach({ enemigo =>
            if (game.hasVisual(enemigo)) {
                game.removeVisual(enemigo)
            }
        })

        //Vacia la lista para empezar de cero
        enemigos.clear()
    }

    //#Turnos

    //Termina el turno del jugador y avanzan los enemigos
    method turnoJugadorTerminado() {
        enemigos.forEach{ enemigo => enemigo.mover()}

        naveJugador.enfriarArmas()
        self.verificarGameOver()
    }

    //Permite al jugador disparar si la partida esta iniciada
    method dispararJugador() {
        if (self.estaJugando()) {
            naveJugador.disparar()
        }
    }

    //#Game over

    method verificarGameOver() {
        if (enemigos.any({ enemigo => enemigo.position().y() <= 0})) {
            self.gameOver()
        }
    }

    method gameOver() {
        estadoActual.gameOver()
    }

    method finalizarPartida() {
        self.limpiarTablero()
        estadoActual = estadoGameOver
        pantallaGameover.mostrar()
        controlesJugador.detenerTickMovimineto()
        proyectil.detenerTickProyectil()
    }
}
