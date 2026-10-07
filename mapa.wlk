import wollok.game.*
import enemigo.*
import armas.*


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

	//#Generacion de enemigos

	method generarNumeroAleatorio(base, minimo, maximo){
		return base + minimo.randomUpTo(maximo).truncate(0)
	}

	//Propone una posicion aleatoria dentro de la zona elegida
	method posicionValida(enemigos) {
        const posicionX = self.generarNumeroAleatorio(0, 0, ancho)
        const posicionY = self.generarNumeroAleatorio(posicionMinimaEnemigos, 0, rangoAparicionEnemigos)
        const posicionPropuesta = game.at(posicionX, posicionY)

		//Verifica si la posicion propuesta esta ocupada
        if (enemigos.any({ enemigo => enemigo.position() == posicionPropuesta })) {
            return self.posicionValida(enemigos)
        }

        return posicionPropuesta
    }

	//Genera los enemigos usando la clase Enemigo
    method generarEnemigos() {
        const enemigos = []

        enemigos.add(new Enemigo(
            vida = 100,
            position = self.posicionValida(enemigos),
            imagen = "enemigos/enemigoComun.png",
            debilidad = bala
        ))

        enemigos.add(new Enemigo(
            vida = 100,
            position = self.posicionValida(enemigos),
            imagen = "enemigos/enemigoFuerte.png",
            debilidad = laser
        ))

        enemigos.add(new Enemigo(
            vida = 100,
            position = self.posicionValida(enemigos),
            imagen = "enemigos/enemigoSuperFuerte.png",
            debilidad = cohete
        ))

        enemigos.add(new Enemigo(
            vida = 100,
            position = self.posicionValida(enemigos),
            imagen = "enemigos/enemigoSuperFuerte.png",
            debilidad = cohete
        ))

        return enemigos
    }

    method agregarEnemigos(enemigos) {
        enemigos.forEach { enemigo =>
            game.addVisual(enemigo)
        }
    }
}