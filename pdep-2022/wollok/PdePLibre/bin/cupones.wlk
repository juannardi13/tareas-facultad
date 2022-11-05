class Cupon {
	var activo = true
	var porcentajeDescuento
	
	method descuento() {
		return porcentajeDescuento / 100
	}
	
	method usar() {
		activo = false
	}
	
	method sinUsar() {
		return activo
	}
}