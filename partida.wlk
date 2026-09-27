import jugador.*
import enemigo.*
import pantallas.*
import game.*
import armas.*

object partida{
    //#Inicio de partida
    
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

    /*
    //Posicion del enemigo
    method posicion(){
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 13 + 0.randomUpTo(2).truncate(0)
        return game.at(x,y)
    }
    */

    //#Generacion de enemigos

    method posicionValida(){
        //Propone una posicion aleatoria dentro de la zona elegida
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 13 + 0.randomUpTo(2).truncate(0)
        const posicionPropuesta = game.at(x, y)

        //Verifica si la posicion propuesta esta ocupada
        if(enemigos.any({ enemigos => enemigos.position() == posicionPropuesta })){
            return self.posicionValida() //Si otro enemigo esta en esa posicion, repite el proceso
        }else{
            return posicionPropuesta //Si es valida, devuelve las coordenadas
        }
    }
    
    //Lista de enemigos en pantalla
    var property enemigos = []

    //Genera los enemigos usando la clase Enemigo
    method generarEnemigos(){
        enemigos.add(new Enemigo(vida = 100, position = self.posicionValida(), imagen = "enemigoComun.png", debilidad = bala))
        enemigos.add(new Enemigo(vida = 100, position = self.posicionValida(), imagen = "enemigoFuerte.png", debilidad = laser))
        enemigos.add(new Enemigo(vida = 100, position = self.posicionValida(), imagen = "enemigoSuperFuerte.png", debilidad = cohete))
        enemigos.add(new Enemigo(vida = 100, position = self.posicionValida(), imagen = "enemigoSuperFuerte.png", debilidad = cohete))
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
        //Cambio a false para q no aprete espacio
        jugando = false

        //Elimino enemigos y nave
        game.removeVisual(naveJugador)
        enemigos.forEach { enemigo => game.removeVisual(enemigo)}

        //Pantalla de game over
        pantallaGameover.mostrar()
    }
}