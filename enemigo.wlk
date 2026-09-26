
class Enemigo{
    var property position = game.origin()
    var property vida = 100
    var property danio = 10 //Se puede borrar dependiendo de la idea

    //Movimiento segun tipo de enemigo
    method mover() {
        //
    }  

    //Se puede borrar dependiendo de la idea
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