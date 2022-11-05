class Multa {
	var costo
	var activa
	
	method costo() {
		return costo
	}
	
	method interesMulta() {
		return 1.1
	}
	
	method estaPaga() {
		return !activa
	}
	
	method cancelar() {
		activa = false
	}
	
	method costo(unaCantidad) {
		costo = unaCantidad
	}
}