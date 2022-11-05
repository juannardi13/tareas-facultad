class Producto {
	var nombre
	var precioBase
	
	method precio() 
	method nombreDeOferta()
}

class ProductoCostoso inherits Producto {
	override method precio() {
		return precioBase * 1.21
	}
	
	override method nombreDeOferta() {
		return "SUPER OFERTA" + nombre
	}
}

class Indumentaria inherits ProductoCostoso {
	
}

class Mueble inherits ProductoCostoso {
	override method precio() {
		return super() + self.recargo()
	}
	
	method recargo() {
		return 1000
	}
}

class Ganga inherits Producto {
	override method precio() {
		return 0
	}
	
	override method nombreDeOferta() {
		return nombre + "COMPRAME POR FAVOR"
	}
}
