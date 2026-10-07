import game.*
object menu {
    method position() = game.at(0,0)
    method image() = "pantallas/menu.png"
}

object pantallaGameover {
    method position() = game.at(0,0)
    method image() = "pantallas/gameover.png"

    method mostrar(){
        game.addVisual(self)
    }    
}

//No esta todavia
object pantallaWin {
    method position() = game.at(0,0)
}