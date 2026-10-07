import jugador.*
import enemigo.*
import pantallas.*
import game.*
import armas.*
import mapa.*

object partida{
    //#Inicio  y reinicio de partida

    var property jugando = false
    var property enemigos = []

    method iniciar(){
        if(!jugando){
            //Cambio a true para que no puedan volver a apretar espacio
            jugando = true

            //Verificacion para evitar que el codigo se rompa
            if (game.hasVisual(menu)) {
                //Remuevo el menu
                game.removeVisual(menu)
            }
            if (game.hasVisual(pantallaGameover)) {
                //Remuevo el Game Over
                game.removeVisual(pantallaGameover)
            }

            //Removemos todo lo dibujado en pantalla
            self.limpiarTablero()
            
            //Aparicion del jugador evitando duplicados y reinicio
            game.addVisual(naveJugador)
            naveJugador.reiniciar()

            //Agregamos a los enemigos
            enemigos = mapa.generarEnemigos()
            mapa.agregarEnemigos(enemigos)  
        }
    }

    //#Turnos

    //Termina el turno del jugador -> avanzan los enemigos 
    method turnoJugadorTerminado() {
        enemigos.forEach{ enemigo => enemigo.mover()}

        //Comprueba la muerte del jugador
        self.muerteJugador()
    }

    //#Game over

    method muerteJugador(){
        if(enemigos.any({ enemigo => enemigo.position().y() <= 0})){
            self.gameOver()
        }
    }

    method gameOver(){
        //Cambio a false para que no aprete espacio
        jugando = false

        //Pantalla de game over
        pantallaGameover.mostrar()
    }

    method limpiarTablero() {
        //Verifica que la nave este en pantalla antes de sacarla
        if (game.hasVisual(naveJugador)) {
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
}