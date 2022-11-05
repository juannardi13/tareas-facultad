import usuarios.*
import zonas.*

object waza {
	const usuarios = #{}
	const zonas = #{}
	
	method usuariosComplicados() {
		return usuarios.filter({ unUsuario => unUsuario.esComplicado() })
	}
	
	method zonaMasTransitada() {
		return zonas.max({ unaZona => unaZona.transito() })
	}
	
	method cobrarMultas() {
		usuarios.forEach({ unUsuario => unUsuario.pagarMultas() })
	}
}