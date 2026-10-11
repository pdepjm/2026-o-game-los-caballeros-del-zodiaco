import partida.*
import armas.*
class Enemigo{

    //#Variables

    var property position
    var property vida 
    const property debilidad
    const imagen 
    method image() = imagen

    //#Movimiento

    method mover() {

        //Se mueve un casillero abajo
        position = position.down(1)
    }

    method vidaInicial()

    //#Daño y muerte
    
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
        partida.enemigos().remove(self)
        
        //Cuando se muere el enemigo verifica si ya paso de nivel
        partida.verificarNivelCompletado()
    }
    
}

object fabricaEnemigoComun {
    method crear(posicion) {
        return new EnemigoComun(
            vida = 100,
            position = posicion,
            imagen = "enemigos/enemigoComun.png",
            debilidad = bala
        )
    }
}

object fabricaEnemigoFuerte {
    method crear(posicion) {
        return new EnemigoFuerte(
            vida = 150,
            position = posicion,
            imagen = "enemigos/enemigoFuerte.png",
            debilidad = laser
        )
    }
}

object fabricaEnemigoSuperFuerte {
    method crear(posicion) {
        return new EnemigoSuperFuerte(
            vida = 200,
            position = posicion,
            imagen = "enemigos/enemigoSuperFuerte.png",
            debilidad = cohete
        )
    }
}
class EnemigoComun inherits Enemigo {
    override method vidaInicial() = 100
}

class EnemigoFuerte inherits Enemigo {
    override method vidaInicial() = 150
}

class EnemigoSuperFuerte inherits Enemigo {
   override method vidaInicial() = 200
}
