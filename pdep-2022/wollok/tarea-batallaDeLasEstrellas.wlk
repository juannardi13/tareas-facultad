object pamela {

  var equipamiento = ["Algodon", "Agua oxigenada", "Cinta de Papel", "Cinta de Papel"]
  var energia = 6000
  
  method luchar() {
    energia += 400
  }
  
  method gritoVictoria() {
    return "Acá pasó la Pamela"
  }
  
  method energia() = energia

  method bajarEnergia(unaEnergia) {
    energia -= unaEnergia
  }
  
  method cantidadEquipamiento() {
    self.equipamiento().size()
  }

  method equipamiento() = equipamiento

  method ultimoEquipamiento() {
    return equipamiento.last()
  }
  
  method quitarEquipamiento(unEquipamiento) {
    equipamiento.remove(unEquipamiento)
  }
  
}

object pocardo {

  var equipamiento = ["Guitarra", "Curitas", "Cotonetes"]
  var energia = 5600
  
  method luchar() {
    energia += 500
  }
  
  mthod gritoVictoria() {
    return "¡Siente el poder de la música!"
  }
  
  method energia() = energia
  
  method bajarEnergia(unaEnergia) {
    energia -= unaEnergia
  }
  
  method cantidadEquipamiento() {
    self.equipamiento().size()
  }

  method equipamiento() = equipamiento
  
  method ultimoEquipamiento() {
    return equipamiento.last()
  }
  
  method quitarEquipamiento(unEquipamiento) {
    equipamiento.remove(unEquipamiento)
  }
  
}

Tulipán: La guerrera 🌷. Que su aspecto floral no te haga bajar la guardia ya que es una de las luchadoras más fuertes del juego, teniendo una energía inicial de 8400. 
Cuando está mano a mano con un enemigo, le hace perder el 50% de la energía y, cuando sale victoriosa, grita "Hora de cuidar a las plantas". 
Por si quedaban dudas de que su hobby es la jardinería, en su galpón siempre encontraremos un rastrillo, dos macetas y una manguera.

object tulipan {

  var equipamiento = ["Rastrillo", "Maceta", "Maceta", "Manguera"]
  var energia = 8400
  
  method luchar(rival) {
    rival.bajarEnergia(rival.energia() / 2)
  }
  
  method gritoVictoria() {
    return "Hora de cuidar las plantas"
  }
  
  method energia() = energia
  
  method bajarEnergia(unaEnergia) {
    energia -= unaEnergia
  }
 
  method cantidadEquipamiento() {
    self.equipamiento().size()
  }

  method equipamiento() = equipamiento
  
  method ultimoEquipamiento() {
    return equipamiento.last()
  }
  
  method quitarEquipamiento(unEquipamiento) {
    equipamiento.remove(unEquipamiento)
  }
  
}

Toro: El tanque 🐂. "No se metan con el toro" grita cada vez que sale victorioso este personaje que en cada mano a mano enriquece su botín, 
el cual está vacío al comenzar. El toro es formidable, ya que no solo quita 200 de energía por cada elemento que tengan sus contrincantes, 
sino que además se queda el último (en caso que no lo tenga). Tanto sus habilidades de batallas como sus 7800 puntos de energía inicial lo hacen temible. 

object toro {

  var equipamiento = []
  var energia = 7800
  
  method luchar(rival) {
    rival.bajarEnergia(rival.cantidadEquipamiento() * 200)
    equipamiento.add(rival.ultimoEquipamiento())
    rival.quitarEquipamiento(rival.ultimoEquipamiento())
  }
  
  method gritoVictoria() {
    return "No se metan con el toro"
  }
  
  method energia() = energia
  
  method bajarEnergia(unaEnergia) {
    energia -= unaEnergia
  }
  
  method cantidadEquipamiento() {
    self.equipamiento().size()
  }

  method equipamiento() = equipamiento

}

object arena {

  var equipo1 = #{pamela, toro}
  var equipo2 = #{tulipan, pocardo}
  var luchadores = #{pamela, toro, tulipam, pocardo}
  var equipoGanador = #{}
  
  method pelea() {
      luchadores.forEach({luchador => self.atacarAlOtroEquipo(luchador)})
  }
  
  method equipoGanador() {
    
  }
  
  method energiasEquipo(equipo) {
    return equipo.map({luchador => luchador.energia()}).sum()
  }
  
  method gritosEquipo(equipo) {
    return equipo.map({luchador => luchador.gritoVictoria()})
  }
  
  method atacarAlOtroEquipo(luchador) {
    equipoRival(luchador).forEach({rival => luchador.luchar(rival)})
  }
  
}











