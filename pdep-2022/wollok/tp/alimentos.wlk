class Alimento {
	var posicion
	var masa
	
	method posicion() {
		return posicion
	}
	
	method masa() {
		return masa
	}
	
	method masa(unaCantidad) {
		masa = unaCantidad
	}
	
	method extraerAlimento(unaCantidad) {
		masa = 0.max(masa - unaCantidad - 1)
	}
}
