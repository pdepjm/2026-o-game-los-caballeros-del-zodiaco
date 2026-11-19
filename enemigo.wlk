import jugador.*
import partida.*

class Enemigo{

    //#Variables

    var property position
    var property vida
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

    method morir() {
        partida.eliminarEnemigo(self)
    }
        
}

object fabricaEnemigoVeloz {
    method crear(posicion, nivel) {
        return new EnemigoVeloz(
            vida = 100,
            position = posicion,
            imagen = "enemigos/enemigoComun.png"
        )
    }
}

object fabricaEnemigoFuerte {
    method nivelAparicion() = 3

    method crear(posicion, nivel) {
        return new EnemigoFuerte(
            vida = 150,
            position = posicion,
            imagen = "enemigos/enemigoFuerte.png"
        )
    }
}

object fabricaEnemigoSuperFuerte {
    method nivelAparicion() = 5
    
    method crear(posicion, nivel) {
        return new EnemigoSuperFuerte(
            vida = 200 * (1.1 ** (nivel - self.nivelAparicion())),
            position = posicion,
            imagen = "enemigos/enemigoSuperFuerte.png"
        )
    }
}

class EnemigoVeloz inherits Enemigo {

    const vidaMaxima = 150
    const curacionXMovimiento = 0.1 * vida

    //El enemigo avanza dos casillas por turno
    override method mover() {
        super()
        self.curarse()
    }

    method curarse(){
        if (vida < vidaMaxima){
            vida = vida + curacionXMovimiento
        }
    }

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

    override method image() {
        if (tieneEscudo) {
            return "enemigos/enemigoSuperFuerte_Escudo.png"
        }
        return super()
    }

    override method recibirDanio(cantidad) {
        if(tieneEscudo){
            tieneEscudo = false
        }
        else{
            super(cantidad)
        }
    }
}
