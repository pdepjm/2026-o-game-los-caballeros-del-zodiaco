import jugador.*
import enemigo.*
import pantallas.*
import game.*

object partida{
    //Arranque de juego
    var inicio = false
    method iniciar(){
        inicio = true
    }


    //Temporal hasta que usemos inherit
    var property enemigos = [
    new Enemigo(vida = 100, position = game.at(2,11), imagen = "enemigoComun.png"),
    new Enemigo(vida = 150, position = game.at(5,11), imagen = "enemigoFuerte.png"),
    new Enemigo(vida = 200, position = game.at(7,11), imagen = "enemigoSuperFuerte.png"),
    new Enemigo(vida = 200, position = game.at(2,10), imagen = "enemigoSuperFuerte.png")]

    method turnoJugadorTerminado() {
        enemigos.forEach{ enemigo => enemigo.mover()}

        //Comprueba la muerte del jugador
        self.muerteJugador()
    }

    //Game over
    method muerteJugador(){
        if(enemigos.any({ enemigo => enemigo.position().y() <= 0})){
            self.gameOver()
        }
    }

    method gameOver(){
        //Elimino enemigos y nave
        game.removeVisual(naveJugador)
        enemigos.forEach { enemigo => game.removeVisual(enemigo)}

        //Pantalla de game over
        pantallaGameover.mostrar()
    }
}