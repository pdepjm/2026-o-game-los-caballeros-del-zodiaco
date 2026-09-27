import partida.*

class Enemigo{
    var property position
    var property vida 
    var property danio = 10
    const property debilidad
    const imagen 
    method image() = imagen

    //Movimiento segun tipo de enemigo
    method mover() {

        //Se mueve un casillero abajo
        position = position.down(1)
    }  

    //Se puede borrar dependiendo de la idea
    method ataque(jugador){
        jugador.recibirDanio(danio)
    }

    method recibirDanio(arma){
        //Si es atacado con su debilidad, muere. De lo contrario, se le inflinge la mitad del daño.
        if(arma == debilidad){
            vida = vida - 100
        }
        else{
            vida = vida - 50
        }

        //Cada vez que recibe daño se verifica si muere
        if(self.estaMuerto()){
            self.morir()
        }
    }

    method estaMuerto(){
        return vida <= 0
    }

    method morir(){
        //Desaparece la nave
        game.removeVisual(self)

        //Se borra el objeto de la partida
        //partida.enemigos().remove(self)
        game.removeVisual(self)
    }

    method reiniciar(){
        position = partida.posicion()
        vida = 100
    }
    
}

//Para el futuro
/*object enemigoNormal inherits Enemigo{

    method mover(){
        //
    }
}*/