
class Enemigo{
    var property position = game.origin()
    var property vida = 100
    var property danio = 10

    //Movimiento segun jugador
    method mover() {
        //
    }  

    method ataque(jugador){
        jugador.recibirDanio(danio)
    }

    method recibirDanio(cantidad){
        vida = vida - cantidad
    }

    method estaMuerto(){
        return vida <= 0
    }
}

object enemigoNormal inherits Enemigo{

    method mover(){
        //
    }
}