import enemigo.*

object partida{
    //Temporal hasta que usemos inherit
    var property enemigos = [
    new Enemigo(vida = 100, position = game.at(2,11), imagen = "enemigoComun.png"),
    new Enemigo(vida = 150, position = game.at(5,11), imagen = "enemigoFuerte.png"),
    new Enemigo(vida = 200, position = game.at(7,11), imagen = "enemigoSuperFuerte.png"),
    new Enemigo(vida = 200, position = game.at(2,10), imagen = "enemigoSuperFuerte.png")]

    method turnoJugadorTerminado() {
        enemigos.forEach{ enemigo => enemigo.mover()}
    }
}