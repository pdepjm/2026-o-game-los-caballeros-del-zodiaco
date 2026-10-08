object aleatorio {
  
  method generarNumeroAleatorio(minimo, maximo){
		return minimo.randomUpTo(maximo).truncate(0)
	}
}