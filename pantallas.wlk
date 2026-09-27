import game.*
object menu {
    method position() = game.at(0,0)
    method image() = "menu.png"
}

object pantallaGameover {
    method position() = game.at(0,0)
    method image() = "menu.png"

    method mostrar(){
        game.addVisual(self)
    }    
}