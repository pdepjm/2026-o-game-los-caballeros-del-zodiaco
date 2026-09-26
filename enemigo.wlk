
class Enemigo{
    var property position
    var property vida 
    var property danio = 10
    var property imagen 
    
    //Para probar
    method image() = imagen

    //Movimiento segun jugador
    method mover() {

        //Se mueve un casillero abajo
        position = position.down(1)
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

//Para probar
const enemigoComun = new Enemigo(vida = 100, position = game.at(2,11), imagen = "enemigoComun.png")
const enemigoFuerte = new Enemigo(vida = 150, position = game.at(5,11), imagen = "enemigoFuerte.png")
const enemigoSuperFuerte = new Enemigo(vida = 200, position = game.at(7,11), imagen = "enemigoSuperFuerte.png")


//Para el futuro
/*object enemigoNormal inherits Enemigo{

    method mover(){
        //
    }
}*/