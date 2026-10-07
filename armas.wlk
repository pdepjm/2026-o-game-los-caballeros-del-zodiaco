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

object manejoDeDisparo {
    
    method disparar(arma, nave, enemigos) {
        proyectil.dispararDesde(nave)
        proyectil.imagen(arma.imagen())

        const objetivo = self.objetivoMasCercano(nave, enemigos)

        if (objetivo != null) {
            self.impactar(arma, objetivo)
        }
    }

    method estaEnLinea(nave, enemigo) = nave.position().x() == enemigo.position().x()

    method objetivoMasCercano(nave, enemigos) {
        const enemigosEnLinea = enemigos.filter({enemigo => self.estaEnLinea(nave, enemigo)})

        if (enemigosEnLinea.isEmpty()) {
            return null
        }

        return enemigosEnLinea.min({enemigo => enemigo.position().y()})
    }

    //Recibe arma y enemigo -> Cambia la imagen y el enemigo recibe danio segun arma
    method impactar(arma, enemigo){
        enemigo.recibirDanio(arma)
    }
}

class Arma{
    const imagen
    method imagen() = imagen
}

const bala = new Arma(imagen = "armas/bala.png")
const laser = new Arma(imagen = "armas/laser.png")
const cohete = new Arma(imagen = "armas/cohete.png")