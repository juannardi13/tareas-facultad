import usuarios.*
import zonas.*
import multas.*

class Control {
	
	method multar(unUsuario, unaZona) {
		if(self.puedeSerMultado(unUsuario, unaZona)) {
			unUsuario.agregarMulta(new Multa(costo = self.valorMulta(), activa = true))
		}
	}
	
	method valorMulta()
	method puedeSerMultado(unUsuario, unaZona)
}

class ControlVelocidad inherits Control {
	override method valorMulta() {
		return 3000
	}
	
	override method puedeSerMultado(unUsuario, unaZona) {
		return unaZona.superaVelocidadMaxima(unUsuario)
	}
}

class ControlEcologico inherits Control {
	override method valorMulta() {
		return 1500
	}
	
	override method puedeSerMultado(unUsuario, unaZona) {
		return unUsuario.tieneVehiculoContaminante()
	}
}

class ControlRegulatorio inherits Control {
	override method valorMulta() {
		return 2000
	}
	
	override method puedeSerMultado(unUsuario, unaZona) {
		return unUsuario.tieneDNIHabilitado()
	}
}

