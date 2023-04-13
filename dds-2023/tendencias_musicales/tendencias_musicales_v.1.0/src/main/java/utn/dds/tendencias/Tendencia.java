package utn.dds.tendencias;

import utn.dds.catalogo.Cancion;

public abstract class Tendencia {

    public String mostrarDetalle(Cancion cancion) {
        return this.mostrarIcono() + " - " + this.mostrarLeyenda(cancion);
    }

    protected abstract String mostrarIcono();
    protected abstract String mostrarLeyenda(Cancion cancion);
    public abstract void reproducir(Cancion cancion);
}
