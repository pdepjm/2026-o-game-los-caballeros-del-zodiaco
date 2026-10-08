import utilidades.*
import enemigo.*
class Nivel {
    const cantidadMinimaEnemigos
    const cantidadMaximaEnemigos
    const tiposDeEnemigo

    //Determina la cantidad de enemigos del nivel
    method cantidadDeEnemigos() {
        return aleatorio.generarNumeroAleatorio(
            cantidadMinimaEnemigos,
            cantidadMaximaEnemigos
        )
    }

    //Devuelve una fábrica de enemigo elegida al azar
    method tipoDeEnemigo() {
        return tiposDeEnemigo.anyOne()
    }
}

const nivel1 = new Nivel(cantidadMinimaEnemigos = 1, cantidadMaximaEnemigos = 3, tiposDeEnemigo = [fabricaEnemigoComun])
const nivel2 = new Nivel(cantidadMinimaEnemigos = 4, cantidadMaximaEnemigos = 6, tiposDeEnemigo = [fabricaEnemigoComun, fabricaEnemigoFuerte])
const nivel3 = new Nivel(cantidadMinimaEnemigos = 7, cantidadMaximaEnemigos = 9, tiposDeEnemigo = [fabricaEnemigoComun, fabricaEnemigoFuerte, fabricaEnemigoSuperFuerte])