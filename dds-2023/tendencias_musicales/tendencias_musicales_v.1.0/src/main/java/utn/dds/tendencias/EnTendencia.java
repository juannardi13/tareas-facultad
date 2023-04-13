package utn.dds.tendencias;

import lombok.Setter;
import utn.dds.catalogo.Cancion;
import utn.dds.helpers.Icono;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@Setter
public class EnTendencia extends Tendencia {
    public static Integer cantHorasSinEscucharParaBajarPopularidad = 24;
    @Setter private LocalDateTime fechaAComparar;

    public LocalDateTime getFechaAComparar() {
        return fechaAComparar == null ? LocalDateTime.now() : this.fechaAComparar;
    }
    @Override
    protected String mostrarIcono() {
        return Icono.FIRE.texto();
    }

    @Override
    protected String mostrarLeyenda(Cancion cancion) {
        return cancion.getTitulo() + " - " + cancion.getAutor().getNombre() + "(" + cancion.getAlbum().getNombre() + cancion.getAlbum().getAnio() + ")";
    }

    @Override
    public void reproducir(Cancion cancion) {
        if(this.hanPasadoMasDeHsDesde( cancion.getUltVezEscuchada(), cantHorasSinEscucharParaBajarPopularidad)) {
            cancion.setPopularidad(new Normal(cancion));
        }
    }
    private Boolean hanPasadoMasDeHsDesde(LocalDateTime fechaHora, int horas) {
        return ChronoUnit.HOURS.between(fechaHora, this.getFechaAComparar()) >= horas;
    }
}
