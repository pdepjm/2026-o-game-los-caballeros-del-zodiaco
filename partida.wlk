import jugador.*
import enemigo.*
import pantallas.*
import game.*
import armas.*

object partida{
    //Inicio de partida
    var jugando = false
    method iniciar(){
        if(!jugando){
            //Cambio a true para q no puedan volver a apretar espacio
            jugando = true

            //Remuevo el menu y el gameover (si se reinicia la partida)
            game.removeVisual(menu)
            game.removeVisual(pantallaGameover)
            
            //Aparicion del jugador y reinicio
            game.addVisual(naveJugador)
            naveJugador.reiniciar()

            //Aparicion de enemigos y reseteo (si se reinicia la partida)
            self.enemigos().forEach{ enemigo => game.addVisual(enemigo) enemigo.reiniciar() }
        }
    }

    //Posicion del enemigo
    method posicion(){
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 12 + 0.randomUpTo(2).truncate(0)
        return game.at(x,y)
    }

    //Temporal hasta que usemos inherit
    var property enemigos = [
    new Enemigo(vida = 100, position = self.posicion(), imagen = "enemigoComun.png", debilidad = bala),
    new Enemigo(vida = 100, position = self.posicion(), imagen = "enemigoFuerte.png", debilidad = laser),
    new Enemigo(vida = 100, position = self.posicion(), imagen = "enemigoSuperFuerte.png", debilidad = cohete),
    new Enemigo(vida = 100, position = self.posicion(), imagen = "enemigoSuperFuerte.png", debilidad = cohete)]

    //Termina el turno del jugador -> avanzan los enemigos 
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
        //Cambio a false para q no aprete espacio
        jugando = false

        //Elimino enemigos y nave
        game.removeVisual(naveJugador)
        enemigos.forEach { enemigo => game.removeVisual(enemigo)}

        //Pantalla de game over
        pantallaGameover.mostrar()
    }
}