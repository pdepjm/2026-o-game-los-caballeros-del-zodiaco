import jugador.*
import enemigo.*
import pantallas.*
import game.*
import armas.*
import mapa.*
import nivel.*

object partida{
    //#Estado de la partida
    var nivelActual = nivel1
    var jugando = false
    var property enemigos = []

    //#Inicio  y reinicio de partida
    
    method iniciar() {
        if (!jugando) {
            self.prepararPartida()
        }
    }

    method reiniciar(){
        nivelActual = nivel1
        self.prepararPartida()
    }

    method prepararPartida() {
        jugando = true

        self.limpiarTablero()
        self.prepararJugador()
        self.prepararEnemigos()
        self.ocultarPantallas()
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

    //# Limpieza

    method limpiarTablero() {
        //Verifica que la nave este en pantalla antes de sacarla
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

    //Termina el turno del jugador -> avanzan los enemigos 
    method turnoJugadorTerminado() {
        enemigos.forEach{ enemigo => enemigo.mover()}

        //Comprueba la muerte del jugador
        self.verificarGameOver()
    }

    //#Game over

    method verificarGameOver(){
        if(mapa.algunEnemigoLlegoAlJugador(enemigos)){
            self.gameOver()
        }
    }

    method gameOver(){
        //Cambio a false para que no aprete espacio
        jugando = false

        //Pantalla de game over
        pantallaGameover.mostrar()
    }

}