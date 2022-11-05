import usuarios.*

class Vehiculo {
	var capacidadTanque
	var cantidadCombustible
	var velocidadPromedio
	
	method recorrer(unaDistancia) {
		cantidadCombustible -= self.naftaPara(unaDistancia)
	}
	
	method naftaPara(unaDistancia) {
		return self.perdidaBaseSegunTipo() + (unaDistancia * self.gastoPorKilometro()) 
	}
	
	method cargarNafta(unaCantidad) {
		if(self.superaCapacidadTanque(unaCantidad)) {
			self.error("No se puede superar la capacidad del tanque!")
		}
		
		cantidadCombustible += unaCantidad 
	}
	
	method costoViaje(unaDistancia) {
		return self.costoLitroNafta() * self.naftaPara(unaDistancia)
	}
	
	method costoLitroNafta() {
		return 40
	}
	
	method velocidadPromedio() {
		return velocidadPromedio
	}
	
	method superaCapacidadTanque(unaCantidad) {
		return capacidadTanque < cantidadCombustible + unaCantidad
	}
	
	method esEcologico()
	
	method perdidaBaseSegunTipo()
	
	method gastoPorKilometro()
}

class Camioneta inherits Vehiculo {
	override method esEcologico() {
		return false
	}
	
	override method perdidaBaseSegunTipo() {
		return 4
	}
	
	override method gastoPorKilometro() {
		return 5
	}
}

class Auto inherits Vehiculo {
	override method perdidaBaseSegunTipo() {
		return 2
	}
}

class Deportivo inherits Auto {
	override method esEcologico() {
		return self.velocidadPromedio() < 120
	}
	
	override method gastoPorKilometro() {
		return 0.2 * self.velocidadPromedio()
	}
}

class Familiar inherits Auto {
	override method esEcologico() {
		return true
	}
	
	override method gastoPorKilometro() {
		return 0
	}
}