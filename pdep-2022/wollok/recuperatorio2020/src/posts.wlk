class Post {
	var comentarios = []
	var calificacion
	var estado
	
	method agregarComentario(unComentario) {
		estado.agregarComentarios(unComentario, self)
	}
	
	method aumentarCalificacion(unaCantidad) {
		calificacion += unaCantidad
	}
	
	method comentarios() {
		return comentarios
	}
	
	method valorPost() {
		return self.cantidadComentarios() + (calificacion * self.multiplicadorValorSegunTipo())
	}
	
	method cantidadComentarios() {
		return comentarios.size()
	}
	
	method abrir() {
		estado = abierto
	}
	
	method cerrar() {
		estado = cerrado
	}
	
	method esImportante() {
		return self.valorPost() > 500
	}
	
	method multiplicadorValorSegunTipo()
}

class PostNormal inherits Post {
	override method multiplicadorValorSegunTipo() {
		return 1
	}
}

class PostPremium inherits Post {
	override method multiplicadorValorSegunTipo() {
		return 2
	}
}

class Estado {
	method agregarComentarios(unComentario, unPost)
}

object abierto inherits Estado {
	override method agregarComentarios(unComentario, unPost) {
		unPost.comentarios().add(unComentario)
	}
}

object cerrado inherits Estado {
	override method agregarComentarios(unComentario, unPost) {
		throw new Exception(message = "No es posible comentar un post cerrado!")
	}
}
