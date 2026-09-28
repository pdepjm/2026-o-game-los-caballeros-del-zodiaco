import jugador.*

object proyectil{
    var property position = game.at(-10,-10)
    var property imagen = "bala.png"
    var moviendose = false

    method image() = imagen

    method dispararDesde(naveJugador){
        position = naveJugador.position()
        moviendose = true
    }

    method mover(){
        if(moviendose){
            if(position.y() < game.height()){
                position = position.up(1)
            }
            else{
                moviendose = false
            }
        }
    }

    //Movimiento continuo
    const tickProyectil = game.tick(20, {self.mover()}, false)

    method iniciar(){
        tickProyectil.start()
    }
}

object bala{
    method impactar(enemigo){
        proyectil.imagen("bala.png")
        enemigo.recibirDanio(self)
    }
}

object laser{
    method impactar(enemigo){
        proyectil.imagen("bala.png")
        enemigo.recibirDanio(self)
    }
}

object cohete{
    method impactar(enemigo){
        proyectil.imagen("bala.png")
        enemigo.recibirDanio(self)
    }
}