import hormiguero.*
import alimentos.*

class Hormiga {
	var cantidadDeAlimento
	var capacidadAlimento = 10
	var distanciaRecorrida 
	var ubicacion
	const puntosRecorridos
	var estado 
	var distanciaDesdeDescanso 
	
	method cantidadDeAlimento() {
		return cantidadDeAlimento
	}
	
	method estaAlLimite() {
		return cantidadDeAlimento.between(9, 10)
	}
	
	method dejarAlimento() {
		cantidadDeAlimento = 0
		self.viajar(hormiguero)
	}
	
	method viajar(unaUbicacion) {
		if(estado != "Cansada"){
			distanciaRecorrida += unaUbicacion.posicion()
			distanciaDesdeDescanso += unaUbicacion.posicion()
			ubicacion = unaUbicacion
			puntosRecorridos.add(unaUbicacion)
			if(distanciaDesdeDescanso > 5) {
				estado = "Normal"
			}
			if(distanciaDesdeDescanso > 10) {
				estado = "Cansada"
			}
		}
	}
	
	method puntosRecorridos() {
		return puntosRecorridos
	}
	
	method distanciaPromedio() {
		return distanciaRecorrida / self.puntosRecorridos().size()
	}
	
	method distanciaRecorrida() {
		return distanciaRecorrida
	}
	
	method recolectar(unAlimento) {
		if(estado != "Cansada"){
			self.viajar(unAlimento)
			if(unAlimento.masa() > self.cantidadDisponible()){
				unAlimento.extraerAlimento(self.cantidadDisponible())
				cantidadDeAlimento = capacidadAlimento
			} else {
				self.agarrarAlimento(unAlimento.masa())
				unAlimento.masa(0)
			}
		}
	}
	
	method cantidadDisponible() {
		return capacidadAlimento - cantidadDeAlimento
	}
	
	method agarrarAlimento(unaCantidad) {
		cantidadDeAlimento += unaCantidad
	}
	
	method descansar() {
		if(estado == "Cansada") {
			estado = "Normal" 
			distanciaDesdeDescanso = 0
		} else {
			estado = "Exaltada"
			capacidadAlimento = 20
			distanciaDesdeDescanso = 0
		}
	}
}

