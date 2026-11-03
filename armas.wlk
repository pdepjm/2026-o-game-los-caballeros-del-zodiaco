import wollok.game.*
import jugador.*
import partida.*

object proyectil {
    var property position = game.at(-10, -10)
    var imagen = "bala.png"

    var moviendose = false
    var armaActual = bala
    var enemigosActuales = []

    method image() = imagen

    method estaMoviendose() = moviendose

    method dispararDesde(nave, arma, enemigos) {
        position = nave.position()
        imagen = arma.imagen()
        armaActual = arma
        enemigosActuales = enemigos
        moviendose = true
    }

    //# Movimiento

    method mover() {
        if (moviendose) {
            if (self.puedeAvanzar()) {
                position = position.up(1)
            } else {
                self.ocultar()
            }
        }
    }

    method puedeAvanzar() {
        return position.y() < game.height() - 1
    }

    //# Colisiones

    method colisionarCon(objetivo) {
        if (moviendose && self.esObjetivoValido(objetivo)) {
            armaActual.impactar(objetivo)
            self.ocultar()
        }
    }

    method esObjetivoValido(objetivo) {
        return enemigosActuales.contains(objetivo)
    }

    //# Finalización

    method ocultar() {
        moviendose = false
        position = game.at(-10, -10)
    }

    const tickProyectil = game.tick(20, { self.mover() }, false)

    method iniciar() {
        if (!game.hasVisual(self)) {
            game.addVisual(self)
        }

        game.onCollideDo(self, { elemento =>
            self.colisionarCon(elemento)
        })

        tickProyectil.start()
    }
}

object manejoDeDisparo {

    method disparar(arma, nave, enemigos) {
        if (self.puedeDisparar(arma)) {
            proyectil.dispararDesde(nave, arma, enemigos)

            arma.usar()

            return true
        } 
        else {
            return false
        }
    }

    method puedeDisparar(arma) {
        return arma.estaDisponible() && !proyectil.estaMoviendose()
    }
}

class Arma{
    const imagen
    const turnosDeRecarga
    var turnosRestantes = 0
    const property danioBase //Uso de property para desmarcar el error "Unused variable". No afecta al funcionamiento.
    method imagen() = imagen

    //Varia segun lo especificado por cada arma
    method impactar(objetivo)

    method estaDisponible() = turnosRestantes == 0

    //Una vez disparada el arma, entra en recarga
    method usar(){
        turnosRestantes = turnosDeRecarga
    }

    //Reduce el cooldown en 1
    method enfriar(){
        if (turnosRestantes > 0){
            turnosRestantes -= 1
        }
    }

    method reiniciarCooldown(){
        turnosRestantes = 0
    }

}

//#Bala

object bala inherits Arma(imagen = "armas/bala.png", danioBase = 50, turnosDeRecarga = 0){

    override method impactar(objetivo){
        objetivo.recibirDanio(danioBase)
    }
}

object laser inherits Arma(imagen = "armas/laser.png", danioBase = 150, turnosDeRecarga = 2){

    override method impactar(objetivo){
        objetivo.recibirDanio(danioBase)

        //Calcula la posicion siguiente en la columna
        const posicionAtras = objetivo.position().up(1)

        //Arma una lista con el enemigo de detras y le hace el daño. Evita errores ante listas vacias.
        partida.enemigos()
            .filter({enemigo => enemigo.position() == posicionAtras})
            .forEach({enemigo => enemigo.recibirDanio(danioBase)})
    }
}

object cohete inherits Arma(imagen = "armas/cohete.png", danioBase = 200, turnosDeRecarga = 3){
    
    override method impactar(objetivo){
        objetivo.recibirDanio(danioBase)

        //Arma una lista con los enemigos adyacente y le hace el daño. Tambien evita errores ante listas vacias.
        partida.enemigos()
            .filter({enemigo => self.esAdyacente(enemigo, objetivo)})
            .forEach({enemigo => enemigo.recibirDanio(danioBase / 2)})
    }

    //Verifica si los enemigos son adyacentes al impactado (distancia = 1)
    method esAdyacente(enemigo, centroExplosion){
        return enemigo.position().distance(centroExplosion.position()) == 1
    }
}