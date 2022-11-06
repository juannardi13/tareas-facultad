import usuarios.*

class Nivel {
	method agregarProducto(unProducto, unUsuario) {
		if(self.puedeAgregarProducto(unUsuario)) {
			unUsuario.carrito().add(unProducto)	
		} else {
			throw new Exception(message = "Tu nivel no permite agregar más productos al carrito!")
		}
	}
	
	method puedeAgregarProducto(unUsuario)
	method puntosNecesarios()
	method actualizarNivel(unUsuario)
	method puedeSubirDeNivel(unUsuario)
}

class NivelBajo inherits Nivel {
	override method puedeAgregarProducto(unUsuario) {
		return unUsuario.carrito().size() < self.maximaCantidadPermitida()
	}
	
	method maximaCantidadPermitida()
}

object bronce inherits NivelBajo {
	override method maximaCantidadPermitida() {
		return 1
	}
	
	override method puntosNecesarios() {
		return 0
	}
	
	override method actualizarNivel(unUsuario) {
		if(self.puedeSubirDeNivel(unUsuario)) {
			unUsuario.nivel(plata)
		} else {
			unUsuario.nivel(self)
		}
	}
	
	override method puedeSubirDeNivel(unUsuario) {
		return unUsuario.puntos() > plata.puntosNecesarios()
	}
}

object plata inherits NivelBajo {
	override method maximaCantidadPermitida() {
		return 5
	}
	
	override method puntosNecesarios() {
		return 5000
	}
	
	override method actualizarNivel(unUsuario) {
		if(self.puedeSubirNivel(unUsuario)) {
			unUsuario.nivel(oro)
		}
	}
	
	override method puedeSubirNivel(unUsuario) {
		return unUsuario.puntos() > oro.puntosNecesarios()
	}
}

object oro inherits Nivel {
	override method puedeAgregarProducto(unUsuario) {
		return true
	}
	
	override method puntosNecesarios() {
		return 15000
	}
	
	override method actualizarNivel(unUsuario) {
		unUsuario.nivel(oro)
	}
}
