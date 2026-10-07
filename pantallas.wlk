import game.*

class Pantalla {
    const imagen

    method position() = game.at(0,0)
    method image() = imagen

    method mostrar(){
        game.addVisual(self)
    }

    method ocultar(){
        game.removeVisual(self)
    }
}

const menu = new Pantalla(imagen = "pantallas/menu.png")
const pantallaGameover = new Pantalla(imagen = "pantallas/gameover.png")
const pantallaWin = new Pantalla(imagen = "pantallas/menu.png")

