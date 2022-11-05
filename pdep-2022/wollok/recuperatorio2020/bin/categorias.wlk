import usuarios.*
import posts.*

class Categoria {
	method postsImportantesNecesarios()
	method puntosNecesarios()
	method crearPost(unUsuario)
}

class CategoriaBase inherits Categoria {
	override method crearPost(unUsuario) {
		unUsuario.agregarPost(new PostNormal(calificacion = 0, estado = abierto))
	}
	
	override method postsImportantesNecesarios() {
		return 0
	}
}

object novato inherits CategoriaBase {
	override method puntosNecesarios() {
		return 0
	}
}

object intermedio inherits CategoriaBase {
	override method puntosNecesarios() {
		return 100
	}
}

object experto inherits Categoria {
	override method puntosNecesarios() {
		return 1000
	}
	
	override method postsImportantesNecesarios() {
		return 1
	}
	
	override method crearPost(unUsuario) {
		unUsuario.agregarPost(new PostPremium(calificacion = 0, estado = abierto))
	}
}