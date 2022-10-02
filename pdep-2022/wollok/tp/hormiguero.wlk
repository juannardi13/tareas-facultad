import hormigas.*

object hormiguero {
	const hormigas = #{}
	var deposito = 0
	const posicion = 0
	
	method agregarHormiga(unaHormiga) {
		hormigas.add(unaHormiga)
	}
	
	method pedirAlimento() {
		deposito += self.alimentoEnTransporte()
		hormigas.forEach({ unaHormiga => unaHormiga.dejarAlimento() })
	}
	
	method alimentoEnTransporte() {
		return hormigas.sum({ unaHormiga => unaHormiga.cantidadDeAlimento() })
	}
	
	method cantidadDeAlimentoTotal() {
		return self.alimentoEnTransporte() + deposito
	}
	
	method cantidadHormigasAlLimite() {
		return hormigas.count({ unaHormiga => unaHormiga.estaAlLimite() })
	}
	
	method cantidadDeHormigas() {
		return hormigas.size()
	}
	
	method posicion() {
		return posicion
	}
	
	method deposito(){
		return deposito
	}
	
	method distanciaRecorridaHormigas() {
		return hormigas.sum({ unaHormiga => unaHormiga.distanciaRecorrida() })
	}
}
