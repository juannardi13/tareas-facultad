import vehiculos.*

class Usuario {
	var nombreUsuario
	var dni
	var dineroEnCuenta
	var vehiculoAsociado
	var multas = []
	
	method recorrer(unaDistancia) {
		if(self.puedePagarNafta(unaDistancia)) {
			self.pagar(vehiculoAsociado.costoViaje(unaDistancia))
			vehiculoAsociado.recorrer(unaDistancia)
		} else {
			throw new Exception(message = "No se puede pagar el viaje!")
		}
	}
	
	method puedePagar(unaCantidad) {
		return dineroEnCuenta >= unaCantidad
	}
	
	method puedePagarNafta(unaDistancia) {
		return self.puedePagar(vehiculoAsociado.costoViaje(unaDistancia))
	}
	
	method pagar(unaCantidad) {
		dineroEnCuenta -= unaCantidad
	}
	
	method agregarMulta(unaMulta) {
		multas.add(unaMulta)
	}
	
	method tieneDNIHabilitado() {
		var diaActual = new Date().day()
		
		return diaActual.odd() && self.tieneDNIImpar() || diaActual.even() && self.tieneDNIPar()
	}
	
	method tieneDNIImpar() {
		return dni.odd()
	}
	
	method tieneDNIPar() {
		return dni.even()
	}
	
	method velocidadDelAuto() {
		return vehiculoAsociado.velocidadPromedio()
	}
	
	method pagarMultas() {
		multas.forEach({ unaMulta => self.pagarMulta(unaMulta) })
		self.eliminarMultasPagas()
	}
	
	method pagarMulta(unaMulta) {
		if(self.puedePagar(unaMulta.costo())) {
			self.pagar(unaMulta.costo())
			unaMulta.cancelar()
		} else {
			unaMulta.costo(unaMulta.costo() * unaMulta.interesMulta())
		}
	}
	
	method eliminarMultasPagas() {
		multas = multas.filter({ unaMulta => unaMulta.estaPaga() })
	}
	
	method esComplicado() {
		return self.deudasMultas() > 5000
	}
	
	method deudasMultas() {
		return multas.sum({ unaMulta => unaMulta.costo() })
	}
}
