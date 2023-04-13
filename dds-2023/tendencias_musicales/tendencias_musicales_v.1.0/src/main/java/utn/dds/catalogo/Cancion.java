package utn.dds.catalogo;

import lombok.Getter;
import lombok.Setter;
import utn.dds.tendencias.Normal;
import utn.dds.tendencias.Tendencia;

import java.time.LocalDateTime;

@Getter
@Setter
public class Cancion {
    private int anio;
    private String titulo;
    private Autor autor;
    private Album album;
    private int cantDislikes;
    private int cantLikes;
    private int cantReproducciones;
    private Tendencia popularidad;
    private LocalDateTime ultVezEscuchada;

    public Cancion() {
        this.cantReproducciones = 0;
        this.cantLikes = 0;
        this.cantDislikes = 0;
        this.popularidad = new Normal(this);
    }
    public void reproducir() {
        popularidad.mostrarDetalle(this);
        popularidad.reproducir(this);
        this.cantReproducciones++;
    }
}