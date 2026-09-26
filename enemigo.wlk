import partida.*

class Enemigo{
    var property position
    var property vida 
    var property danio = 10
    var property imagen 
    
    //Para probar
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

    method recibirDanio(cantidad){
        vida = vida - cantidad

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
    }
}




//Para el futuro
/*object enemigoNormal inherits Enemigo{

    method mover(){
        //
    }
}*/