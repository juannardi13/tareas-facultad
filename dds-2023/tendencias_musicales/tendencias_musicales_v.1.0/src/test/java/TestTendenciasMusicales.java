import utn.dds.catalogo.Album;
import utn.dds.catalogo.Autor;
import utn.dds.catalogo.Cancion;
import utn.dds.tendencias.EnAuge;
import utn.dds.tendencias.EnTendencia;
import utn.dds.tendencias.Normal;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import utn.dds.tendencias.Tendencia;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

class TestTendenciasMusicales {
    private Cancion cancion;
    private Autor artista;
    private Album album;

    @BeforeEach
    public void init() {
        this.artista = new Autor();
        this.artista.setNombre("coldplay");

        this.album = new Album();
        this.album.setAnio(2002);
        this.album.setNombre("A Rush of Blood to the head\"");

        this.cancion = new Cancion();
        this.cancion.setTitulo("The Scientist");
        this.cancion.setAlbum(this.album);
        this.cancion.setAutor(this.artista);
        this.cancion.setAnio(2002);
    }

    @Test
    @DisplayName("La cancion tiene popularidad normal apenas se lanza")
    public void CancionConDetalleNormalApenasSeLanza() {
        cancion.reproducir();
        String detalle = cancion.getPopularidad().mostrarDetalle(cancion);
        Tendencia primerTendencia = new Normal(cancion);

        Assertions.assertEquals(primerTendencia.mostrarDetalle(cancion), detalle);
    }

    @Test
    @DisplayName("La cancion pasa a estar en auge cuando supera las reproducciones minimas")
    public void CancionEnAugeCuandoSeReproduce() {
        Tendencia normal = new Normal(cancion);
        Tendencia enauge = new EnAuge(cancion);

        for(int i = 1; i < ((Normal) normal).getCantMaxReproduccionesNormal(); i++) {
            cancion.reproducir();
        }

        Assertions.assertEquals(cancion.getPopularidad().mostrarDetalle(cancion), enauge.mostrarDetalle(cancion));
    }
}
