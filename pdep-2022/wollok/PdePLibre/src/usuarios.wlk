import niveles.*

class Usuario {
	var nombre
	var dineroDisponible
	var puntos
	var nivel
	var cupones = []
	const carrito = []
	
	method agregarProductoAlCarrito(unProducto) {
		nivel.agregarProducto(unProducto, self)
	}
	
	method carrito() {
		return carrito
	}
	
	method comprar() {
		var  cuponAUsar = cupones.anyOne()
		var costoCompra = self.precioConCupon(cuponAUsar, self.precioCarrito())
		
		self.pagar(costoCompra)
		cuponAUsar.usar()
		self.aumentarPuntos(costoCompra * 0.1)
	}
	
	method pagar(unaCantidad) {
			dineroDisponible -= unaCantidad
	}
	
	method precioConCupon(unCupon, unPrecio) {
		if(unCupon.sinUsar()) {
			return unPrecio * unCupon.descuento()
		} else {
			return unPrecio
		}
	}
	
	method precioCarrito() {
		return carrito.sum({ unProducto => unProducto.precio() })
	}
	
	method puedePagar(unaCantidad) {
		return dineroDisponible >= unaCantidad
	}
	
	method aumentarPuntos(unaCantidad) {
		puntos += unaCantidad
	}
	
	method disminuirPuntos(unaCantidad) {
		puntos -= unaCantidad
	}
	
	method esMoroso() {
		return dineroDisponible < 0
	}
	
	method eliminarCuponesUsados() {
		cupones = cupones.filter({ unCupon => unCupon.sinUsar() })
	}
	
	method actualizarNivel() {
		if(puntos < plata.puntosNecesarios()) {
			nivel = bronce
		}
		
		if(plata.puntosNecesarios() < puntos && puntos < oro.puntosNecesarios()) {
			nivel = plata
		}
		
		if(oro.puntosNecesarios() < puntos) {
			nivel = oro
		}
	}
}

