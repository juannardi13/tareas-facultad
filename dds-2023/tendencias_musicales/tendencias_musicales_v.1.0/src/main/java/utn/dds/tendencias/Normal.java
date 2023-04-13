package utn.dds.tendencias;

import utn.dds.catalogo.Cancion;
import utn.dds.helpers.Icono;

public class Normal extends Tendencia {
    private int cantMaxReproduccionesNormal = 1000;
    private int cantReproduccionesInicial;

    public Normal(Cancion cancion) {
        cantReproduccionesInicial = cancion.getCantReproducciones();
    }

    public void reproducir(Cancion cancion) {
        if(this.cantidadReproduccionesEnEstaPopularidad(cancion) > cantMaxReproduccionesNormal) {
            cancion.setPopularidad(new EnAuge(cancion));
        }
    }

    public int cantidadReproduccionesEnEstaPopularidad(Cancion cancion) {
        return cancion.getCantReproducciones() - cantReproduccionesInicial;
    }

    @Override
    protected String mostrarIcono() {
        return Icono.MUSICAL_NOTE.texto();
    }

    @Override
    protected String mostrarLeyenda(Cancion cancion) {
        return cancion.getAutor().getNombre() + cancion.getAlbum().getNombre() + cancion.getTitulo();
    }
}
