import mapa.*
import utilidades.*
object generadorEnemigos {

    method capacidadMaximaGeneracion() {
        return mapa.anchoMapa() * mapa.rangoEnemigos()
    }

    //Propone una posición aleatoria sin superponer enemigos
    method posicionValida(enemigos) {

        const posicionX = aleatorio.generarNumeroAleatorio(0, mapa.anchoMapa() - 1)
        const posicionY = mapa.filaMinimaEnemigos() + aleatorio.generarNumeroAleatorio(0, mapa.rangoEnemigos())

        const posicionPropuesta = game.at(posicionX, posicionY)

        //Evita que dos enemigos ocupen las mismas coordenadas
        if (enemigos.any({ enemigo => enemigo.position() == posicionPropuesta})) {
            return self.posicionValida(enemigos)
        }

        return posicionPropuesta
    }

    //Genera enemigos según la ronda actual
    method generarEnemigos(nivel) {
        const enemigos = []

        nivel.cantidadDeEnemigos().times({ indice =>
            const tipoDeEnemigo = nivel.tipoDeEnemigo()
            const posicion = self.posicionValida(enemigos)

            enemigos.add(
                tipoDeEnemigo.crear(posicion, nivel.nivel())
            )
        })

        return enemigos
    }
}