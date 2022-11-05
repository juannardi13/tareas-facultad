import posts.*
import categorias.*

object paradigma {
	var usuarios = #{}
	
	method agregarUsuario(unUsuario) {
		usuarios.add(unUsuario)
	}
	
	method recategorizar() {
		usuarios.forEach({ unUsuario => unUsuario.recategorizar() })
	}
}

class Usuario {
	const posts = #{}
	var categoria
	
	method puntaje() {
		return posts.sum({ unPost => unPost.valorPost() })
	}
	
	method escribirPost() {
		categoria.crearPost(self)
	}
	
	method comentarPost(unPost, unComentario) {
		unPost.agregarComentario(unComentario)
	}
	
	method calificarPost(unPost, unaCalificacion) {
		unPost.aumentarCalificacion(unaCalificacion)
	}
	
	method cerrarPost(unPost) {
		if(self.escribio(unPost)) {
			unPost.cerrar()
		}
	}
	
	method escribio(unPost) {
		return posts.contains(unPost)
	}
	
	method agregarPost(unPost) {
		posts.add(unPost)
	}
	
	method postsImportantes() {
		return posts.count({ unPost => unPost.esImportante() })
	}
	
	method recategorizar() {
		if(self.puntaje() < intermedio.puntosNecesarios()) {
			categoria = novato
		}
		
		if(self.puntaje() > intermedio.puntosNecesarios() && self.puntaje() < experto.puntosNecesarios()) {
			categoria = intermedio
		}
		
		if(self.puntaje() > experto.puntosNecesarios() && self.postsImportantes() > experto.postsImportantesNecesarios()) {
			categoria = experto
		}
	}
}

