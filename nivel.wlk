import utilidades.*
import enemigo.*

class Nivel {
    const property nivel
    const capacidadMaximaEnemigos = 24

    //La cantidad crece con el nivel
    method cantidadMinimaEnemigos() {
        if (nivel > capacidadMaximaEnemigos) {
            return capacidadMaximaEnemigos
        }
        return nivel
    }

    method cantidadMaximaEnemigos() {
        const cantidadPropuesta = nivel + 1
        if (cantidadPropuesta > capacidadMaximaEnemigos) {
            return capacidadMaximaEnemigos
        }
        return cantidadPropuesta
    }

    method cantidadDeEnemigos() {
        return aleatorio.generarNumeroAleatorio(
            self.cantidadMinimaEnemigos(),
            self.cantidadMaximaEnemigos()
        )
    }

    //Los tipos disponibles se amplian gradualmente
    method tiposDeEnemigoDisponibles() {
        const tipos = [fabricaEnemigoVeloz]

        if (nivel >= 3) {
            tipos.add(fabricaEnemigoFuerte)
        }
        if (nivel >= 5) {
            tipos.add(fabricaEnemigoSuperFuerte)
        }

        return tipos
    }

    method tipoDeEnemigo() {
        return self.tiposDeEnemigoDisponibles().anyOne()
    }
}
