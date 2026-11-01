import jugador.*
import enemigo.*
import pantallas.*
import game.*
import armas.*
import mapa.*
import nivel.*

class EstadoPartida {

    //Cada estado responde únicamente a los mensajes que tienen sentido en su contexto
    //Los métodos vacíos evitan ejecutar comportamientos que no corresponden al estado actual
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

    //#Inicio y reinicio de la partida

    method iniciar() {
        estadoActual.iniciar()
    }

    method reiniciar() {
        nivelActual = new Nivel(nivel = 1)
        self.prepararPartida()
    }

    method prepararPartida() {
        nivelActual = new Nivel(nivel = 1)
        self.limpiarTablero()
        self.prepararJugador()
        self.prepararEnemigos()
        self.ocultarPantallas()
        estadoActual = estadoJugando
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
        enemigos = mapa.generarEnemigos(nivelActual)
        mapa.agregarEnemigos(enemigos)
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

    //#Game over

    method verificarGameOver(){
        if(mapa.algunEnemigoLlegoAlJugador(enemigos)){
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
    }
}
