import usuarios.*
import productos.*

object pdepLibre {
	const usuarios = #{}
	const productos = #{}
	
	method reducirPuntosAMorosos() {
		self.usuariosMorosos().forEach({ unUsuario => unUsuario.bajarPuntos(self.penalizacionPorMoroso()) })
	}
	
	method quitarCuponesUsados() {
		usuarios.forEach({ unUsuario => unUsuario.eliminarCuponesUsados() })
	}
	
	method nombresDeOferta() {
		return productos.map({ unProducto => unProducto.nombreDeOferta() })
	}
	
	method actualizarNiveles() {
		usuarios.forEach({ unUsuario => unUsuario.actualizarNivel() })
	}
	
	method usuariosMorosos() {
		return usuarios.filter({ unUsuario => unUsuario.esMoroso() })
	}
	
	method penalizacionPorMoroso() {
		return 1000
	}
}