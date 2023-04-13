package utn.dds.tendencias;

import utn.dds.catalogo.Cancion;
import utn.dds.helpers.Icono;

public class EnAuge extends Tendencia {
    public int cantDislikesInicial;
    public int cantReproduccionesInicial;
    public int cantidadMaxCantidadReproduccionesEnAuge = 50000;
    public int cantidadMaxLikes = 20000;
    public int cantidadMaximaDislikesEnAuge = 5000;

    public EnAuge(Cancion cancion) {
        cantDislikesInicial = cancion.getCantDislikes();
        cantReproduccionesInicial = cancion.getCantReproducciones();
    }

    @Override
    public void reproducir(Cancion cancion) {
        if(this.tieneMasLikesQueLosEsperados(cancion) && this.tieneMasReproduccionesQueLasEsperadas(cancion)) {
            cancion.setPopularidad(new EnTendencia());
        } else {
            if(this.tieneMasDislikesQueLosEsperados(cancion)) {
                cancion.setPopularidad(new Normal(cancion));
            }
        }
    }

    protected String mostrarIcono() {
        return Icono.ROCKET.texto();
    }

    protected String mostrarLeyenda(Cancion cancion) {
        return cancion.getAutor().getNombre() + " - " + cancion.getTitulo() + "(" + cancion.getAlbum().getNombre() + " - " + cancion.getAlbum().getAnio() + ")";
    }

    public int cantidadDislikesEnAuge(Cancion cancion) {
        return cancion.getCantDislikes() - cantDislikesInicial;
    }

    public int cantidadReproduccionesEnAuge(Cancion cancion) {
        return cancion.getCantReproducciones() - cantReproduccionesInicial;
    }

    public Boolean tieneMasLikesQueLosEsperados(Cancion cancion) {
        return cancion.getCantLikes() > cantidadMaxLikes;
    }


    public Boolean tieneMasReproduccionesQueLasEsperadas(Cancion cancion) {
        return this.cantidadReproduccionesEnAuge(cancion) > cantidadMaxCantidadReproduccionesEnAuge;
    }

    public Boolean tieneMasDislikesQueLosEsperados(Cancion cancion) {
        return this.cantidadDislikesEnAuge(cancion) > cantidadMaximaDislikesEnAuge;
    }
}
