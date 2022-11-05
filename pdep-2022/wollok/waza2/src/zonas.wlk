import usuarios.*
import controles.*

class Zona {
	var velocidadMaximaPermitida
	const usuarios = #{}
	const controles = []
	
	method agregarControl(unControl) {
		controles.add(unControl)
	}
	
	method activarControl(unControl) {
		usuarios.forEach({ unUsuario => unControl.multar(unUsuario, self) })
	}
	
	method velocidadMaximaPermitida() {
		return velocidadMaximaPermitida
	}
	
	method superaVelocidadMaxima(unUsuario) {
		return velocidadMaximaPermitida < unUsuario.velocidadDelAuto()
	}
	
	method transito() {
		return usuarios.size()
	}
}

