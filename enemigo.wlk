import jugador.*
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


    //#Daño y muerte
    
    method recibirDanio(cantidad){
        vida = vida - cantidad

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
    override method recibirDanio(cantidad){
        super(cantidad * 1.5)
    }
}

class EnemigoFuerte inherits Enemigo {
    const armadura = 25

    method calcularDanio(cantidad) {
        if(cantidad > armadura){
            return cantidad - armadura
        } 
        else{
            return 0
        }
    }

    override method recibirDanio(cantidad) {
        super(self.calcularDanio(cantidad))
    }
}
class EnemigoSuperFuerte inherits Enemigo {
   var tieneEscudo = true

    override method recibirDanio(cantidad) {
        if(tieneEscudo){
            tieneEscudo = false
        }
        else{
            super(cantidad)
        }
    }
}
