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

	//Configuracion del mapa
	method configuracionMapa(){
		game.width(ancho)
		game.height(alto)
		game.cellSize(tamanioCelda)
		game.boardGround("pantallas/fondo.png")
	}

    //Verifica limites del mapa
    method posicionValidaJugador(posicion){
        return posicion.x() >= 0 && posicion.x() < ancho && posicion.y() >= 0 && posicion.y() < alto
    }

	//#Generacion de enemigos

	//Propone una posicion aleatoria dentro de la zona elegida
	method posicionValidaEnemigo(enemigos) {
        const posicionX = aleatorio.generarNumeroAleatorio(0, ancho)
        const posicionY = posicionMinimaEnemigos + aleatorio.generarNumeroAleatorio(0, rangoAparicionEnemigos)
        const posicionPropuesta = game.at(posicionX, posicionY)

		//Verifica si la posicion propuesta esta ocupada
        if (enemigos.any({ enemigo => enemigo.position() == posicionPropuesta })) {
            return self.posicionValidaEnemigo(enemigos)
        }

        return posicionPropuesta
    }

	//Genera los enemigos usando la clase Enemigo
    method generarEnemigos(nivel) {
        const enemigos = []

        nivel.cantidadDeEnemigos().times({ indice =>
            const tipoDeEnemigo = nivel.tipoDeEnemigo()
            const posicion = self.posicionValidaEnemigo(enemigos)

            enemigos.add(tipoDeEnemigo.crear(posicion))
        })

        return enemigos
    }

    method agregarEnemigos(enemigos) {
        enemigos.forEach { enemigo =>
            game.addVisual(enemigo)
        }
    }

    //Si llego algun enemigo en partida salta gameover
    method algunEnemigoLlegoAlJugador(enemigos){
        return enemigos.any({ enemigo => enemigo.position().y() <= 0})
    }
}