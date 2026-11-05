import wollok.game.*
import enemigo.*
import armas.*
import utilidades.*
import nivel.*

object mapa {
    const ancho = 8
    const alto = 16
    const tamanioCelda = 64
    const rangoAparicionEnemigos = 3
    const posicionMinimaEnemigos = 13

    //Configuración del mapa
    method configuracionMapa() {
        game.width(ancho)
        game.height(alto)
        game.cellSize(tamanioCelda)
        game.boardGround("pantallas/fondo.png")
    }

    //Getters
    method anchoMapa() = ancho
    method rangoEnemigos() = rangoAparicionEnemigos
    method filaMinimaEnemigos() = posicionMinimaEnemigos

    //Validación de posicion del jugador
    method posicionValidaJugador(posicion) {
        return posicion.x() >= 0 && posicion.x() < ancho && posicion.y() >= 0 && posicion.y() < alto
    }
}
